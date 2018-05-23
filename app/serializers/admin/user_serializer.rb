class Admin::UserSerializer < ActiveModel::Serializer
  attributes :name, :phone, :email, :created_at, :role, :affiliate_role
  belongs_to :affiliate
end
