module Application
  class AppUserServiceImpl < AppUserService
    def initialize(repo: Infrastructure::Database::AppUser::AppUserRepositoryImpl.new)
      @repo = repo
    end


    def register(cmd)
      user = Domain::AppUser.new(
        id: SecureRandom.uuid,
        name: cmd.name,
        email: cmd.email,
        is_first_register: cmd.is_first_register,
        password: 'password'
      )
      
      @repo.save(user)

      user

      rescue => e
        ExceptionTrancelate.translate(e)
    end
  end
end
