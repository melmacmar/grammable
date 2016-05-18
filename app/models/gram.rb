class Gram < ActiveRecord::Base
  validates :message, presence: true
  
  belongs_to :user
end
class Gram < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
end