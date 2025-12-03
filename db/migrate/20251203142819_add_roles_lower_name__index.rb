class AddRolesLowerNameIndex < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_index :roles, "lower(name)", name: :index_roles_lower_name_, unique: true, algorithm: :concurrently
  end
end
