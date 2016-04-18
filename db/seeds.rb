country = Country.create name: 'Россия'

team = Team.create name: 'Первая', country: country

sport = Sport.create name: 'Бокс'

discipline = Discipline.create name: 'Легкий вес мужчины', sport: sport

location = Location.create name: 'Стадион Туймаада'

event = Event.create start_at: Time.current+4.days, location: location, discipline: discipline

athlete = Athlete.create name: 'Борисов Е.А.', team: team

d_team = DisciplineTeam.create rank: 1, discipline: discipline, team: team

# athlete.discipline_teams << d_team

participation = Participation.create discipline_team: d_team, event: event
