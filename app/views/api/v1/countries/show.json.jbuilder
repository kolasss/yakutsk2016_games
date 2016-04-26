json.partial! 'country', country: @country

json.sport_ids @country.sport_ids
# json.d_ids @country.discipline_ids

json.contests @published_contests,
              partial: 'api/v1/contests/contest',
              as: :contest

json.events @events,
            partial: 'api/v1/events/event',
            as: :event
