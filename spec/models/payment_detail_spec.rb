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
  context 'secure data' do
    let(:cc_number) { 5454-1234-0879-1910 }
    let(:encrypted_cc_number) { PaymentDetail.encrypt_data(cc_number, :purchase) }

    it 'should decrypt data' do
      expect(described_class.decrypt_data(encrypted_cc_number, :purchase)).to eq(cc_number)
    end
  end
end
