class AddAdminToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :admin, :boolean, default: false
    # make sure that if a user doesn't pass in the admin field, it defaults to false
  end
end
