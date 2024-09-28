# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  user_type              :integer          default("user")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    user_type { 0 }
    password { 'Password1!'}
    password_confirmation { 'Password1!'}
  end

  factory :doctor, class: 'User' do
    email { Faker::Internet.email }
    user_type { 1 }
    password { 'Password1!'}
    password_confirmation { 'Password1!'}
  end
end
