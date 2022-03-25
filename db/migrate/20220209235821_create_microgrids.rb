class CreateMicrogrids < ActiveRecord::Migration[7.0]
  def change
    create_table :microgrids do |t|
      t.string :name
      t.integer :total_load
      t.integer :total_input
      t.integer :frequency
      t.integer :wind
      t.integer :solar
      t.integer :battery
      t.integer :diesel

      t.timestamps
    end
  end
end
