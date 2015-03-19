class AdminData
  attr_reader :app_hex_code
  attr_reader :test
  attr_reader :app_bin
  attr_reader :batch_queue

  def initialize
    if File.exists? File.join(Rails.root, ".admin_data")
      info = IO.readlines File.join(Rails.root, ".admin_data")
      @app_hex_code = info[0].chomp
      @test = info[1].chomp == "true" ? true : false
      @app_bin = info[2].chomp
      @batch_queue = info[3].chomp
    end
  end

  def app_hex_code=(hex)
    self.app_hex_code = hex
    File.open(File.join(Rails.root, ".admin_data"), "w") do |file|
      file.puts hex
      file.puts self.test
      file.puts self.app_bin
      file.puts self.batch_queue
    end
  end

  def test=(bool)
    self.test = bool
    begin
      File.open(File.join(Rails.root, ".admin_data"), "w") do |file|
        file.puts self.app_hex_code
        file.puts bool ? "true" : "false"
        file.puts self.app_bin
        file.puts self.batch_queue
      end
      true
    rescue
      false
    end
  end

  def app_bin=(bin)
    self.app_bin = bin
    begin
      File.open(File.join(Rails.root, ".admin_data"), "w") do |file|
        file.puts self.app_hex_code
        file.puts self.test
        file.puts bin
        file.puts self.batch_queue
      end
      true
    rescue
      false
    end
  end

  def batch_queue=(queue)
    self.batch_queue = queue
    begin
      File.open(File.join(Rails.root, ".admin_data"), "w") do |file|
        file.puts self.app_hex_code
        file.puts self.test
        file.puts self.app_bin
        file.puts queue
      end
      true
    rescue
      false
    end
  end
end
