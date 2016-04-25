json.partial! 'athlete', athlete: @athlete

json.contests @published_contests,
              partial: 'api/v1/contests/contest',
              as: :contest
