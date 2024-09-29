class AddMessageChannelToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :message_channel_id, :integer, null: false, foreign_key: true
  end
end
