class SubscriberSerializer < ActiveModel::Serializer
  attributes :name,
             :created_at,
             :id,
             :email

  def created_at
    I18n.localize object.created_at, format: :subscriber_since
  end
end

