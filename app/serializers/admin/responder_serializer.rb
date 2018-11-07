class Admin::ResponderSerializer < ActiveModel::Serializer
  attributes :available
  belongs_to :user, serializer: Admin::UserSerializer, include: true, include_nested_associations: true
  has_many :zip_fences
end
