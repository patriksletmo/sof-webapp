class Page < ApplicationRecord

  def elements
    page = Nokogiri::HTML(content)
    page.css('body').children.each { |elem| yield elem}


  end

end
