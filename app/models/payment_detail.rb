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
class PaymentDetail < ApplicationRecord
  belongs_to :user
  has_many :order_payment_details
  has_many :orders, through: :order_payment_details

  enum payment_type: {
    credit_card: 0,
    gift_card: 0
  }

  validates :encrypted_credit_card_number, presence: true
  validates :expiration, presence: true
  validates :full_name, presence: true
  validates :last_four_digits, length: { is: 4 }, presence: true
  validates :zip_code, presence: true, length: { minimum: 5 }

  # @param [String] data that is to be encrypted (credit card number, ssn, etc)
  # @param [Symbol] purpose of use (:purchase, :subscribe, etc)
  # @return [String] encrypted version of data
  def self.encrypt_data(data, purpose)
    enc_processor.encrypt_and_sign(data, purpose: purpose)
  end

  # @param [String] data that is to be decrypted (credit card number, ssn, etc)
  # @param [Symbol] purpose of use (:purchase, :subscribe, etc)
  # @return [String] decrypted version of data
  def self.decrypt_data(data, purpose)
    enc_processor.decrypt_and_verify(data, purpose: purpose)
  end

  # @return [ActiveSupport::MessageEncryptor]
  def self.enc_processor
    ActiveSupport::MessageEncryptor.new([ENV['ENC_KEY']].pack("H*"))
  end
end
