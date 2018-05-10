class PointFence < ApplicationRecord
  belongs_to :fenceable, polymorphic: true
end
