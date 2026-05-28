class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  enum :role, [:owner, :vet, :admin]

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :owner, dependent: :nullify
  has_one :vet, dependent: :nullify
end