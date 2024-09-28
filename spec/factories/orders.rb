# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  order_items :string
#  total       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  doctor_id   :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_orders_on_doctor_id  (doctor_id)
#  index_orders_on_user_id    (user_id)
#
# Foreign Keys
#
#  doctor_id  (doctor_id => users.id)
#  user_id    (user_id => users.id)
#
FactoryBot.define do
  factory :order do
    user
    doctor
    order_items {
      [{
        name: Faker::ElectricalComponents.electromechanical,
        dosage: "#{rand(1..4)} troche",
        quantity: rand(1..4),
        instructions: Faker::Lorem.sentence,
        price: Faker::Commerce.price
      }]
    }
    total { Faker::Commerce.price }
    messages
  end
end
