module Application
  module Exception
    class AppError < StandardError
        attr_reader :code, :details
        def initialize(code:, message:, details: {}, cause: nil)
            super(message)
            @code, @details = code, details
            set_backtrace(cause.backtrace) if cause
        end
    end
  end
end