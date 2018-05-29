class Responder < ApplicationRecord
  belongs_to :user
  has_many :point_fences, as: :fenceable
  has_many :zip_fences, as: :fenceable
end
