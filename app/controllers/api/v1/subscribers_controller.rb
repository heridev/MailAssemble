class Api::V1::SubscribersController < Api::BaseController

  before_action :find_email_list
  before_action :find_subscriber, except: [:index, :create, :validate_email_uniqueness]

  PER_PAGE_RECORDS = 100

  def index
    page_count = params[:page_count].try(:to_i) || 1
    subscribers = @email_list.subscribers
                             .page(page_count)
                             .per(PER_PAGE_RECORDS)
                             .order('created_at DESC')

    serialized_data = serialize_data(subscribers,
                                    SubscriberSerializer,
                                    root: false)

    render_json_dump(subscribers: serialized_data,
                     page_count: page_count,
                     tot_subscribers: subscribers.total_count,
                     tot_pages: subscribers.total_pages)
  end

  def create
    subscriber = @email_list.subscribers.create(subscriber_params)

    if subscriber.valid?
      render_serialized(subscriber, SubscriberSerializer, root: false)
    else
      render_error_object(subscriber.errors.messages)
    end
  end

  def show
    render_serialized(@subscriber, SubscriberSerializer, root: false)
  end

  def update
    if @subscriber.update(subscriber_params)
      render_serialized(@subscriber, SubscriberSerializer, root: false)
    else
      render_error_object(@subscriber.errors.messages)
    end
  end

  def destroy
    if @subscriber.destroy
      version = @subscriber.versions.last
      render_serialized(version, VersionSerializer, root: false)
    else
      render_with_error('An error occured while deleting the subscriber')
    end
  end

  def validate_email_uniqueness
    already_exists = @email_list.subscribers
                                .where(email: params[:email])
                                .exists?
    if already_exists
      render_with_error('That email is already added in the list')
    else
      render_json_message('Email list was deleted successfully')
    end
  end

  def validate_email
    already_exists = @email_list.subscribers
                                .where(email: params[:email])
                                .where("id <> #{@subscriber.id}")
                                .exists?
    if already_exists
      render_with_error('That email is already added in the list')
    else
      render_json_message('Email list was deleted successfully')
    end
  end

  private

    def find_email_list
      uuid = params['email_uuid']
      @email_list = EmailList.find_by(secure_key: uuid)
    end

    def find_subscriber
      id = params['id']
      @subscriber = @email_list.subscribers.find(id)
    end

    def subscriber_params
      params.require(:subscriber)
            .permit(
              :name,
              :email
            )
    end
end

