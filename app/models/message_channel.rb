# == Schema Information
#
# Table name: message_channels
#
#  id             :integer          not null, primary key
#  close_reason   :string
#  message_for    :integer          default("general")
#  messages_count :integer          default(0)
#  status         :integer          default("pending")
#  updated_by     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  initiator_id   :integer
#  message_for_id :integer          default(0)
#  responder_id   :integer
#
# Indexes
#
#  index_message_channels_on_initiator_id  (initiator_id)
#  index_message_channels_on_responder_id  (responder_id)
#
# Foreign Keys
#
#  initiator_id  (initiator_id => users.id)
#  responder_id  (responder_id => users.id)
#
class MessageChannel < ApplicationRecord
  belongs_to :initiator, class_name: 'User', foreign_key: 'initiator_id'
  belongs_to :responder, class_name: 'User', foreign_key: 'responder_id', optional: true
  belongs_to :updater, class_name: 'User', foreign_key: 'updated_by', optional: true

  has_many :messages

  enum status: {
    pending: 0,
    opened: 1,
    closed: 2
  }

  enum message_for: {
    general: 0,
    product_orders: 1,
    website_support: 2
  }

  scope :available_channels, -> {
    where(status: [ :opened, :pending ])
  }
  scope :relevant_channels, -> (user) {
    where("initiator_id = :user_id OR responder_id = :user_id", user_id: user.id)
  }
  scope :latest, -> (user) {
    available_channels
      .joins('LEFT JOIN messages ON messages.message_channel_id = message_channels.id')
      .relevant_channels(user)
      .distinct
      .order('messages.created_at DESC, message_channels.updated_at DESC')
  }

  def open
    update(updated_by: user, status: 1)
  end

  def close(user, reason)
    update(
      updater: user,
      status: 2,
      close_reason: reason
    )
  end
end
