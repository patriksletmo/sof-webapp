def find_link_in(email, with_title)
  content = Nokogiri::HTML(email)
  link_tags = content.css('a')
  matching_tag = link_tags.find { |x| x.text == with_title }
  unless matching_tag.nil?
    matching_tag['href']
  end
end