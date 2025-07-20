require 'dry/system/container'
require 'dry/rails/container'


puts "Dry::Rails::Container is: #{defined?(Dry::Rails::Container)}"

class AppContainer < Dry::Rails::Container
  configure do |config|
    config.root = Rails.root
    config.name = :app

    config.component_dirs.add 'app/appuser' do |dir|
      dir.namespaces.add 'application', key: 'application'
    end

    config.component_dirs.add 'app/shared' do |dir|
      dir.namespaces.add 'infrastructure', key: 'infrastructure'
    end

  end
end
