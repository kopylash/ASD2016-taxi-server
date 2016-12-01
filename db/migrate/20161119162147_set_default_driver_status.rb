class SetDefaultDriverStatus < ActiveRecord::Migration
  def change
    change_column :drivers, :status, :integer, :default => 0
  end
end
