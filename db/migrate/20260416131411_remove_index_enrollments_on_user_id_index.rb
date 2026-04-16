# Duplicated index
class RemoveIndexEnrollmentsOnUserIdIndex < ActiveRecord::Migration[8.1]
  def up
    remove_index :enrollments, name: "index_enrollments_on_user_id"
  end
end
