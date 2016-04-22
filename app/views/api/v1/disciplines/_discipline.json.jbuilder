json.merge! discipline.attributes

json.contests discipline.contests,
              partial: 'api/v1/contests/contest',
              as: :contest
