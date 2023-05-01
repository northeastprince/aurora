class CreateAuras < ActiveRecord::Migration[7.1]
  def change
    create_table :auras do |t|
      t.references :user

      t.string :zip_code, index: true
      t.integer :temperature_in_fahrenheit, index: true

      t.text :content

      t.timestamp :delivered_at, index: true

      t.timestamps
    end
  end
end
