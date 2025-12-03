class UserRolesCascade < ActiveRecord::Migration[8.1]
  def change
    safety_assured do
      remove_foreign_key :user_roles, :roles
      remove_foreign_key :user_roles, :users
      add_foreign_key :user_roles, :roles, on_delete: :cascade
      add_foreign_key :user_roles, :users, on_delete: :cascade
    end
  end
end
