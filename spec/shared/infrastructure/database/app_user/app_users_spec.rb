require 'rails_helper'

RSpec.describe Infrastructure::Database::AppUser::AppUsers, type: :model do

  describe 'normal case' do
    subject(:app_users) { build(:app_users) }

    it 'is valid' do
      expect(app_users).to be_valid
    end
  end

  describe 'validations' do
    context 'when name is blank' do
      subject(:app_users) { build(:app_users, :name_blank) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when name is too long' do
      subject(:app_users) { build(:app_users, :name_too_long) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when email is blank' do
      subject(:app_users) { build(:app_users, :email_blank) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when email is invalid' do
      subject(:app_users) { build(:app_users, :email_invalid) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when email is too long' do
      subject(:app_users) { build(:app_users, :email_too_long) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when password is blank' do
      subject(:app_users) { build(:app_users, :password_blank) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when password is too short' do
      subject(:app_users) { build(:app_users, :password_too_short) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when password is too long' do
      subject(:app_users) { build(:app_users, :password_too_long) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when id is blank' do
      subject(:app_users) { build(:app_users, :id_blank) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end

    context 'when id is too long' do
      subject(:app_users) { build(:app_users, :id_too_long) }

      it 'is invalid' do
        expect(app_users).to be_invalid
      end
    end
  end
end
