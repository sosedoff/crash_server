require 'yaml'

class Crash < ActiveRecord::Base
  include Payload
  
  belongs_to :app
  
  validates_presence_of :app_id, :uuid
  
  default_scope :order => 'last_occurred_at DESC'
  
  scope :active, :conditions => ['status = ?', 'open']
  scope :closed, :conditions => ['status = ?', 'closed']
  
  def to_s
    "#{self.class_name}: #{self.message}"
  end
  
  def open?
    self.status == 'open'
  end
  
  def close
    self.update_attribute(:status, 'closed')
  end
  
  def assign_payload(p)
    ts = p['exception']['timestamp']
    ts = Time.parse(ts) unless ts.kind_of?(Time)
    
    self.update_attributes(   
      :uuid             => payload_uuid(p),
      :class_name       => p['exception']['class_name'],
      :message          => p['exception']['message'],
      :backtrace        => p['exception']['backtrace'].join("\r\n"),
      :environment      => YAML.dump(p['environment']),
      :framework        => p['framework'],
      :created_at       => ts,
      :last_occurred_at => ts
    )
  end
  
  def just_happened
    self.update_attributes(
      :status           => 'open',
      :last_occurred_at => Time.now,
      :occurrences      => self.occurrences + 1
    )
  end
end
