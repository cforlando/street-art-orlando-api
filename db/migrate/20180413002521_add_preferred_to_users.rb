class AddPreferredToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :preferred, :bool, default: false
  end
end
