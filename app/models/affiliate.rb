class Affiliate < ApplicationRecord
  has_many :users
  has_many :zip_fences, as: :fenceable, autosave: true

end
