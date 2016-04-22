json.partial! 'sport', sport: @sport

# json.country @country, partial: 'api/v1/countries/country', as: :country
# json.sport @sport, partial: 'api/v1/sports/sport', as: :sport

json.country_ids @sport.country_ids
# json.countries @sport.countries

json.contests @published_contests,
              partial: 'api/v1/contests/contest',
              as: :contest

json.disciplines @disciplines,
                 partial: 'api/v1/disciplines/discipline',
                 as: :discipline
