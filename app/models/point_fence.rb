class PointFence < ApplicationRecord
  belongs_to :fenceable, polymorphic: true

  def lat=(lat)
    coordinates.x = lat
  end

  def long=(long)
    coordinates.y = long
  end

  def coordinates
    super || ActiveRecord::Point.new.tap do |point|
      write_attribute(:coordinates, point)
    end
  end
end
