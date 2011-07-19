class CreateCrashes < ActiveRecord::Migration
  def self.up
    create_table :crashes do |t|
      t.integer      :app_id,         :null => false
      t.string       :uuid,           :limit => 64, :null => false
      t.string       :status,         :limit => 16, :default => 'open'
      t.string       :class_name,     :limit => 128, :null => false
      t.string       :message
      t.text         :backtrace
      t.text         :environment
      t.string       :framework,      :limit => 16
      t.datetime     :created_at
      t.datetime     :last_occurred_at
      t.integer      :occurrences,     :default => 1
    end
    
    add_index :crashes, :uuid
  end

  def self.down
    drop_table :crashes
  end
end
