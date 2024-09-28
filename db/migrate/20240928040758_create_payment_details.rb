class CreatePaymentDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_details do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :encrypted_credit_card_number
      t.string :full_name
      t.string :expiration
      t.integer :last_four_digits
      t.string :zip_code
      t.integer :payment_type
      t.timestamps
    end
  end
end
