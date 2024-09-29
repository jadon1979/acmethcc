class MakeOrderNullableInMessage < ActiveRecord::Migration[7.0]
  def change
    change_column_null :messages, :order_id, true
  end
end
