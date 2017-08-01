class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable,
          :omniauthable, :validatable
  include DeviseTokenAuth::Concerns::User


  def name
    nickname
  end

  def self.concrn
    find_by(nickname: 'Concrn')
  end
end
