country = Country.create name: 'Россия'

sport = Sport.create name: 'Бокс'

discipline = Discipline.create name: 'Легкий вес мужчины', sport: sport

location = Location.create name: 'Стадион Туймаада'

contest = Contest.create start_at: Time.current+4.days, location: location, discipline: discipline

athlete = Athlete.create name: 'Борисов Е.А.', country: country

team = Team.create discipline: discipline, country: country

team.athletes << athlete

participation = Participation.create team: team, contest: contest

event = Event.create sport: sport, location: location, start_date: Time.current+3.days, end_date: Time.current+5.days
