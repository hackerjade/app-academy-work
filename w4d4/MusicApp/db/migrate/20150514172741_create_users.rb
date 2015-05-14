class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :password, null: false
      t.string :session_token, null: false, unique: true

      t.timestamps null: false
    end

    add_index :users, :email
  end
end
