require Rails.root.join("app/containers/app_container").to_s

Import = Dry::AutoInject(AppContainer)

AppContainer.finalize!
puts "==== Registered components ===="
AppContainer.keys.each { |k| puts k }