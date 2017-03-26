class FunkisController < NavigationController
  def index

  end

  def categories
    @categories = all_categories
  end

  def application
    return if require_login!
    return if require_incomplete!

    present_or_save_to funkis_application_shifts_url
  end

  def shift_selection
    return if require_login!
    return if require_step! 1
    return if require_incomplete!

    @categories = all_categories

    present_or_save_to funkis_application_agreement_url
  end

  def agreement
    return if require_login!
    return if require_step! 2
    return if require_incomplete!

    @is_fadder = false
    current_user['funkis_application']['funkis_shift_applications'].each do |app|
      if app['funkis_shift']['funkis_category']['name'] == "Zazu"
        @is_fadder = true;
      end
    end

    present_or_save_to funkis_application_complete_url
  end

  def show
    return if require_login!
    return if require_step! 3

    @funkis_application = current_user['funkis_application']
    @total_points = calculate_total_points
  end

  private

  def all_categories
    cats = database.funkis_categories

    # Sort the funkis_shifts per day
    cats.each do |category|
      days = Hash.new { |h, k| h[k] = [] }
      category['available_shifts'].each do |shift|
        if days.key?(shift['day'])
          days[shift['day']] << shift
        else
          days[shift['day']] = [shift]
        end
      end
      category['funkis_shifts'] = days
    end
  end

  def require_step!(step)
    funkis_application = current_user['funkis_application']
    if funkis_application.nil?
      redirect_to funkis_application_url
      return true
    end

    steps_completed = funkis_application['steps_completed']
    if steps_completed < step
      flash[:error] = 'Du har inte färdigställt ett tidigare steg'
      redirect_to url_for_step(steps_completed)
      true
    else
      false
    end
  end

  def require_incomplete!
    funkis_application = current_user['funkis_application']
    if funkis_application.nil? || funkis_application['terms_agreed_at'].nil?
      false
    else
      redirect_to funkis_application_complete_url
      true
    end
  end

  def present_or_save_to(redirect_url)
    if request.post?
      if save_application.success?
        redirect_to redirect_url
      else
        flash.now[:error] = 'Kunde inte spara anmälan'
        @funkis_application = params
      end
    else
      @funkis_application = current_user['funkis_application'] || {}
    end

    @total_points = calculate_total_points
  end

  def save_application
    funkis_application = current_user['funkis_application']
    if funkis_application.nil?
      database.create_funkis_application(params.to_unsafe_h)
    else
      database.update_funkis_application(funkis_application['id'], params.to_unsafe_h)
    end
  end

  def url_for_step(step)
    case step
      when 0
        funkis_application_url
      when 1
        funkis_application_shifts_url
      when 2
        funkis_application_agreement_url
      else
        funkis_application_url
    end
  end

  def calculate_total_points
    total = 0
    if @funkis_application and @funkis_application['funkis_shift_applications']
      @funkis_application['funkis_shift_applications'].each { |x| total += x['funkis_shift']['points'] }
    end
    total
  end
end
