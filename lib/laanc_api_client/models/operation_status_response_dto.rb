# lib/laanc_api_client/models/operation_status_response_dto.rb

module LaancApiClient
  module Models
    class OperationStatusResponseDTO
      attr_accessor :status, :submission_category, :submission_date_time, :submission_type,
                    :ack_rescind_date_time, :approval_date_time, :cancel_date_time,
                    :change_date_time, :close_date_time, :denial_date_time, :rescind_date_time

      def initialize(attributes = {})
        attributes.each do |key, value|
          setter = key.to_s.gsub(/([a-z])([A-Z])/, '\1_\2').downcase + "="
          self.send(setter, value) if respond_to?(setter)
        end
      end

      def self.from_hash(hash)
        new(
          status: hash["status"],
          submission_category: hash["submissionCategory"],
          submission_date_time: hash["submissionDateTime"],
          submission_type: hash["submissionType"],
          ack_rescind_date_time: hash["ackRescindDateTime"],
          approval_date_time: hash["approvalDateTime"],
          cancel_date_time: hash["cancelDateTime"],
          change_date_time: hash["changeDateTime"],
          close_date_time: hash["closeDateTime"],
          denial_date_time: hash["denialDateTime"],
          rescind_date_time: hash["rescindDateTime"]
        )
      end
    end
  end
end
