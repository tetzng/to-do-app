class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status: {
    waiting: 0,
    doing: 1,
    done: 2,
  }

  enum priority: {
    high: 0,
    middle: 1,
    low: 2,
  }

  scope :sort_status, -> status { where(status: status) if statuses.include?(status) }
  scope :sort_word, -> word { where('name like ?', "%#{word}%") if word.present? }
end
