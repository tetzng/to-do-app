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
  def self.search(word, status)
    tasks =
      statuses.include?(status) ? where(status: status) : all
    word.present? ? tasks.where('name like ?', "%#{word}%") : tasks
  end
end
