class AddBackgroundToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :backgroundimage, :string
  end
end
