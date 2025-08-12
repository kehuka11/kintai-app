module Api
  module V1
    class AppUsersController < Api::V1::ApplicationController
      def create
        app_user_repository = Infrastructure::Database::AppUser::AppUserRepositoryImpl.new
        appuser_service = Application::AppUserServiceImpl.new(repo: app_user_repository)
        req = Userinterface::AppUser::AppUserCreateRequest.new(user_params)
        return render json: { errors: req.errors.full_messages }, status: :unprocessable_entity unless req.valid?

        cmd = Application::Command::CreateAppUserCmd.new(name: req.name, email: req.email, is_first_register: req.isFirstRegister)
        user = appuser_service.register(cmd)

        render json: UserSerializer.new(user).serializable_hash, status: :created
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :isFirstRegister)
      end
    end
  end
end
