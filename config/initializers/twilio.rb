require 'twilio-ruby'
module ConcrnServer2
  def self.twilio
    @twilio ||= Twilio::REST::Client.new(
      Rails.application.secrets.twilio[:sid],
      Rails.application.secrets.twilio[:token]
    ).tap do |client|
      def client.phone
        ENV['TWILIO_PHONE']
      end
    end
  end
end
