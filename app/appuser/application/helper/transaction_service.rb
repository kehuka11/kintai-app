module Application
    module Helper
        class TransactionService
            def self.transaction
                ActiveRecord::Base.transaction do
                  yield
                end
              rescue => e
                Application::Exception::ExceptionTranslate.translate(e)
            end
        end
    end
end