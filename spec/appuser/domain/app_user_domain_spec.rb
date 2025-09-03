require 'rails_helper'
require_relative '../../../app/appuser/domain/exception/error'

RSpec.describe Domain::AppUser do
  describe 'normal case' do
    subject(:app_user) { build(:app_user_domain) }


    it 'creates a valid app user' do
      expect { app_user }.not_to raise_error
      expect(app_user).to be_a(Domain::AppUser)
    end
  end

  describe 'domain error' do
    context 'when id is invalid' do
      subject(:app_user_blank) { build(:app_user_domain, :id_blank) }
      subject(:app_user_nil) { build(:app_user_domain, :id_nil) }
      subject(:app_user_too_long) { build(:app_user_domain, :id_too_long) }

      it 'raises ValidationError exception' do
        expect { app_user_blank }.to raise_error(Domain::Exception::ValidationError, 'id is blank')
        expect {app_user_too_long}.to raise_error(Domain::Exception::ValidationError, 'id is too long')
      end

      it 'raises NotFound exception' do
        expect { app_user_nil }.to raise_error(Domain::Exception::NotFound, 'id is required')
      end
    end

    context 'when name is invalid' do
      subject(:app_user_blank) { build(:app_user_domain, :name_blank) }
      subject(:app_user_nil) { build(:app_user_domain, :name_nil) }
      subject(:app_user_too_long) { build(:app_user_domain, :name_too_long) }

      it 'raises ValidationError exception' do
        expect { app_user_blank }.to raise_error(Domain::Exception::ValidationError, 'name is blank')
        expect { app_user_too_long }.to raise_error(Domain::Exception::ValidationError, 'name is too long')
      end

      it 'raises NotFound exception' do
        expect { app_user_nil }.to raise_error(Domain::Exception::NotFound, 'name is required')
      end
    end

    context 'when email is invalid' do
      subject(:app_user_blank) { build(:app_user_domain, :email_blank) }
      subject(:app_user_nil) { build(:app_user_domain, :email_nil) }
      subject(:app_user_too_long) { build(:app_user_domain, :email_too_long) }
      subject(:app_user_invalid) { build(:app_user_domain, :email_invalid) }

      it 'raises ValidationError exception' do
        expect { app_user_blank }.to raise_error(Domain::Exception::ValidationError, 'email is blank')
        expect { app_user_too_long }.to raise_error(Domain::Exception::ValidationError, 'email is too long')
        expect { app_user_invalid }.to raise_error(Domain::Exception::ValidationError, 'invalid email: invalid_email')
      end

      it 'raises NotFound exception' do
        expect { app_user_nil }.to raise_error(Domain::Exception::NotFound, 'email is required')
      end
    end

    context 'when password is invalid' do
      subject(:app_user_nil) {build(:app_user_domain, :password_nil)}
      subject(:app_user_blank) {build(:app_user_domain, :password_blank)}
      subject(:app_user_too_short) {build(:app_user_domain, :password_too_short)}
      subject(:app_user_too_long) {build(:app_user_domain, :password_too_long)}

      it 'raises NotFound exception' do
        expect { app_user_nil }.to raise_error(Domain::Exception::NotFound, 'password is required')
      end

      it 'raises ValidationError exception' do
        expect { app_user_blank }.to raise_error(Domain::Exception::ValidationError, 'password is blank')
        expect { app_user_too_short }.to raise_error(Domain::Exception::ValidationError, 'password is too short')
        expect { app_user_too_long }.to raise_error(Domain::Exception::ValidationError, 'password is too long')
      end
    end

    context 'when is_first_register is invalid' do
      subject(:app_user_nil) {build(:app_user_domain, :is_first_register_nil)}
      subject(:app_user_invalid) {build(:app_user_domain, :is_first_register_invalid)}

      it 'raises ValidationError exception' do
        expect { app_user_invalid }.to raise_error(Domain::Exception::ValidationError, 'is_first_register is invalid')
      end

      it 'raises NotFound exception' do
        expect { app_user_nil }.to raise_error(Domain::Exception::NotFound, 'is_first_register is required')
      end
    end
  end
end