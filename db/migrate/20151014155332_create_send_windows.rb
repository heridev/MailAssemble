class CreateSendWindows < ActiveRecord::Migration
  def change
    create_table :send_windows do |t|
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.string :hour
      t.integer :follow_up_id
      t.integer :hour_in_minutes

      t.timestamps null: false
    end
  end
end
