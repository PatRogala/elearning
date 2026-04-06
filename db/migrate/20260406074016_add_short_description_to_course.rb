# We need a short description for the course
# it will be used in the course card
class AddShortDescriptionToCourse < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :short_description, :string, limit: 255
  end
end
