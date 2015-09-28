class Api::V1::EmailListsController < Api::BaseController
  respond_to :html, :json, :xml
  before_action :find_email_list, only: :add_public_subscriber

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

  def add_public_subscriber
    if @email_list
      valid_email_list
    else
      @errors = 'Invalid email list'
    end
  end

  private

    def valid_email_list
      email = params['subscribe_email']
      name = params['subscribe_name_input']
      redirect_subscribed = params['already_subscribed_page']

      subscribe_params = {
        email_list_id: @email_list.try(:id),
        name: name,
        email: email
      }

      if Subscriber.where(email: email).exists?
        redirect_to redirect_subscribed
      else
        handle_subscriber_creation(subscribe_params)
      end
    end

    def handle_subscriber_creation(values)
      redirect = params['thank_you_page']

      subscriber = Subscriber.create(values)

      if subscriber.valid?
        redirect_to redirect
      else
        @errors = 'Email is required'
      end
    end

    def find_email_list
      uuid = params['email_uuid']
      @email_list = EmailList.find_by(secure_key: uuid)
    end

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

