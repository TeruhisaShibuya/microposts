class AddEditToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :string
    add_column :users, :sex, :string
    add_column :users, :region, :string
    add_column :users, :hobby, :string
  end
end
