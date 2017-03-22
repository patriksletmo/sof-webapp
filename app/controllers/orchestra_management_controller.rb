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
      	@total_item_summary = database.total_item_summary
        send_data @orchestra_summary.encode('iso-8859-1'), 
        :filename => "total_item_summary" + "-#{Date.today}.csv", 
        :type => 'text/csv; charset=iso-8859-1; header=present' }
    end


  end
end
