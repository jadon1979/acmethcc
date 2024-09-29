# frozen_string_literal: true

class MessengerComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def message_channels
    @message_channels ||= MessageChannel.latest(@user)
  end
end
