module WebstoreHelper
  def cost(num)
    "#{number_with_delimiter(num, delimiter: ' ')} SEK"
  end

  def date(datetime)
    if datetime.present?
      datetime.to_time.in_time_zone('Stockholm').strftime('%F %R')
    end
  end

  def user(user_obj)
    if is_self(user_obj)
      "Du - #{user_obj['display_name']}"
    else
      "#{user_obj['display_name']} (#{user_obj['email']})"
    end
  end

  def user_alt(user_obj)
    if is_self(user_obj)
      "Dig - #{user_obj['display_name']}"
    else
      user(user_obj)
    end
  end

  def is_self(user_obj)
    user_obj['id'] == current_user['id']
  end
end
