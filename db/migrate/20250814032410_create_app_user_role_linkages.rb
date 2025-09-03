class CreateAppUserRoleLinkages < ActiveRecord::Migration[8.0]
  def change
    create_table :app_user_role_linkages do |t|
      t.string :app_user_id
      t.integer :app_user_role_id

      t.timestamps
    end
  end
end
