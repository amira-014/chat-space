class Group < ApplicationRecord
  validates :name, presence: true

  has_many :messages
  has_many :groups_users
  has_many :users, through: :groups_users

  def last_message
    messages.last.try(:body) || 'メッセージはまだありません'
  end

end
