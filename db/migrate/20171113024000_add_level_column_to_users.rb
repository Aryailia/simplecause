class AddLevelColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :level, :integer
  end
end