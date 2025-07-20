module Userinterface
  module AppUser
    class AppUserCreateRequest
      include ActiveModel::Model
      attr_accessor :name, :email, :isFirstRegister

      validates :name, presence: true
      validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
      validates :isFirstRegister, presence: true
      def initialize(params = {})
        @name  = params[:name]
        @email = params[:email]
        @isFirstRegister = params[:isFirstRegister]
      end
    end
  end
end
