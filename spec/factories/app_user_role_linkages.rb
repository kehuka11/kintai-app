FactoryBot.define do
  factory :app_user_role_linkage, class: Infrastructure::Database::AppUser::AppUserRoleLinkages do
    app_user_id { SecureRandom.uuid }
    app_user_role_id { 1 }

    initialize_with do
      new(
        app_user_id: app_user_id,
        app_user_role_id: app_user_role_id
      )
    end

    trait :app_user_id_blank do
      app_user_id { '' }
    end

    trait :app_user_id_too_long do
      app_user_id { 'a' * 256 }
    end

    trait :app_user_id_nil do
      app_user_id { nil }
    end

    trait :app_user_role_id_nil do
      app_user_role_id { nil }
    end

    trait :admin_role do
      app_user_role_id { 1 }
    end

    trait :general_role do
      app_user_role_id { 2 }
    end
  end
end
