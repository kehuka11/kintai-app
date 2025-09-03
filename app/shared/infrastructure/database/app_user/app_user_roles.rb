module Infrastructure
    module Database
        module AppUser
            class AppUserRoles < ::ApplicationRecord
                validates :id, presence: true, uniqueness: true, length: { maximum: 255 }
                validates :roleType, presence: true, length: { maximum: 255 }
            end
        end
    end
end
