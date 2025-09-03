FactoryBot.define do
  factory :create_app_user_cmd, class: Application::Command::CreateAppUserCmd do
    name { 'test' }
    email { 'test@example.com' }
    is_first_register { true }
    role_id { 1 }

    initialize_with do
        new(
          name: name,
          email: email,
          is_first_register: is_first_register,
          role_id: role_id
        )
    end
  end

  trait :admin_role do
    role_id { 1 }
  end

  trait :general_role do
    role_id { 2 }
  end
  
end