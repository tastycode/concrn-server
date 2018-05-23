class AffiliateUser < ApplicationRecord
  belongs_to :affiliate
  belongs_to :user
  validates :user, uniqueness: {
    scope: :affiliate,
    message: "Affiliate User Already exists"
  }
end
