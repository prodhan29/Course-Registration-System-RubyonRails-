module AppuserHelper

  def get_result str

    puts str
    if str == "0.0" then
      return "N/A"
    end
    return str
  end
end
