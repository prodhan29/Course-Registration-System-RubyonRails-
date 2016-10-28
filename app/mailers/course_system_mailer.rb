class CourseSystemMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.course_system_mailer.publish_result.subject
  #
  def publish_result reciever_mail
    @greeting = "Hi"
    mail to: reciever_mail
  end
end
