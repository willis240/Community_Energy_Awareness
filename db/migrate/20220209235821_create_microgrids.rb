class CreateMicrogrids < ActiveRecord::Migration[7.0]
  def change
    create_table :microgrids do |t|
      t.string :name
      t.integer :total_load
      t.integer :wind
      t.decimal :wind_percentage
      t.integer :solar
      t.decimal :solar_percentage
      t.integer :battery
      t.decimal :battery_percentage
      t.integer :diesel
      t.decimal :diesel_percentage

      t.timestamps
    end
  end
end
