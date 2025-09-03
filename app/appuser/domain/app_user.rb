module Domain
  class AppUser
    attr_reader :id, :name, :email, :is_first_register, :password

    def initialize(id:, name:, email:, is_first_register:, password:)
      raise Domain::Exception::NotFound, 'id is required' if id.nil?
      raise Domain::Exception::ValidationError, 'id is blank' if id.empty?
      raise Domain::Exception::ValidationError, 'id is too long' if id.length > 255
      raise Domain::Exception::NotFound, 'name is required' if name.nil?
      raise Domain::Exception::ValidationError, 'name is too long' if name.length > 255
      raise Domain::Exception::ValidationError, 'name is blank' if name.empty?
      raise Domain::Exception::NotFound, 'email is required' if email.nil?
      raise Domain::Exception::ValidationError, 'email is blank' if email.empty?
      raise Domain::Exception::ValidationError, 'email is too long' if email.length > 255
      raise Domain::Exception::ValidationError, "invalid email: #{email}" unless /@/.match?(email)
      raise Domain::Exception::NotFound, 'password is required' if password.nil?
      raise Domain::Exception::ValidationError, 'password is blank' if password.empty?
      raise Domain::Exception::ValidationError, 'password is too long' if password.length > 255
      raise Domain::Exception::ValidationError, 'password is too short' if password.length < 8
      raise Domain::Exception::NotFound, 'is_first_register is required' if is_first_register.nil?
      raise Domain::Exception::ValidationError, 'is_first_register is invalid' if is_first_register != true && is_first_register != false
      

      @id = id
      @name = name
      @email = email
      @is_first_register = is_first_register
      @password = password
      freeze
    end
  end
end
