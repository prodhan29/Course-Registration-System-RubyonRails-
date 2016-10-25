module RegdetailsHelper

  def get_user_semester user
    @regdetails = user.regdetails
    return @regdetails[0].semester.name
  end
end
