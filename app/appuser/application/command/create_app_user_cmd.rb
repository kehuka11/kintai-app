module Application
  module Command
    class CreateAppUserCmd
      attr_reader :name, :email, :is_first_register

      def initialize(name:, email:, is_first_register:)
        @name = name
        @email = email
        @is_first_register = is_first_register
        freeze
      end
    end
  end
end
