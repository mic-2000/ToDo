class Task < ActiveRecord::Base
  belongs_to :project

  default_scope { order(:priority) }

  before_create { self.priority = Task.where(project_id: self.project_id).maximum(:priority).to_i + 1 }
end
