module RegdetailsHelper

  def get_user_semester user
    @regdetails = user.regdetails
    return @regdetails[0].semester.name
  end

  def check_course id
    reg = Regdetail.where(user_id: current_user.id, course: id)
    puts "-------- checking -------"
     not reg.empty?
  end

end
