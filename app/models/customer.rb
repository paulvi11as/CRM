class Customer < ApplicationRecord
  has_one_attached :image

  validates :full_name, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/, message: "must be in the format XXX-XXX-XXXX" }
end
