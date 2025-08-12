class ApplicationController < ActionController::Base
  # CSRF保護を無効化（APIの場合）
  skip_before_action :verify_authenticity_token

  # エラー時のデフォルトテンプレートを設定
  rescue_from StandardError, with: :handle_unexpected_error
  rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_error
  rescue_from Domain::Exception::Error, with: :handle_domain_error

  private

  def handle_unexpected_error(exception)
    logger.error "Unhandled Exception: #{exception.class.name} - #{exception.message}"
    logger.error exception.backtrace.join("\n")

    render json: { error: 'Internal Server Error' }, status: :internal_server_error # 500
  end

  def handle_validation_error(exception)
    logger.error "Unhandled Exception: #{exception.class.name} - #{exception.message}"
    logger.error exception.backtrace.join("\n")

    render json: { error: 'Invalid Request' }, status: :unprocessable_entity # 422
  end

  def handle_domain_error(exception)
    logger.error "Unhandled Exception: #{exception.class.name} - #{exception.message}"
    logger.error exception.backtrace.join("\n")

    render json: { error: 'Invalid Request' }, status: :bad_request # 400
  end
end
