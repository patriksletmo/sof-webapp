module Areas
  module PagesArea
    def page(category, page)
      get("/api/v1/pages/find/#{category}/#{page}")
    end
  end
end