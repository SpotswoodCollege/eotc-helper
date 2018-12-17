# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/activity_upcoming
  def activity_upcoming
    NotificationsMailer.activity_upcoming
  end

end
