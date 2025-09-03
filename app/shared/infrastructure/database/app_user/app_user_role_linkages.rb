module Infrastructure
    module Database
        module AppUser
            class AppUserRoleLinkages < ::ApplicationRecord
                validates :app_user_id, presence: true, length: { maximum: 255 }
                validates :app_user_role_id, presence: true, length: { maximum: 255 }
            end
        end
    end
end

