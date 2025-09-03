module Application
  class AppUserServiceImpl < AppUserService
    def initialize(app_user_repository: Infrastructure::Database::AppUser::AppUserRepositoryImpl.new, app_user_role_linkage_repository: Infrastructure::Database::AppUser::AppUserRoleLinkageRepositoryImpl.new)
      @app_user_repository = app_user_repository
      @app_user_role_linkage_repository = app_user_role_linkage_repository
    end


    def register(cmd)
      Application::Helper::TransactionService.transaction do
      user = Domain::AppUser.new(
        id: SecureRandom.uuid,
        name: cmd.name,
        email: cmd.email,
        is_first_register: cmd.is_first_register,
        password: 'password'
      )

      app_user_role_linkage = Domain::AppUserRoleLinkage.new(
        app_user_id: user.id,
        app_user_role_id: cmd.role_id
      )
      
      @app_user_repository.save(user)
      @app_user_role_linkage_repository.save(app_user_role_linkage)

      user
      
      end
    end
  end
end
