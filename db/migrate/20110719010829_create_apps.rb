class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string     :name,    :limit => 64, :null => false
      t.string     :api_key, :limit => 64, :null => false
      t.boolean    :enabled, :default => true
      t.timestamps
    end
    
    add_index :apps, :name
    add_index :apps, :api_key
  end

  def self.down
    drop_table :apps
  end
end
