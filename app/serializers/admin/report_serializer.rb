module Admin
  class ReportSerializer < ::ReportSerializer
    attributes :responder_reporter_notes
    belongs_to :reporter, serializer: Admin::ReporterSerializer, include_nested_associations: true
    belongs_to :responder
  end
end
