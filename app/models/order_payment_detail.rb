# == Schema Information
#
# Table name: order_payment_details
#
#  id                :integer          not null, primary key
#  status            :integer
#  total             :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_id          :integer          not null
#  payment_detail_id :integer          not null
#
# Indexes
#
#  index_order_payment_details_on_order_id           (order_id)
#  index_order_payment_details_on_payment_detail_id  (payment_detail_id)
#
# Foreign Keys
#
#  order_id           (order_id => orders.id)
#  payment_detail_id  (payment_detail_id => payment_details.id)
#
class OrderPaymentDetail < ApplicationRecord
  belongs_to :order
  belongs_to :payment_detail

  scope :by_order, -> (order_id) { where(order_id: order_id) }

  enum status: {
    declined: 0,
    approved: 1
  }
end
