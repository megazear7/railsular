namespace :app do
  task create: :environment do
    App.create(id: 1)
  end
end
