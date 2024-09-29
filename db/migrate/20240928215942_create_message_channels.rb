class CreateMessageChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :message_channels do |t|
      t.references :initiator, null: true, foreign_key: { to_table: 'users' }
      t.references :responder, null: true, foreign_key: { to_table: 'users' }
      t.integer :status, default: 0
      t.integer :message_for, default: 0
      t.integer :message_for_id, default: 0
      t.integer :updated_by
      t.string :close_reason
      t.integer :messages_count, default: 0
      t.timestamps
    end
  end
end
