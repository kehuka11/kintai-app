class CreateAppUserRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :app_user_roles do |t|
      t.string :roleType

      t.timestamps
    end

    # 初期データの挿入
    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO app_user_roles (roleType, created_at, updated_at) VALUES
          ('admin', NOW(), NOW()),
          ('general', NOW(), NOW());
        SQL
      end
      
      dir.down do
        execute "DELETE FROM app_user_roles WHERE roleType IN ('admin', 'general');"
      end
    end
  end
end
