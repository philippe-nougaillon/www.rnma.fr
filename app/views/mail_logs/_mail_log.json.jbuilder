json.extract! mail_log, :id, :from, :to, :subject, :message_id, :created_at, :updated_at
json.url mail_log_url(mail_log, format: :json)
