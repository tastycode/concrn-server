module Admin
  class Controller < ApplicationController
    DEFAULT_SORT = "created_at desc"
    before_action :require_auth

    def require_admin
      authorized_role = (%w(admin affiliate_admin affiliate_dispatcher).include?(current_user.role))
      head :forbidden unless authorized_role
    end

    def jsonapi_index_response(scope:, url_method:, serializer: nil, serializer_options: default_serializer_options)
      serializer ||= default_serializer(model: scope.model)
      json = JSON.parse(
        ActiveModelSerializers::SerializableResource.new(
          scope,
          each_serializer: serializer,
          **serializer_options
        ).to_json
      )
      pagination = JsonPagination.paginate(
        scope: scope,
        url_method: url_method,
        page_number: params[:page][:number] || 1,
        page_size: params[:page][:size] || 10
      )
      json.merge(pagination)
    end

    def default_index
      url_method ||= "admin_#{default_model.to_s.underscore.pluralize}_url"
      records = default_scope.order(DEFAULT_SORT)
      render json: jsonapi_index_response(
        scope: records,
        url_method: url_method
      )
    end

    def default_update
      record = default_scope.find(params[:id])
      record.update_attributes(record_params)
      if record.valid?
        render json: record, serializer: default_serializer(model: default_model)
      else
        respond_with_errors(record)
      end
    end

    def default_create
      record = default_model.create(record_params)
      if record.valid?
        render json: record, serializer: default_serializer(model: default_model)
      else
        respond_with_errors(record)
      end
    end

    def default_show
      record = default_scope.find(params[:id])
      render json: record, serializer: default_serializer(model: default_model), **default_serializer_options
    end

    def default_destroy
      record = default_scope.find(params[:id])
      record.destroy
      head :no_content
    end

    def default_serializer(model: default_model)
      self.class.const_get("Admin::#{model}Serializer")
    end

    def default_serializer_options
      (self.class.const_defined?(:SERIALIZER_OPTIONS) && self.class.const_get(:SERIALIZER_OPTIONS)) || ({})
    end

    def default_model
      self.class.const_get(:MODEL)
    end

    def default_scope
      default_model.all
    end

    def record_params
      params.require('data').permit('attributes' => permitted_params)
    end

    def permitted_params
      self.class.const_get(:PERMITTED_PARAMS)
    end

    def self.default_actions(actions = %i(create show update index destroy))
      actions.each do |action|
        define_method(action) do
          send("default_#{action}")
        end
      end
    end
  end
end
