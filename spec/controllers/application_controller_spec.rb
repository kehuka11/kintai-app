require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

    controller(ApplicationController) do
        def trigger_unexpected_error
            raise StandardError.new('Unexpected error')
        end

        def trigger_validation_error
            user = Userinterface::AppUser::AppUserCreateRequest.new(name: '', email: '', isFirstRegister: true)
            raise ActiveRecord::RecordInvalid.new(user)
        end

        def trigger_domain_error
            raise Domain::Exception::Error.new('Business rule error')
        end
    end

    before do
        # 明示的にルートを定義
        routes.draw do
          get 'trigger_unexpected_error' => 'anonymous#trigger_unexpected_error'
          get 'trigger_validation_error' => 'anonymous#trigger_validation_error'
          get 'trigger_domain_error' => 'anonymous#trigger_domain_error'
        end
    end

    describe 'handle_unexpected_error' do
        it 'returns a 500 status code' do
            get :trigger_unexpected_error
            expect(response).to have_http_status(:internal_server_error)
        end
    end

    describe 'handle_validation_error' do
        it 'returns a 422 status code' do
            get :trigger_validation_error
            expect(response).to have_http_status(:unprocessable_entity)
        end
    end

    describe 'handle_domain_error' do
        it 'returns a 400 status code' do
            get :trigger_domain_error
            expect(response).to have_http_status(:bad_request)
        end
    end
end