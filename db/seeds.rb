# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Password comes from the :user factory.
# Since this will never see a production environment then the password is "Password1!"
user = FactoryBot.create(:user, email: 'user@example.com', user_type: User.user_types['user'])
doctor = FactoryBot.create(:user, email: 'doctor@example.com', user_type: User.user_types['doctor'])
support = FactoryBot.create(:user, email: 'support@example.com', user_type: User.user_types['customer_care'])

order = FactoryBot.create(:order, user: user, doctor: doctor)
payment_detail = FactoryBot.create(:payment_detail, user: user)
FactoryBot.create(:order_payment_detail, order: order, payment_detail: payment_detail)

channel = FactoryBot.create(
  :message_channel,
  initiator: user,
  responder: doctor,
  message_for: 1,
  message_for_id: order.id
)

FactoryBot.create(:message,
  user: user,
  message_channel: channel,
  message: 'Can I get some more information on this product?',
  created_at: Time.now - 2.days)
FactoryBot.create(:message,
  user: user,
  message_channel: channel,
  message: 'Can I get some more information on this product?',
  created_at: Time.now - 2.days)
FactoryBot.create(:message,
  user: doctor,
  message_channel: channel,
  message: 'Sure, I can help you with that. What do you need to know?',
    created_at: Time.now - 2.days)
FactoryBot.create(:message,
  user: user,
  message_channel: channel,
  message: 'What is the dosage?',
  created_at: Time.now - 1.day)
FactoryBot.create(:message,
  user: user,
  message_channel: channel,
  message: 'Hello?',
  created_at: Time.now - 2.hours)
FactoryBot.create(:message,
  user: user,
  message_channel: channel,
  message: 'Doc, are you there?',
  created_at: Time.now)

