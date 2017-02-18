module ApplicationHelper
  def database_type
    uri = URI::parse(Database.base_uri)

    if uri.host == 'localhost' or uri.host == '127.0.0.1'
      'local database'
    elsif uri.host == 'dev.db.sof17.se'
      'staging database'
    elsif uri.host == 'db.sof17.se'
      'WARNING: running with production database'
    elsif uri.host.include? '-pr-'
      "temporary database for pull request ##{pull_request_number uri}"
    end
  end

  def pull_request_number(uri)
    uri.host.split('-').last.split('.').first
  end
end
