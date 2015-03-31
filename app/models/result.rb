class Result < ActiveRecord::Base
  has_and_belongs_to_many :simulations

  def csv_file_path
    File.join(ENV['HOME'], "/crimson_files/", 'test.csv')
  end

  def csv_data
    if File.exists?(csv_file_path)
      source = CSV.open(csv_file_path)
      CSV.generate do |csv|
        source.each do |row|
          csv << row
        end
      end
    else
      # TODO we need a better way to deal with the file not existing
      CSV.generate do |csv|
        csv << ["No File"]
        csv << ["0"]
      end
    end
  end
end
