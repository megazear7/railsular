class App < ActiveRecord::Base

  # for now we don't want to have to manually create the app when we start up a new server, so create the app if it doesn't exist
  def self.find id
    app = find_by(id: id)
    if not app
      app = App.new
      app.id = 1
    end
    app
  end
end
