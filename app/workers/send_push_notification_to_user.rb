class SendPushNotificationToUser
  include Sidekiq::Job
  sidekiq_options retry: 0
  queue_as :notification

  def perform(email)
    SendMailToUserMailer.new.send_mail(email).deliver
  end
end
