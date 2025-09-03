module Api
  module V1
    class AppUsersController < Api::V1::ApplicationController
      def create
        app_user_repository = Infrastructure::Database::AppUser::AppUserRepositoryImpl.new
        app_user_role_linkage_repository = Infrastructure::Database::AppUser::AppUserRoleLinkageRepositoryImpl.new
        appuser_service = Application::AppUserServiceImpl.new(app_user_repository: app_user_repository, app_user_role_linkage_repository: app_user_role_linkage_repository)
        req = Userinterface::AppUser::AppUserCreateRequest.new(user_params)
        return render json: { errors: req.errors.full_messages }, status: :unprocessable_entity unless req.valid?

        cmd = Application::Command::CreateAppUserCmd.new(name: req.name, email: req.email, is_first_register: req.isFirstRegister, role_id: req.roleId)
        user = appuser_service.register(cmd)

        render json: UserSerializer.new(user).serializable_hash, status: :created
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :isFirstRegister, :roleId)
      end
    end
  end
end
