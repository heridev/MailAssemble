class CreateEmailLists < ActiveRecord::Migration
  def change
    create_table :email_lists do |t|
      t.string :name
      t.integer :user_id
      t.string :default_from
      t.string :default_from_name
      t.text :remind_people_message
      t.string :company_organization
      t.string :address
      t.string :city
      t.string :country
      t.string :state_province
      t.string :phone
      t.string :secure_key
      t.string :thank_you_page_url
      t.string :already_subscribed_url

      t.timestamps null: false
    end
  end
end
