FactoryBot.define do
  factory :app_user_domain, class: Domain::AppUser do
    id { SecureRandom.uuid.force_encoding('UTF-8') }
    name { 'test user' }
    email { 'test8721953@example.com' }
    password { 'password' }
    is_first_register { true }

    initialize_with do
      new(
        id: id,
        name: name,
        email: email,
        is_first_register: is_first_register,
        password: password
      )
    end

    trait :name_blank do
      name { '' }
    end

    trait :name_too_long do
      name { 'a' * 256 }
    end

    trait :name_nil do
      name { nil }
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

    trait :email_nil do
      email { nil }
    end

    trait :password_blank do
      password { '' }
    end

    trait :password_too_short do
      password { 'a' * 7 }
    end

    trait :password_too_long do
      password { 'a' * 256 }
    end

    trait :password_nil do
      password { nil }
    end

    trait :id_blank do
      id { '' }
    end

    trait :id_too_long do
      id { 'a' * 256 }
    end

    trait :id_nil do
      id { nil }
    end

    trait :is_first_register_nil do
      is_first_register { nil }
    end

    trait :is_first_register_blank do
      is_first_register { '' }
    end

    trait :is_first_register_invalid do
      is_first_register { 'invalid' }
    end
  end
end
