class ReportSerializer < ActiveModel::Serializer
  attributes :id, :coordinates, :reporter_notes, :address, :status, :created_at
end
