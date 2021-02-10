class CreateDivingLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :diving_logs do |t|
      t.integer :dive_number
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :point
      t.string :entry
      t.datetime :entry_time
      t.datetime :exit_time
      t.integer :entry_bar
      t.integer :exit_bar
      t.float :air_temperature
      t.float :water_temperature
      t.string :condition
      t.integer :transparency
      t.float :ave_depth
      t.float :max_depth
      t.string :equipment
      t.text :comment
      t.boolean :published, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :diving_logs, [:user_id, :entry_time]
  end
end
