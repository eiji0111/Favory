# frozen_string_literal: true

class DeviseCreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      t.string :name, null: false
      t.string :nickname, null: false
      t.integer :sex, null: false, default: 0
      t.boolean :is_valid, null: false, default: true
      t.boolean :army_flag, null: false, default: false
      t.string :profile_image_id
      t.string :one_thing
      t.text :introduction
      
      t.date :birthday
      t.integer :address, null: false, default: 0
      t.integer :birthplace, null: false, default: 0
      t.integer :work_location, null: false, default: 0
      t.string :jobs
      t.integer :annual_income, null: false, default: 0
      
      t.string :height
      t.integer :body_shape, null: false, default: 0
      t.integer :blood_type, null: false, default: 0
      t.integer :personality, null: false, default: 0
      
      t.integer :holiday, null: false, default: 0
      t.integer :car, null: false, default: 0
      t.string :hobby
      t.integer :cigarettes, null: false, default: 0
      t.integer :alcohol, null: false, default: 0
      
      t.integer :housemate, null: false, default: 0
      t.integer :marriage_history, null: false, default: 0
      t.integer :children, null: false, default: 0
      t.integer :willingness_to_marry, null: false, default: 0
      t.integer :want_kids, null: false, default: 0
      t.integer :hope_encounter, null: false, default: 0
      t.integer :date_cost, null: false, default: 0

      t.timestamps null: false
    end

    add_index :customers, :email,                unique: true
    add_index :customers, :reset_password_token, unique: true
    # add_index :customers, :confirmation_token,   unique: true
    # add_index :customers, :unlock_token,         unique: true
  end
end
