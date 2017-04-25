json.extract! cortege_contribution, :id, :created_at, :updated_at
json.url cortege_lineup_url(cortege_contribution, format: :json)