module Application
  module Exception
    class SystemError < AppError
      def initialize(code:, message:, details: {}, cause: nil)
        super(code: code, message: message, details: details, cause: cause)
      end
    end
  end
end