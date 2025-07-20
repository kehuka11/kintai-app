class ApplicationController < ActionController::Base
  # CSRF保護を無効化（APIの場合）
  skip_before_action :verify_authenticity_token
end
