class AddPlnPriceToCourse < ActiveRecord::Migration[8.1]
  def change
    add_monetize :courses, :price
  end
end
