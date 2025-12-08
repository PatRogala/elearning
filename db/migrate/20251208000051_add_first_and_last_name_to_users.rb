class AddFirstAndLastNameToUsers < ActiveRecord::Migration[8.1]
  def change
    safety_assured do
      change_table :users, bulk: true do |t|
        t.string :first_name, null: false, default: ""
        t.string :last_name, null: false, default: ""
      end
    end
  end
end
