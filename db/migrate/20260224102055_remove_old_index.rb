# Remove duplicated index, we use lower(name) index instead
class RemoveOldIndex < ActiveRecord::Migration[8.1]
  def change
    remove_index :roles, :name, if_exists: true
  end
end
