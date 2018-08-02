class Admin::ReportEventSerializer < ActiveModel::Serializer
  attributes :created_at, :event_type, :payload
end
