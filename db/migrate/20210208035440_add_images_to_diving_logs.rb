class AddImagesToDivingLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :diving_logs, :images, :string
  end
end
