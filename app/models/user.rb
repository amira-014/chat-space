class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :messages
  has_many :groups_users
  has_many :groups, through: :groups_users

  scope :search_name_with_params, ->(user){ where('name LIKE(?)', "%#{user}%") }

end
