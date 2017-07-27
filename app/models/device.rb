class Device < ApplicationRecord
  belongs_to :reporter

  def verify
    update_attributes(verified: true)
  end
end
