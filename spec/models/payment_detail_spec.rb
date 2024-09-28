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
require 'rails_helper'

RSpec.describe PaymentDetail, type: :model do
  it { should validate_presence_of(:encrypted_credit_card_number) }
  it { should validate_presence_of(:expiration) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:last_four_digits) }
  it { should validate_presence_of(:zip_code) }
end
