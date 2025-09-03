module Domain
  module Exception
    class Error < StandardError
        attr_reader :code, :details
        def initialize(message = "", code: nil, details: nil)
            super(message)
            @code = code
            @details = details
        end
    end

  end
end