class Api::V1::FollowUpsController < Api::BaseController

  before_action :find_email_list
  before_action :find_follow_up, except: [:index, :create, :sort]

  def index
    follow_ups = @email_list.follow_ups.order('position ASC')
    render_serialized(follow_ups, FollowUpSerializer, root: false)
  end

  def create
    follow_up = @email_list.follow_ups.create(follow_up_params)

    if follow_up.valid?
      render_serialized(follow_up, FollowUpSerializer, root: false)
    else
      render_error_object(follow_up.errors.messages)
    end
  end

  def show
    render_serialized(@follow_up, FollowUpSerializer, root: false)
  end

  def update
    if @follow_up.update(follow_up_params)
      render_serialized(@follow_up, FollowUpSerializer, root: false)
    else
      render_error_object(@follow_up.errors.messages)
    end
  end

  def destroy
    if @follow_up.destroy
      render_serialized(@follow_up, FollowUpSerializer, root: false)
    else
      render_with_error('An error occured while deleting the follow up message')
    end
  end

  def destroy_send_window
    if @follow_up && @follow_up.send_windows.find(params[:send_window_id]).destroy
      render_json_message('The send window was deleted successfully')
    else
      render_with_error('An error occured while deleting the follow up message')
    end
  end

  def sort
    element_ids = params[:element_ids]
    if element_ids && FollowUp.reorder_position(element_ids)
      render_json_message('The elements were updated successfullly')
    else
      render_with_error('The element was not found')
    end
  end

  private

    def find_email_list
      uuid = params['email_uuid']
      @email_list = EmailList.find_by(secure_key: uuid)
    end

    def find_follow_up
      id = params['id']
      @follow_up = @email_list.follow_ups.find(id)
    end

    def follow_up_params
      params.require(:follow_up)
            .permit(
              :title,
              :content,
              :days_to_be_sent_after_previous,
              :time_to_be_sent,
              :email,
              :send_windows_attributes => [
                :id,
                :sunday,
                :monday,
                :tuesday,
                :wednesday,
                :thursday,
                :friday,
                :saturday,
                :_destroy,
                :hour
              ]
            )
    end
end

