class FollowUpSerializer < ActiveModel::Serializer
  attributes :title,
             :content,
             :days_to_be_sent_after_previous,
             :position,
             :first_in_email_list,
             :id

  has_many :send_windows,
           serializer: SendWindowSerializer,
           root: :send_windows_attributes

  def send_windows
    object.send_windows.order('created_at DESC')
  end

  def first_in_email_list
    object.is_first_in_email_list?
  end
end

