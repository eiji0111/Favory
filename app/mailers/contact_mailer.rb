class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(
      from: @contact.email,
      to: ENV['WELCOME_MAILER_ADDRESS'],
      subject: 'Favoryお問い合わせ通知'
    )
  end
end
