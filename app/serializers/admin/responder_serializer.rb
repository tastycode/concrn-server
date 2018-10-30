class Admin::ResponderSerializer < ActiveModel::Serializer
  attributes :available
  has_many :zip_fences
end
