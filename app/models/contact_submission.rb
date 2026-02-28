class ContactSubmission < ApplicationRecord
  belongs_to :expert, optional: true

  STATUSES = %w[new read replied].freeze

  validates :sender_name, presence: true
  validates :sender_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true
  validates :status, inclusion: { in: STATUSES }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
end
