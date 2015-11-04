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
             :follow_ups_count,
             :id

  def follow_ups_count
    object.follow_ups.count
  end

  def subscribers_count
    object.subscribers.count
  end
end

