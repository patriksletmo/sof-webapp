class OrchestraManagementController < NavigationController
  def index
    return if require_login!

    @orchestras = database.all_orchestras
    unless @orchestras.success?
      render status: 403
    end

    respond_to do |format|
      format.html
      format.csv {
      	@item_summary = database.item_summary
        send_data @item_summary.encode('iso-8859-1'), 
        :filename => "item_summary" + "-#{Date.today}.csv", 
        :type => 'text/csv; charset=iso-8859-1; header=present'
      }
    end
  end

  def extra_performances
    return if require_login!

    respond_to do |format|
      format.html
      format.csv {
        extra_performances = database.extra_performances
        send_data extra_performances.encode('iso-8859-1'),
            :filename => "extra_performances" + "-#{Date.today}.csv",
            :type => 'text/csv; charset=iso-8859-1; header=present'
      }
    end
  end

  def anniversary
    return if require_login!

    respond_to do |format|
      format.html
      format.csv {
        anniversary = database.anniversary
        send_data anniversary.encode('iso-8859-1'),
                  :filename => "anniversary" + "-#{Date.today}.csv",
                  :type => 'text/csv; charset=iso-8859-1; header=present'
      }
    end
  end

  def allergies
    return if require_login!

    respond_to do |format|
      format.html
      format.csv {
        allergies = database.allergies
        send_data allergies.encode('iso-8859-1'),
                  :filename => "allergies" + "-#{Date.today}.csv",
                  :type => 'text/csv; charset=iso-8859-1; header=present'
      }
    end
  end

  def lintek_rebate
    return if require_login!

    respond_to do |format|
      format.html
      format.csv {
        lintek = database.lintek_rebate
        send_data lintek.encode('iso-8859-1'),
            :filenmame => "orchestra_lintek" + "-#{Date.today}.csv",
            :type => 'text/csv; charset=iso-8859-1; header=present'
      }
    end
  end
end
