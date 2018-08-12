class Secrets
  class << self
    def method_missing(sym)
      key = sym.to_s.upcase
      if Rails.env.test? || Rails.env.development?
        Rails.application.secrets[key.to_sym]
      else
        ENV[key]
      end
    end
  end
end
