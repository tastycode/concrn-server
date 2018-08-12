require 'twilio-ruby'
module ConcrnServer2
  def self.twilio
    @twilio ||= Twilio::REST::Client.new(
      Secrets.twilio_sid,
      Secrets.twilio_token
    ).tap do |client|
      def client.phone
        ENV['TWILIO_PHONE']
      end
    end
  end
end
