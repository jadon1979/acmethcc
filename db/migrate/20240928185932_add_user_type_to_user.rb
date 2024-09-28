class AddUserTypeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_type, :integer, default: 0
    remove_column :users, :is_doctor, :boolean
  end
end
