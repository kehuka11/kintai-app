class ErrorsController < ActionController::Base
  def show
    exception = request.env['action_dispatch.exception']
    status = ActionDispatch::ExceptionWrapper.new(request.env, exception).status_code

    logger.error "#{status} Error: #{exception.class} - #{exception.message}"
    logger.error exception.backtrace.join("\n") if exception

    render json: { error: Rack::Utils::HTTP_STATUS_CODES[status] }, status: status
  end
end
