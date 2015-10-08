class EmailListSerializer < ActiveModel::Serializer
  attributes :name,
             :default_from,
             :default_from_name,
             :remind_people_message,
             :company_organization,
             :city,
             :country,
             :state_province,
             :phone,
             :created_at,
             :address,
             :secure_key,
             :thank_you_page_url,
             :already_subscribed_url,
             :subscribers_count,
             :id

  def subscribers_count
    object.subscribers.count
  end
end

