import ApplicationController from "controllers/application_controller"
import consumer from "../channels/consumer";

export default class extends ApplicationController {
  static targets = ["window", "messageContainer", "content", "channelId"];

  connect() {
    super.connect()

    this.subscription = consumer.subscriptions.create(
      { channel: "MessageStreamChannel", id: this.data.get("channelId") },
      { received: (data) => { this.appendMessage(data.message) } }
    );
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

  selectChannel(event) {
    event.preventDefault();
    const channelId = event.currentTarget.dataset.channelId;
    this.channelIdTarget.value = channelId;

    this.loadMessages(channelId);
  }

  loadMessages(channelId) {
    this.stimulate('Messenger#load_messages', channelId).then(() => {
      const messageList = this.element.querySelector('.messages-list');
      messageList.scrollTop = messageList.scrollHeight;
    })
  }

  submitMessage(event) {
    event.preventDefault();

    const channelId = this.channelIdTarget.value;
    const content = this.contentTarget.value;

    this.stimulate('Messenger#send_message',
      content,
      channelId
    ).then(() => {
      const messageList = this.element.querySelector('.messages-list');
      messageList.scrollTop = messageList.scrollHeight;
    })
  }
}
