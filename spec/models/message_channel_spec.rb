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
require 'rails_helper'

RSpec.describe MessageChannel, type: :model do
  let(:message_channel) { create(:message_channel) }
  let(:user) { message_channel.initiator }
  let(:other_user) { create(:user) }

  context 'statuses' do
    it 'should initialize as pending' do
      expect(message_channel.status).to eq('pending')
    end

    it 'should open when messaged by another user' do

    end

    it 'should close the message channel' do
      message_channel.close(other_user, 'Resolved all issues')
      expect(message_channel.status).to eq('closed')
      expect(message_channel.updater).to eq(other_user)
    end
  end

  context 'latest relevant channels' do
    let(:initiator) { create(:initiator) }
    let(:responder) { create(:responder) }

    before do
      create(:message_channel, initiator: initiator, responder: responder, status: 1 )
      create(:message_channel, initiator: create(:user), responder: responder, status: 1 )
    end

    it 'should have a channel for the (user)' do
      expect(MessageChannel.latest(initiator).count).to eq(1)
    end

    it 'should have 2 channels for the (responder)' do
      channels = MessageChannel.latest(responder)
      expect(channels.count).to eq(2)
    end
  end
end
