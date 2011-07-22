class CreateDeployments < ActiveRecord::Migration
  def self.up
    create_table :deployments do |t|
      t.integer :app_id,           :null => false
      t.string :action,            :limit => 32
      t.string :message
      t.string :capistrano_version, :limit => 16
      t.string :payload_version,    :limit => 16
      t.string :deployer_user,      :limit => 64
      t.string :deployer_hostname,  :limit => 128
      t.string :source_branch,      :limit => 64
      t.string :source_revision,    :limit => 64
      t.string :source_repository
      t.datetime :created_at
    end
    
    add_index :deployments, :app_id
    add_index :deployments, [:app_id, :action], :as => 'app_action'
  end

  def self.down
    drop_table :deployments
  end
end