class AddHstorToFormPermissions < ActiveRecord::Migration
  def change
    add_column :form_permissions, :permissions, :hstore, default: {}
    add_index :form_permissions, :permissions, using: :gin
  end
end
