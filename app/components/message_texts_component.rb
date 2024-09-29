# frozen_string_literal: true

class MessageTextsComponent < ViewComponent::Base
  def initialize(user:, message_channel:)
    @user = user
    @messages = message_channel.messages.includes(:user)
  end
end
