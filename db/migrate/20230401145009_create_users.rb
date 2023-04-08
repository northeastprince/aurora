class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :phone_number, null: false, index: { unique: true }
      t.string :zip_code, index: true

      t.timestamps
    end
  end
end
