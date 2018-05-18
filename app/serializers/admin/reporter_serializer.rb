class Admin::ReporterSerializer < ActiveModel::Serializer
  belongs_to :user, serializer: Admin::UserSerializer, include: true, include_nested_associations: true
end
