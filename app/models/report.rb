class Report < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  after_create :send_report

  def send_report
    subject = "TotalSim App Issue Report: #{App.find(1).app_hex_code}"
    body = "app: #{App.find(1).app_hex_code}\n" +
      "id: #{reportable.id}\n" +
      "type: #{reportable.type_info}\n" +
      "path: #{reportable.path_info}\n" +
      "user: #{ENV["USER"]}\n" +
      "datetime: #{DateTime.now}"
    body += "\nmessage: #{message}"
    system "echo '#{body}' | mutt -s '#{subject}' #{App.find(1).email}"
  end
end
