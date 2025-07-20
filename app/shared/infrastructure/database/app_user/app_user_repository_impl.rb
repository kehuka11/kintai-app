module Infrastructure
  module Database
    module AppUser
      class AppUserRepositoryImpl < Repository::AppUserRepository
        def save(user)
          app_user = AppUserEntity.new(id: user.id, name: user.name, email: user.email, password: user.password)
          AppUsers.create!(
            id: app_user.id,
            name: app_user.name,
            email: app_user.email,
            password: app_user.password
          )
        end
      end
    end
  end
end
