class Expert < ApplicationRecord
  has_one_attached :photo
  has_many :contact_submissions, dependent: :nullify

  validates :name, presence: true
  validates :city, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :active, -> { where(active: true) }
  scope :by_city, ->(city) { where(city: city) if city.present? }
end
