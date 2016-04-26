json.country @country, partial: 'api/v1/countries/country', as: :country
json.sport @sport, partial: 'api/v1/sports/sport', as: :sport

json.contests @published_contests,
              partial: 'api/v1/contests/contest',
              as: :contest

json.disciplines @disciplines do |discipline|
  # json.partial! 'api/v1/disciplines/discipline', discipline: discipline
  json.merge! discipline.attributes

  json.athletes discipline.athletes.where(athletes: {country_id: @country}),
              partial: 'api/v1/athletes/athlete',
              as: :athlete
end

json.athletes @athletes,
              partial: 'api/v1/athletes/athlete',
              as: :athlete
