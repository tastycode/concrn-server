require 'twilio-ruby'
module ConcrnServer2
  def self.twilio
    @twilio ||= Twilio::REST::Client.new(
      Secrets.twilio_sid,
      Secrets.twilio_token
    ).tap do |client|
      def client.responder_phone
        ENV['TWILIO_RESPONDER_PHONE']
      end

      def client.reporter_phone
        ENV['TWILIO_REPORTER_PHONE']
      end
    end
  end
end
