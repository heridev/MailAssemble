class CreateFormPermissions < ActiveRecord::Migration
  def change
    create_table :form_permissions do |t|
      t.string :name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
