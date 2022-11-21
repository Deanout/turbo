class AddCounterToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :counter, :integer
  end
end
