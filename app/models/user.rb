class User < ApplicationRecord
  has_many :affiliate_users
  has_many :affiliates, through: :affiliate_user
  has_one :reporter
  has_one :responder

  has_secure_token :token
  has_secure_token :refresh_token
  has_secure_password validations: false

  def invalidate_token
    self.update_attributes(token: nil, token_issued_at: nil)
  end

  def self.valid_email_login?(email, password)
    user = find_by(email: email)
    user if user&.authenticate(password)
  end

  def self.valid_phone_login?(phone, password)
    user = find_by(phone: phone)
    user if user&.authenticate(password)
  end

  def regenerate_token_with_expiration
    regenerate_token
    update_attributes(token_issued_at: Time.now)
  end
end
