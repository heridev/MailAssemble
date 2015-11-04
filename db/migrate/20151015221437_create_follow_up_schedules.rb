class CreateFollowUpSchedules < ActiveRecord::Migration
  def change
    create_table :follow_up_schedules do |t|
      t.integer :follow_up_id
      t.integer :subscriber_id
      t.string  :state
      t.datetime :run_at

      t.timestamps null: false
    end
  end
end
