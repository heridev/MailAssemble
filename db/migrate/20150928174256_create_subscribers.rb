class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email
      t.integer :email_list_id

      t.timestamps null: false
    end
  end
end
