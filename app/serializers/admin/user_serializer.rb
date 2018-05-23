class Admin::UserSerializer < ActiveModel::Serializer
  attributes :name, :phone, :email, :created_at, :roles
  has_many :affiliate_users, serializer: Admin::AffiliateUserSerializer
end
