module Admin
  class ReportsController < Admin::Controller
    def index
      reports = Report.all.order("created_at desc")
      json = JSON.parse(
        ActiveModelSerializers::SerializableResource.new(
          reports, 
          each_serializer: Admin::ReportSerializer,
          include: ['reporter.user']
        ).to_json
      )
      pagination = JsonPagination.paginate(
        scope: reports,
        url_method: :admin_reports_url,
        page_number: params[:page][:number] || 1,
        page_size: params[:page][:size] || 10)
      render json: json.merge(pagination)
    end
  end
end
