namespace :sample_data do
  desc "Loads database with sample data"
  task load: :environment do
    # Create Projects
    [
      ["Test Project", "My Test Project Description"],
      ["Project B", "my description"]
    ].each do |project|
      puts "creating project: name='#{project[0]}', description='#{project[1]}'"
      Project.create({name: project[0], description: project[1]})
    end
  end
end
