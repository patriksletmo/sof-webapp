module WebstoreHelper
  def cost(num)
    "#{number_with_delimiter(num, delimiter: ' ')} SEK"
  end

  def date(datetime)
    datetime.to_time.strftime('%F %R')
  end

  def user(user_obj)
    if is_self(user_obj)
      'Du'
    else
      "#{user_obj['display_name']} (#{user_obj['email']})"
    end
  end

  def user_alt(user_obj)
    if is_self(user_obj)
      'Dig'
    else
      user(user_obj)
    end
  end

  def is_self(user_obj)
    user_obj['id'] == current_user['id']
  end
end
