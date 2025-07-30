module Infrastructure
  module Database
    module AppUser
      class AppUsers < ::ApplicationRecord
        validates :id, presence: true, uniqueness: true, length: { maximum: 255 }
        validates :name, presence: true, length: { maximum: 255 }
        validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
        validates :password, presence: true, length: { minimum: 8, maximum: 255 }
      end
    end
  end
end
