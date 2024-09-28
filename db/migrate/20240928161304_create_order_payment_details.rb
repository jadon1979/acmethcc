class CreateOrderPaymentDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_payment_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :payment_detail, null: false, foreign_key: true
      t.decimal :total
      t.integer :status

      t.timestamps
    end
  end
end
