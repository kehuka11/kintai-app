module Domain
  class AppUser
    attr_reader :id, :name, :email, :is_first_register, :password

    def initialize(id:, name:, email:, is_first_register:, password:)
      raise 'invalid email' unless /@/.match?(email)

      @id = id
      @name = name
      @email = email
      @is_first_register = is_first_register
      @password = password
      freeze
    end
  end
end
