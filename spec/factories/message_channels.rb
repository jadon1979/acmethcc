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
FactoryBot.define do
  factory :message_channel do
    association :initiator
    association :responder
    status { 0 }
    message_for { 0 }
    updated_by { 0 }
    messages_count { 0 }
  end
end
