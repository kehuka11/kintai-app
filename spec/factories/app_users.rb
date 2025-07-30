FactoryBot.define do
  factory :app_users, class: Infrastructure::Database::AppUser::AppUsers do
    id { SecureRandom.uuid }
    name { 'test user' }
    email { 'test8721953@example.com' }
    password { 'password' }

    trait :name_blank do
      name { '' }
    end

    trait :name_too_long do
      name { 'a' * 256 }
    end

    trait :email_blank do
      email { '' }
    end

    trait :email_invalid do
      email { 'invalid_email' }
    end

    trait :email_too_long do
      email { 'a' * 256 }
    end

    trait :password_blank do
      password { '' }
    end

    trait :password_too_short do
      password { 'short' }
    end

    trait :password_too_long do
      password { 'a' * 256 }
    end

    trait :id_blank do
      id { '' }
    end

    trait :id_too_long do
      id { 'a' * 256 }
    end

  end
end
