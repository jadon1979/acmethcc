# == Schema Information
#
# Table name: payment_details
#
#  id                           :integer          not null, primary key
#  encrypted_credit_card_number :string
#  expiration                   :string
#  full_name                    :string
#  last_four_digits             :integer
#  payment_type                 :integer
#  zip_code                     :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  user_id                      :integer          not null
#
FactoryBot.define do
  factory :payment_detail do
    encrypted_credit_card_number {
      PaymentDetail.encrypt_data(Faker::Business.credit_card_number, :purchase)
    }
    full_name { Faker::Name.name_with_middle }
    expiration { Faker::Business.credit_card_expiry_date }
    last_four_digits { rand(1000..9999) }
    payment_type { 0 }
    user
  end
end
