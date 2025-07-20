class CreateAppUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :app_users, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :name
      t.string :email
      t.string :password
      t.timestamps null: false
    end
  end
end
