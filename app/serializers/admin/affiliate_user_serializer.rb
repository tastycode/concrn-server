class Admin::AffiliateUserSerializer < ActiveModel::Serializer
  attributes :role, :user_id
  belongs_to :affiliate, serializer: Admin::AffiliateSerializer, include_nested_associations: true
  belongs_to :user, serializer: Admin::UserSerializer
end
