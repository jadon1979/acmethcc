# frozen_string_literal: true

class MessengerReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def load_messages(channel_id)
    @message_channel = MessageChannel.find(channel_id)

    morph ".messages-list", render(MessageTextsComponent.new(
      user: current_user,
      message_channel: @message_channel)
    )
  end

  def send_message(contents, channel_id)
    channel = MessageChannel.find_or_initialize_by(id: channel_id)

    if current_user.present?
      if channel.new_record?
        channel.initiator = current_user
        channel.status = 'pending'
      elsif channel.responder.nil? && channel.initiator != current_user
        channel.responder = current_user
      end

      message = channel.messages.create({
        message: contents,
        user_id: current_user.id
      })

      if message.persisted?
        morph ".messages-list", render(MessageTextsComponent.new(
          message_channel: channel,
          user: current_user
        ))

        MessageStreamChannel.broadcast_to(channel, render_message(channel_id, message))
      else
        morph ".messages-list", "Unable to send message at this time"
      end
    else
      morph ".messages-list", "You need to log in to send a message."
    end
  end

  private

  def render_message(channel_id, message)
    message_channel = MessageChannel.find(channel_id)

    ApplicationController.render(
      MessageTextsComponent.new(user: current_user, message_channel: message_channel)
    )
  end
end

