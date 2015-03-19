class App < ActiveRecord::Base
  def self.find id
    app = find_by(id: id)
    if not app
      app = App.new
      app.id = 1
    end
    app
  end
end
