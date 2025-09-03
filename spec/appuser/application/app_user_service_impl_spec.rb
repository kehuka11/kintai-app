require 'rails_helper'

RSpec.describe Application::AppUserServiceImpl, type: :model do
  describe '#register_normal' do

    subject(:create_app_user_cmd) { build(:create_app_user_cmd, :admin_role) }

    it 'registers a new app user using a mock repository' do

      # モックを作成
      # 実在するメソッドチェックのためinstance_doubleを使用
      app_user_reposiroy_mock = instance_double('AppUserRepository')
      allow(app_user_reposiroy_mock).to receive(:save).and_return(true)

      app_user_role_linkage_repository_mock = instance_double('AppUserRoleLinkageRepository')
      allow(app_user_role_linkage_repository_mock).to receive(:save).and_return(true)

        # Import用にモックをコンテナに登録しなおす

        service = Application::AppUserServiceImpl.new(app_user_repository: app_user_reposiroy_mock, app_user_role_linkage_repository: app_user_role_linkage_repository_mock)

        user = service.register(create_app_user_cmd)

        expect(user).to be_a(Domain::AppUser)
        expect(app_user_reposiroy_mock).to have_received(:save).with(instance_of(Domain::AppUser))
        expect(app_user_role_linkage_repository_mock).to have_received(:save).with(instance_of(Domain::AppUserRoleLinkage))
        expect(user.id.encode('UTF-8')).not_to be_nil
        expect(user.name).to eq(create_app_user_cmd.name)
        expect(user.email).to eq(create_app_user_cmd.email)
        expect(user.is_first_register).to eq(create_app_user_cmd.is_first_register)

    end
  end

  describe '#register_failure' do
    subject(:create_app_user_cmd) { build(:create_app_user_cmd, :admin_role) }

    it 'registers a new app user using a mock repository' do
      app_user_reposiroy_mock = instance_double('AppUserRepository')
      allow(app_user_reposiroy_mock).to receive(:save).and_return(false)

      app_user_role_linkage_repository_mock = instance_double('AppUserRoleLinkageRepository')
      allow(app_user_role_linkage_repository_mock).to receive(:save).and_raise(ActiveRecord::ConnectionNotEstablished.new("db connection error"))

      service = Application::AppUserServiceImpl.new(app_user_repository: app_user_reposiroy_mock, app_user_role_linkage_repository: app_user_role_linkage_repository_mock)

      expect { service.register(create_app_user_cmd) }.to raise_error(Application::Exception::ExternalServiceError)
    end
  end
end
