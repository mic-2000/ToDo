class Project < ActiveRecord::Base

  belongs_to :user

  has_many :tasks, dependent: :destroy

  default_scope { order(:priority) }

  before_create { self.priority = Project.where(user_id: self.user_id).maximum(:priority).to_i + 1 }
end
