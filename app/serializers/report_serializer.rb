class ReportSerializer < ActiveModel::Serializer
  attributes :id, :lat, :long, :reporter_notes, :address, :status
end
