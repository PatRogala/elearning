# Add index for the slug column and uniqueness
class AddLessonsSlugIndex < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_index :lessons, :slug, name: :index_lessons_slug, unique: true, algorithm: :concurrently
  end
end
