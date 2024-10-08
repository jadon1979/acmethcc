class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: { to_table: 'users' }
      t.string :order_items
      t.decimal :total

      t.timestamps
    end
  end
end
