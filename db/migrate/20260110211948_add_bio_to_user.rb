# Extra field for user bio, to be displayed on the profile page
class AddBioToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :bio, :string, default: "", limit: 512
  end
end
