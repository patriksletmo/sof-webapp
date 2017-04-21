class FunkisManagementController < NavigationController
  def index
    return if require_login!

    @categories = database.funkis_categories_stats
    unless @categories.success?
      redirect_to '/'
    end
  end

  def all_funkis_applications
    return if require_login!

    respond_to do |format|
      format.html
      format.csv {
        applications = database.csv_funkis_applications
        send_data applications.encode('iso-8859-1'),
                  :filename => "funkis-applications" + "-#{Date.today}.csv",
                  :type => 'text/csv; charset=iso-8859-1; header=present'
      }
    end
  end
end
