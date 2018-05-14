class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false, :unique => true
      t.string :login, :null => false, :unique => true
      t.string :email, :null => false, :unique => true
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.string :perishable_token, :null => false # optional, used for reset password functionality

      #t.string :single_access_token, :null => false # optional, see Authlogic::Session::Params

      # magic fields (all optional, see Authlogic::Session::MagicColumns)
      t.integer :login_count, :null => false, :default => 0
      t.integer :failed_login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.timestamps
    end
  end
end
