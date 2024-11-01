# lib/laanc_api_client/models/operation_statistics_response_dto.rb

module LaancApiClient
  module Models
    class OperationStatisticsResponseDTO
      attr_accessor :count107_aa_submitted, :count107_cancelled, :count107_close,
                    :count107_fc_approved, :count107_fc_denied, :count107_fc_expired,
                    :count107_fc_submitted, :count107_invalid_cancel, :count107_operations_submitted,
                    :count107_rescind_ack, :count107_rescinded, :count44809_aa_submitted,
                    :count44809_cancelled, :count44809_close, :count44809_invalid_cancel,
                    :count44809_operations_submitted, :count44809_rescind_ack,
                    :count44809_rescinded, :count_auto_cancelled, :count_laanc_call_success

      def initialize(attributes = {})
        attributes.each do |key, value|
          setter = key.to_s.gsub(/([a-z])([A-Z])/, '\1_\2').downcase + "="
          self.send(setter, value) if respond_to?(setter)
        end
      end

      def self.from_hash(hash)
        new(
          count107_aa_submitted: hash["count107AaSubmitted"],
          count107_cancelled: hash["count107Cancelled"],
          count107_close: hash["count107Close"],
          count107_fc_approved: hash["count107FcApproved"],
          count107_fc_denied: hash["count107FcDenied"],
          count107_fc_expired: hash["count107FcExpired"],
          count107_fc_submitted: hash["count107FcSubmitted"],
          count107_invalid_cancel: hash["count107InvalidCancel"],
          count107_operations_submitted: hash["count107OperationsSubmitted"],
          count107_rescind_ack: hash["count107RescindAck"],
          count107_rescinded: hash["count107Rescinded"],
          count44809_aa_submitted: hash["count44809AaSubmitted"],
          count44809_cancelled: hash["count44809Cancelled"],
          count44809_close: hash["count44809Close"],
          count44809_invalid_cancel: hash["count44809InvalidCancel"],
          count44809_operations_submitted: hash["count44809OperationsSubmitted"],
          count44809_rescind_ack: hash["count44809RescindAck"],
          count44809_rescinded: hash["count44809Rescinded"],
          count_auto_cancelled: hash["countAutoCancelled"],
          count_laanc_call_success: hash["countLaancCallSuccess"]
        )
      end
    end
  end
end
