class Api::V1::EmailListsController < Api::BaseController

  def index
    email_lists = current_user.email_lists.order('created_at DESC')
    render_serialized(email_lists, EmailListSerializer, root: false)
  end

  def create
    email_list = current_user.email_lists.create(email_list_params)

    if email_list.valid?
      render_serialized(email_list, EmailListSerializer, root: false)
    else
      render_error_object(email_list.errors.messages)
    end
  end

  def show
    email_list = current_user.email_lists.find(params[:id])
    render_serialized(email_list, EmailListSerializer, root: false)
  end

  def update
    email_list = current_user.email_lists.find(params[:id])

    if email_list.update(email_list_params)
      render_serialized(email_list, EmailListSerializer, root: false)
    else
      render_error_object(email_list.errors.messages)
    end
  end

  def destroy
    email_list = current_user.email_lists.find(params[:id])

    if email_list.destroy
      render_json_message('Email list was deleted successfully')
    else
      render_with_error('An error occured while deleting the email list')
    end
  end

  private

    def email_list_params
      params.require(:email_list)
            .permit(
              :name,
              :default_from,
              :default_from_name,
              :remind_people_message,
              :company_organization,
              :city,
              :country,
              :state_province,
              :phone,
              :address,
              :thank_you_page_url,
              :already_subscribed_url
            )
    end
end

