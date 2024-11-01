require 'faraday'
require 'faraday_middleware'
require 'json'

module LaancApiClient
  class Client
    attr_accessor :base_url, :api_version, :public_key_cache

    DEFAULT_BASE_URL = "https://api.laanc.faa.gov"
    DEFAULT_API_VERSION = "v4"

    attr_accessor :jwt_token

    def initialize(base_url: DEFAULT_BASE_URL, api_version: DEFAULT_API_VERSION, jwt_token: nil)
      @base_url = base_url
      @api_version = api_version
      @public_key_cache = {}
      @jwt_token = jwt_token
      @connection = Faraday.new(url: @base_url) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.headers['Authorization'] = "FAALAANC #{@jwt_token}" if @jwt_token
        faraday.adapter Faraday.default_adapter
      end
    end

   def verify_jwt(token)
      header = JWT.decode(token, nil, false).first
      kid = header['kid']
      public_key_data = fetch_public_key(kid)

      # Construct the public key
      public_key = OpenSSL::PKey::RSA.new(Base64.decode64(public_key_data['n']))
      algorithm = public_key_data['alg']

      # Decode and verify the token
      decoded_token = JWT.decode(token, public_key, true, { algorithm: algorithm })

      decoded_token
    rescue JWT::DecodeError => e
      raise LaancApiClient::AuthenticationError, "Invalid JWT: #{e.message}"
    end

    # Method to update JWT token after initialization
    def update_jwt_token(new_jwt_token)
      @jwt_token = new_jwt_token
      @connection.headers['Authorization'] = "FAALAANC #{@jwt_token}"
    end

    def initialize(base_url: DEFAULT_BASE_URL, api_version: DEFAULT_API_VERSION)
      @base_url = base_url
      @api_version = api_version
      @public_key_cache = {}
      @connection = Faraday.new(url: @base_url) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    # Fetch public key by kid
    def fetch_public_key(kid)
      return @public_key_cache[kid] if @public_key_cache.key?(kid)

      response = @connection.get("/oauth/v4/key") do |req|
        req.params['kid'] = kid
      end

      handle_response(response)

      key_data = response.body
      @public_key_cache[kid] = key_data
    rescue LaancApiClient::Error => e
      raise e
    end

    # Get operation statistics
    def get_operation_statistics(datetime_start:, datetime_end:, facility: nil)
      response = @connection.get("/api/ext/#{@api_version}/operationstatistics") do |req|
        req.params['datetimeStart'] = datetime_start
        req.params['datetimeEnd'] = datetime_end
        req.params['facility'] = facility if facility
      end

      handle_response(response)

      Models::OperationStatisticsResponseDTO.from_hash(response.body)
    rescue LaancApiClient::Error => e
      raise e
    end

    # Get operation status
    def get_operation_status(reference_number:)
      response = @connection.get("/api/ext/#{@api_version}/operationstatus/#{reference_number}")
      
      handle_response(response)

      Models::OperationStatusResponseDTO.from_hash(response.body)
    rescue LaancApiClient::Error => e
      raise e
    end

    # Get system health status
    def get_system_status
      response = @connection.get("/api/ext/#{@api_version}/status")
      
      handle_response(response)

      Models::HealthStatusResponseDTO.from_hash(response.body)
    rescue LaancApiClient::Error => e
      raise e
    end

    # Add more methods as needed for other endpoints

    private

    def handle_response(response)
      case response.status
      when 200
        # Success
        return
      when 400
        raise LaancApiClient::BadRequestError, parse_error(response)
      when 401
        raise LaancApiClient::AuthenticationError, parse_error(response)
      when 403
        raise LaancApiClient::ForbiddenError, parse_error(response)
      when 404
        raise LaancApiClient::NotFoundError, parse_error(response)
      when 410
        raise LaancApiClient::GoneError, parse_error(response)
      when 500
        raise LaancApiClient::InternalServerError, parse_error(response)
      else
        raise LaancApiClient::Error, "Unexpected response status: #{response.status}"
      end
    end

    def parse_error(response)
      if response.body.is_a?(Array)
        response.body.map { |error| error['message'] }.join(", ")
      elsif response.body['message']
        response.body['message']
      else
        "Unknown error"
      end
    end
  end
end