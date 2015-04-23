namespace :app do
  task create: :environment do
    App.create(id: 1, iterative: true, name: "")
  end
end
