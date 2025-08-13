# app/appuser/application/exception/exception_translate.rb
module Application
    module Exception
      class ExceptionTranslate
        def self.translate(exception)
          case exception
          when ActiveRecord::ConnectionNotEstablished, ActiveRecord::ConnectionTimeoutError
            raise ExternalServiceError.new(
              code: 'DATABASE_CONNECTION_ERROR',
              message: 'Database connection failed',
              details: { 
                service: 'database', 
                error_type: 'connection' 
              },
              cause: exception
            )
  
          when ActiveRecord::ActiveRecordError
            raise SystemError.new(
              code: 'DATABASE_ERROR',
              message: 'Database error occurred',
              details: { 
                service: 'database', 
                error_type: 'active_record' 
              },
              cause: exception
            )
            
          when Domain::Exception::ValidationError
            raise ValidationFailed.new(
              code: 'DOMAIN_VALIDATION_ERROR',
              message: 'Validation failed',
              details: extract_validation_details(exception),
              cause: exception
            )
            
          when Domain::Exception::NotFound
            raise ValidationFailed.new(
              code: 'REQUIRED_FIELD_MISSING',
              message: 'Required field missing',
              details: extract_not_found_details(exception),
              cause: exception
            )
            
          when Domain::Exception::BusinessViolation
            raise BusinessError.new(
              code: 'BUSINESS_RULE_VIOLATION',
              message: 'Business rule violation',
              details: { rule: extract_business_rule(exception) },
              cause: exception
            )
            
          else
            raise SystemError.new(
              code: 'UNKNOWN_ERROR',
              message: 'Unknown error occurred',
              details: { original_exception: exception.class.name },
              cause: exception
            )
          end
        end
  
        private
  
        def self.extract_validation_details(exception)
          case exception.message
          when /email is invalid/
            { 
              field: 'email', 
              reason: 'invalid_format', 
              message_key: 'errors.details.validation.email_invalid_format'
            }
          when /password is too short/
            { 
              field: 'password', 
              reason: 'too_short', 
              message_key: 'errors.details.validation.password_too_short'
            }
          when /id is required/
            { 
              field: 'id', 
              reason: 'required', 
              message_key: 'errors.details.validation.id_required'
            }
          else
            { field: 'unknown', reason: 'validation_failed' }
          end
        end
  
        def self.extract_not_found_details(exception)
          case exception.message
          when /id is required/
            { 
              field: 'id', 
              reason: 'required',
              message_key: 'errors.details.validation.id_required'
            }
          when /name is required/
            { 
              field: 'name', 
              reason: 'required',
              message_key: 'errors.details.validation.name_required'
            }
          else
            { field: 'unknown', reason: 'required' }
          end
        end
  
        def self.extract_business_rule(exception)
          exception.message
        end
      end
    end
  end