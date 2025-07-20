module Application
  class AppUserServiceImpl < AppUserService
    include Import[
      repo: 'infrastructure.database.app_user.app_user_repository_impl'
    ]


    def register(cmd)
      user = Domain::AppUser.new(
        id: SecureRandom.uuid,
        name: cmd.name,
        email: cmd.email,
        is_first_register: cmd.is_first_register,
        password: 'password'
      )
      repo.save(user)
      user
    end
  end
end
