class Task < ApplicationRecord
  # after_commit :async_update
  validates :title, presence: true

  belongs_to :workflow
  acts_as_list scope: :workflow

  has_many :task_members, dependent: :destroy
  has_many :users, through: :task_members

  has_many :items, dependent: :destroy
  has_rich_text :content

  # def async_update
  #   UpdateWorkflowJob.perform_later(self)
  # end

  def completed?
    self.completed == "completed"
  end

  def pending?
    self.completed == "pending"
  end

  def current?
    self.completed == "current"
  end

  def set_current
    notify_taskmembers if self.update(completed: "current")
  end

  def set_pending
    self.update(completed: "pending")
  end

  def set_completed
    self.update(completed: "completed")
  end

  private

  # Task notifications
  def notify_taskmembers
    # self is redundant
    task_members.each do |taskmember|
      notification = Telegram.new(taskmember.user.telegram_chat_id)
      notification.notify_task(title)
    end
  end
end
