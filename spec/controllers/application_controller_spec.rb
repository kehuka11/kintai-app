require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

    controller(ApplicationController) do
        def trigger_unexpected_error
            raise StandardError.new('Unexpected error')
        end

        def trigger_system_error
            raise Application::Exception::SystemError.new(
              code: 'DATABASE_ERROR',
              message: 'Database error occurred',
              details: { 
                service: 'database', 
                error_type: 'active_record' 
              },
              cause: ActiveRecord::ActiveRecordError.new('Database error occurred')
            )
        end

        def trigger_external_service_error
            raise Application::Exception::ExternalServiceError.new(
              code: 'EXTERNAL_SERVICE_ERROR',
              message: 'External service error occurred',
              details: { 
                service: 'external_service', 
                error_type: 'connection' 
              },
              cause: ActiveRecord::ActiveRecordError.new('Database error occurred')
            )
        end

        def trigger_business_error
            raise Application::Exception::BusinessError.new(
              code: 'BUSINESS_ERROR',
              message: 'Business error occurred',
              details: { 
                service: 'business', 
                error_type: 'business' 
              },
              cause: Domain::Exception::BusinessRuleViolation.new('Business rule violation')
            )
        end

        def trigger_validation_error
            raise Application::Exception::ValidationFailed.new(
              code: 'VALIDATION_ERROR',
              message: 'Validation error occurred',
              details: { 
                service: 'validation', 
                error_type: 'validation' 
              },
              cause: Domain::Exception::ValidationError.new('Validation error occurred')
            )
        end
    end

    before do
        # 明示的にルートを定義
        routes.draw do
          get 'trigger_unexpected_error' => 'anonymous#trigger_unexpected_error'
          get 'trigger_system_error' => 'anonymous#trigger_system_error'
          get 'trigger_external_service_error' => 'anonymous#trigger_external_service_error'
          get 'trigger_business_error' => 'anonymous#trigger_business_error'
          get 'trigger_validation_error' => 'anonymous#trigger_validation_error'
        end
    end

    describe 'handle_unexpected_error' do
        it 'returns a 500 status code and error message' do
            get :trigger_unexpected_error
            expect(response).to have_http_status(:internal_server_error)
            json_response = JSON.parse(response.body)
            expect(json_response['error']['code']).to eq('INTERNAL_SERVER_ERROR')
            expect(json_response['error']['message']).to eq('システムエラーが発生しました')
            expect(json_response['error']['timestamp']).to be_a(String)
            expect(json_response['error']['request_id']).to be_a(String)
        end
    end

    describe 'handle_system_error' do
        it 'returns a 500 status code and error message' do
            get :trigger_system_error
            expect(response).to have_http_status(:internal_server_error)
            json_response = JSON.parse(response.body)
            expect(json_response['error']['code']).to eq('SYSTEM_ERROR')
            expect(json_response['error']['message']).to eq('システムエラーが発生しました')
            expect(json_response['error']['details']['service']).to eq('database')
            expect(json_response['error']['details']['error_type']).to eq('active_record')
            expect(json_response['error']['timestamp']).to be_a(String)
            expect(json_response['error']['request_id']).to be_a(String)
        end
    end

    describe 'handle_external_service_error' do
        it 'returns a 503 status code and error message' do
            get :trigger_external_service_error
            expect(response).to have_http_status(:service_unavailable)
            json_response = JSON.parse(response.body)
            expect(json_response['error']['code']).to eq('EXTERNAL_SERVICE_ERROR')
            expect(json_response['error']['message']).to eq('外部サービスに接続できませんでした')
            expect(json_response['error']['details']['service']).to eq('external_service')
            expect(json_response['error']['details']['error_type']).to eq('connection')
            expect(json_response['error']['timestamp']).to be_a(String)
            expect(json_response['error']['request_id']).to be_a(String)
        end
    end

    describe 'handle_business_error' do
        it 'returns a 422 status code and error message' do
            begin
                get :trigger_business_error
            rescue => e
                puts "Exception caught: #{e.class.name}"
                puts "Exception message: #{e.message}"
                raise e
            end
            puts "Response status: #{response.status}"
            puts "Response body: #{response.body}"
            expect(response).to have_http_status(:unprocessable_entity)
            json_response = JSON.parse(response.body)
            expect(json_response['error']['code']).to eq('BUSINESS_RULE_VIOLATION')
            expect(json_response['error']['message']).to eq('ビジネスルールに違反しています')
            expect(json_response['error']['details']['service']).to eq('business')
            expect(json_response['error']['details']['error_type']).to eq('business')
            expect(json_response['error']['timestamp']).to be_a(String)
            expect(json_response['error']['request_id']).to be_a(String)
        end
    end

    describe 'handle_validation_error' do
        it 'returns a 400 status code and error message' do
            get :trigger_validation_error
            expect(response).to have_http_status(:bad_request)
            json_response = JSON.parse(response.body)
            expect(json_response['error']['code']).to eq('VALIDATION_ERROR')
            expect(json_response['error']['message']).to eq('入力内容に誤りがあります')
            expect(json_response['error']['details']['service']).to eq('validation')
            expect(json_response['error']['details']['error_type']).to eq('validation')
            expect(json_response['error']['timestamp']).to be_a(String)
            expect(json_response['error']['request_id']).to be_a(String)
        end
    end

end