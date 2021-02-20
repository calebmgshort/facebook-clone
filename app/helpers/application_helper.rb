module ApplicationHelper
  def limit_string(string, length=18)
    if string.length < length
      string
    else
      string[0..(length-2)] + ".."
    end
  end
end
