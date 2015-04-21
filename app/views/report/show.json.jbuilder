json.set! :report do
  json.extract! @report, :id, :message, :reportable_id, :reportable_type, :created_at, :updated_at
end
