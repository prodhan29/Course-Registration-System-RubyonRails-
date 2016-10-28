# Preview all emails at http://localhost:3000/rails/mailers/course_system_mailer
class CourseSystemMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/course_system_mailer/publish_result
  def publish_result
    CourseSystemMailer.publish_result
  end

end
