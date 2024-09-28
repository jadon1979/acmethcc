class RemoveCcDetailsFromUsers < ActiveRecord::Migration[7.0]
  def up
    change_table(:users) do |t|
      t.remove :credit_card_number
      t.remove :cvv
      t.remove :expiry
    end
  end

  def down
    change_table(:users) do |t|
      t.string :credit_card_number
      t.string :cvv
      t.string :expiry
    end
  end
end
