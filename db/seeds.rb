country = Country.create name: { ru: 'Россия', en: 'Russia' }

location = Location.create name: { ru: 'Стадион Туймаада', en: 'Tuimaada Stadium' }

sport = Sport.create name: { ru: 'Бокс', en: 'Box' }, location: location

discipline = Discipline.create name: { ru: 'Легкий вес мужчины', en: 'Light weight male' }, sport: sport

contest = Contest.create start_at: Time.current+4.days, discipline: discipline

athlete = Athlete.create name: { ru: 'Борисов Е.А.', en: 'Borisov E.A.' }, country: country

team = Team.create discipline: discipline, country: country

team.athletes << athlete

participation = Participation.create team: team, contest: contest

event = Event.create sport: sport, start_date: Time.current+3.days, end_date: Time.current+5.days
