class NotificationsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.activity_upcoming.subject
  #
  def activity_upcoming
    @user = params[:user]
    @activity = params[:activity]

    mail to: @user.email
  end
end
