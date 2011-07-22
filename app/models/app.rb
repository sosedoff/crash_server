class App < ActiveRecord::Base
  include Payload
  
  has_many :crashes, :dependent => :destroy
  has_many :deployments, :dependent => :destroy
  
  validates_presence_of   :name, :api_key
  validates_length_of     :name, :within => 2..64
  validates_uniqueness_of :name
  validates_uniqueness_of :api_key
  
  before_validation :assign_api_key, :on => :create
  
  def register_crash(payload)
    uuid = payload_uuid(payload)
    crash = self.crashes.find_by_uuid(uuid)
    unless crash.nil?
      crash.just_happened
    else    
      crash = self.crashes.new
      crash.assign_payload(payload)
      crash.save
    end
    crash
  end
  
  def reset_api_key!
    self.update_attribute(:api_key, generate_api_key)
  end
  
  private
  
  def assign_api_key
    self.api_key = generate_api_key if new_record?
  end
  
  def generate_api_key
    UUIDTools::UUID.random_create.to_s.gsub(/-/,'')
  end
end
