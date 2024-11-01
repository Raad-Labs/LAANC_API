# spec/laanc_api_client/client_spec.rb

require 'spec_helper'

RSpec.describe LaancApiClient::Client do
  let(:client) { described_class.new(jwt_token: "test_jwt_token") }

  describe "#initialize" do
    it "sets the base_url and api_version correctly" do
      expect(client.base_url).to eq(LaancApiClient::Client::DEFAULT_BASE_URL)
      expect(client.api_version).to eq(LaancApiClient::Client::DEFAULT_API_VERSION)
    end

    it "sets the JWT token correctly" do
      expect(client.jwt_token).to eq("test_jwt_token")
    end
  end

  # Add more tests for each method
end
