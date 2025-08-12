require 'rails_helper'

RSpec.describe Application::AppUserServiceImpl, type: :model do
  describe '#register_normal' do

    subject(:app_user_domain) { build(:app_user_domain) }

    it 'registers a new app user using a mock repository' do

      # モックを作
      # 実在するメソッドチェックのためinstance_doubleを使用
      repo_mock = instance_double('AppUserRepository')
      allow(repo_mock).to receive(:save).and_return(true)

        # Import用にモックをコンテナに登録しなおす

        service = Application::AppUserServiceImpl.new(repo: repo_mock)

        user = service.register(app_user_domain)

        expect(user).to be_a(Domain::AppUser)
        expect(repo_mock).to have_received(:save).with(instance_of(Domain::AppUser))
        expect(user.id.encode('UTF-8')).not_to be_nil
        expect(user.name).to eq(app_user_domain.name)
        expect(user.email).to eq(app_user_domain.email)
        expect(user.is_first_register).to eq(app_user_domain.is_first_register)
        expect(user.password).to eq(app_user_domain.password)

    end
  end
end
