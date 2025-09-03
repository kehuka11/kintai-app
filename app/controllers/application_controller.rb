class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # 例外クラスを明示的にrequire
  # require_relative '../appuser/application/exception/business_error'
  # require_relative '../appuser/application/exception/app_error'
  # require_relative '../appuser/application/exception/system_error'
  # require_relative '../appuser/application/exception/validation_failed'
  # require_relative '../appuser/application/exception/external_service_error'

  rescue_from StandardError, with: :handle_unexpected_error
  rescue_from Application::Exception::SystemError, with: :handle_system_error
  rescue_from Application::Exception::ValidationFailed, with: :handle_validation_failed
  rescue_from Application::Exception::ExternalServiceError, with: :handle_external_service_error
  rescue_from Application::Exception::BusinessError, with: :handle_business_error


  private

  def handle_unexpected_error(exception)
    log_error(exception)
    render_error_response(
      code: I18n.t('errors.codes.internal_server_error'),
      message: I18n.t('errors.messages.internal_server_error'),
      status: :internal_server_error
    )
  end

  def handle_system_error(exception)
    log_error(exception)
    render_error_response(
      code: I18n.t('errors.codes.system_error'),
      message: I18n.t('errors.messages.system_error'),
      details: exception.details,
      status: :internal_server_error
    )
  end

  def handle_external_service_error(exception)
    log_error(exception)
    render_error_response(
      code: I18n.t('errors.codes.external_service_error'),
      message: I18n.t('errors.messages.external_service_error'),
      details: exception.details,
      status: :service_unavailable
    )
  end

  def handle_business_error(exception)
    log_error(exception)
    render_error_response(
      code: I18n.t('errors.codes.business_error'),
      message: I18n.t('errors.messages.business_error'),
      details: exception.details,
      status: :unprocessable_entity
    )
  end

  def handle_validation_failed(exception)
    log_error(exception)
    render_error_response(
      code: I18n.t('errors.codes.validation_error'),
      message: I18n.t('errors.messages.validation_error'),
      details: exception.details,
      status: :bad_request
    )
  end

  private

  def render_error_response(code:, message:, details: nil, status:)
    response_body = {
      error: {
        code: code,
        message: message,
        timestamp: Time.current.iso8601,
        request_id: request.request_id || SecureRandom.uuid
      }
    }
    
    response_body[:error][:details] = details if details.present?
    
    render json: response_body, status: status
  end

  def log_error(exception)
    logger.error "Exception: #{exception.class.name} - #{exception.message}"
    logger.error "Backtrace: #{exception.backtrace.join("\n")}"
    logger.error "Request ID: #{request.request_id}" if request.request_id
  end
end