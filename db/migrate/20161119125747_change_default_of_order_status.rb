class ChangeDefaultOfOrderStatus < ActiveRecord::Migration
  def change
    change_column :orders, :completed, :boolean, :default => false
  end
end
