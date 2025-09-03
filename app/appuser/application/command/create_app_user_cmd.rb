module Application
  module Command
    class CreateAppUserCmd
      attr_reader :name, :email, :is_first_register, :role_id

      def initialize(name:, email:, is_first_register:, role_id:)
        @name = name
        @email = email
        @is_first_register = is_first_register
        @role_id = role_id
        freeze
      end
    end
  end
end
