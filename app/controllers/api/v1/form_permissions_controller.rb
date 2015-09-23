class Api::V1::FormPermissionsController < ActionController::Base

  def index
    form_permissions = current_user.form_permissions.order('created_at DESC')
    render json: form_permissions
  end

  def create
    form_permission = current_user.form_permissions.create(create_params)
    render json: form_permission
  end

  private

    def create_params
      cust_fields = params[:form_permission] && params[:form_permission][:permissions]
      prepared_params = form_permission_params
      prepared_params.merge!({permissions: cust_fields})
      prepared_params
    end

    def form_permission_params
      params.require(:form_permission)
             .permit(:name)
    end
end
