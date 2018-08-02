class Admin::ZipFencesController < Admin::Controller
  MODEL = ZipFence
  PERMITTED_PARAMS = %i(zip fenceable_id fenceable_type)
  default_actions

  def index
    fence_klass = "#{params[:filter][:fenceable_type].titleize}".constantize
    fenceable = fence_klass.find(params[:filter][:fenceable_id])
    records = fenceable.zip_fences
    render json: jsonapi_index_response(
      scope: records,
      url_method: "admin_zip_fences_url"
    )
  end
end
