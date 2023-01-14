class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  enum status: { open: 'open', close: 'close' }, _prefix: :status
  scope :get_all_tasks_by_project_and_user, ->(project_id, user_id) { where(project_id: project_id, user_id: user_id) }
end
