class Result < ActiveRecord::Base
  has_and_belongs_to_many :simulations

  def csv_file_path sim
    File.join(ENV['HOME'], "/crimson_files/", App.find(1).name.downcase.tr(' ', '_'), sim.job_directory_name, 'results', 'data', 'iterative.csv')
  end

  def csv_data
    cols = []
    row_count = 0
    simulations.each do |sim|
      col_data = []
      CSV.foreach(csv_file_path(sim), {headers: true}) do |row|
        row_count += 1
        col_data << row[y_var]
      end
      cols << col_data
    end

    CSV.generate do |csv|
      header_row = ["x"]
      simulations.each do |sim|
        header_row << sim.name
      end
      csv << header_row
      (1..row_count).each do |row|
        row_data = [row]
        cols.each do |col|
          row_data << col[row]
        end
        csv << row_data
      end
    end
  end
end
