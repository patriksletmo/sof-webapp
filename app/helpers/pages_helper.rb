module PagesHelper
  def page_elements
    page = Nokogiri::HTML(@page['content'])
    page.css('body').children.each { |elem| yield elem}
  end
end
