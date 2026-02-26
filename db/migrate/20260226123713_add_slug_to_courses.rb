# Slugs for friendly URLs
class AddSlugToCourses < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_column :courses, :slug, :string
    add_index :courses, :slug, unique: true, algorithm: :concurrently
  end
end
