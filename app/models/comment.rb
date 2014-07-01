class Comment < ActiveRecord::Base

  belongs_to :task
  validates :body, presence: true
  mount_uploader :file_name, FileUploader
end
