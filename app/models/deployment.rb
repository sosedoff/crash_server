class Deployment < ActiveRecord::Base
  belongs_to :app
  
  default_scope :order => 'created_at DESC'
end
