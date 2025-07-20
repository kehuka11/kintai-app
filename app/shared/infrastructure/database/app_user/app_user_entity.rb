module Infrastructure
  module Database
    module AppUser
      class AppUserEntity
        attr_reader :id, :name, :email, :password

        def initialize(id:, name:, email:, password:)
          @id = id
          @name = name
          @email = email
          @password = password
        end
      end
    end
  end
end
