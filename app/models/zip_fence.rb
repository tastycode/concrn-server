class ZipFence < ApplicationRecord
  belongs_to :fenceable, polymorphic: true
end
