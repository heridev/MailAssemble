class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
      t.text :title
      t.integer :days_to_be_sent_after_previous, default: 1
      t.datetime :time_to_be_sent
      t.text :content
      t.integer :email_list_id
      t.integer :position

      t.timestamps null: false
    end
  end
end
