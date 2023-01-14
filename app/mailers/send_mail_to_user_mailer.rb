class SendMailToUserMailer < ActionMailer::Base
  default from: 'Team <tareqalmousa@gmail.com>'
  layout 'mailer'

  def send_mail(email)
    mail(
      to: [email],
      subject: 'Add your default settings',
      template_path: 'mailer',
      template_name: 'send_mail',
      layout: 'mailer'
    )
  end
end
