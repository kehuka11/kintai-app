module Domain
    class AppUserRoleLinkage
        attr_reader :app_user_id, :app_user_role_id

        def initialize(app_user_id:, app_user_role_id:)
            raise Domain::Exception::NotFound, 'app_user_id is required' if app_user_id.nil?
            raise Domain::Exception::ValidationError, 'app_user_id is blank' if app_user_id.empty?
            raise Domain::Exception::ValidationError, 'app_user_id is too long' if app_user_id.length > 255
            raise Domain::Exception::NotFound, 'app_user_role_id is required' if app_user_role_id.nil?

            @app_user_id = app_user_id
            @app_user_role_id = app_user_role_id
        end
    end
end