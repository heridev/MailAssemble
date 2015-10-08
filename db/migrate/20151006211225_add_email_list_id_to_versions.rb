class AddEmailListIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :email_list_id, :integer
  end
end
