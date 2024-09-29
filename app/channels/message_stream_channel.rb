class MessageStreamChannel < ApplicationCable::Channel
  def subscribed
    stream_for message_channel
  end

  def unsubscribed
    stop_stream_from message_channel
  end

  private

  def message_channel
    "message_channel_#{params[:id]}"
  end
end