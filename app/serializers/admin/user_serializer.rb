class Admin::UserSerializer < ActiveModel::Serializer
  attributes :name, :phone, :email, :created_at, :roles
end
