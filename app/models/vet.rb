class Vet < ApplicationRecord
  has_many :appointments, dependent: :destroy

  scope :by_specialization, ->(specialization) { where(specialization: specialization) }

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :specialization, presence: true

  before_validation :normalize_email

  belongs_to :user, optional: true

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

end