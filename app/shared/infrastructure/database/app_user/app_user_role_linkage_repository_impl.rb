module Infrastructure
    module Database
        module AppUser
            class AppUserRoleLinkageRepositoryImpl < Repository::AppUserLinkageRepository
                def save(app_user_role_linkage)
                    AppUserRoleLinkages.create!(
                        app_user_id: app_user_role_linkage.app_user_id,
                        app_user_role_id: app_user_role_linkage.app_user_role_id
                    )
                end
            end
        end
    end
end