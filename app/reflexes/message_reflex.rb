# frozen_string_literal: true

class MessageReflex < ApplicationReflex

    def create
        @message = Message.create(
            content: element.value,
            user_id: element.dataset[:user_id],
            order_id: element.dataset[:order_id]
        )
    end

end
