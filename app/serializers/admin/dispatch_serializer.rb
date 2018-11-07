class Admin::DispatchSerializer < ActiveModel::Serializer
  attributes :created_at, :user_id, :responder_id, :status, :dispatch_type, :report_id
  belongs_to :responder, serializer: Admin::ResponderSerializer, include_nested_associations: true
  belongs_to :report
end
