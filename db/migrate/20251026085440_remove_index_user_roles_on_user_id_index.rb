# Deuplicated index
class RemoveIndexUserRolesOnUserIdIndex < ActiveRecord::Migration[8.1]
  def up
    remove_index "user_roles", name: "index_user_roles_on_user_id"
  end

  def down
    add_index "user_roles", "user_id"
  end
end
