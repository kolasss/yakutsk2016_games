user = User.create email: "user", password: "123", password_confirmation: "123"

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


15.times do |i|
  location = Location.create!(
    name: { ru: "Стадион #{i}", en: "Stadium #{i}" },
    info: { ru: "Стадион лалала #{i}", en: "Stadium lololo #{i}" },
    address: { ru: "фыв Стадион лалала #{i}", en: "asd Stadium lololo #{i}" }
  )
end

p "locations created"

3.times do |i|
  location_offset = rand(Location.count)
  location = Location.offset(location_offset).first
  start_time = Time.current+(30+rand(3)).days

  event = Event.create!(
    location: location,
    start_date: start_time,
    end_date: start_time+5.hours,
    info: { ru: "Событие культурное #{i}", en: "Cultural Event #{i}" }
  )
end

p "cultural events created"

30.times do |i|
  location_offset = rand(Location.count)
  location = Location.offset(location_offset).first
  format = Sport.formats.to_a.sample(1)[0][0]

  sport = Sport.create!(
    name: { ru: "Спорт #{i}", en: "Sport #{i}" },
    location: location,
    info: { ru: "Супер спорт инфо #{i}", en: "Sport information #{i}" },
    format: format
  )

  rand(2..8).times do |j|
    discipline = Discipline.create!(
      name: { ru: "Дисциплина #{i}-#{j}", en: "Discipline #{i}-#{j}" },
      sport: sport
    )
    case format
    when 'grid'
      parent_contest = Contest.create!(
        start_at: Time.current+(30+rand(3)).days,
        discipline: discipline,
        name: { ru: "Финал", en: "Final" }
      )
      2.times do
        contest_1 = Contest.create!(
          start_at: Time.current+(30+rand(3)).days,
          discipline: discipline,
          parent: parent_contest,
          name: { ru: "Полуфинал", en: "1/2" }
        )
        2.times do
          contest_2 = Contest.create!(
            start_at: Time.current+(30+rand(3)).days,
            discipline: discipline,
            parent: contest_1,
            published_at: Time.current+(30+rand(3)),
            name: { ru: "четвертьфинал", en: "1/4" }
          )
        end
      end
    when 'circular'
      12.times do |c_i|
        published_at = c_i.even? ? Time.current+(30+rand(3)) : nil
        contest = Contest.create!(
          start_at: Time.current+(30+rand(3)).days,
          discipline: discipline,
          published_at: published_at,
          name: { ru: "групповая #{c_i}", en: "group #{c_i}" }
        )
      end
    when 'simple'
      3.times do |c_i|
        published_at = c_i.even? ? Time.current+(30+rand(3)) : nil
        contest = Contest.create!(
          start_at: Time.current+(30+rand(3)).days,
          discipline: discipline,
          published_at: published_at,
          name: { ru: "соревнование #{c_i}", en: "contest #{c_i}" }
        )
      end
    end
  end

  rand(1..2).times do |k|
    start_time = Time.current+(30+rand(3)).days
    event = Event.create!(
      sport: sport,
      start_date: start_time,
      end_date: start_time+5.days,
      info: { ru: "Событие #{sport.name[:ru]} #{i}", en: "Event #{sport.name[:en]} #{i}" }
    )
  end
  p "sport #{i} created"
end

p "sports created"

30.times do |i|
  country = Country.create!(
    name: { ru: "Страна #{i}", en: "Country #{i}" },
    info: { ru: "Описание страны лалала #{i}", en: "Country information lololo #{i}" }
  )
  100.times do |j|
    athlete = Athlete.create!(
      name: { ru: "Атлет #{i}-#{j}", en: "Athlete #{i}-#{j}" },
      country: country,
      info: { ru: "Описание спортсмена лалала #{i}", en: "Athlete information lololo #{i}" }
    )
  end

  15.times do |i|
    sport_offset = rand(Sport.count)
    sport = Sport.offset(sport_offset).first

    athletes_offset = rand(country.athletes.count)
    country_athletes = country.athletes.offset(athletes_offset).limit(10)
    disciplines = sport.disciplines.sample(rand(2..5))

    disciplines.each do |discipline|
      team_size = [1, 2, 5].sample
      team_name = team_size == 1 ? nil : { ru: "Команда #{i}", en: "Team #{i}" }
      rank = rand(1..5)
      team = Team.create!(
        discipline: discipline,
        country: country,
        name: team_name,
        rank: rank
      )

      team_athletes = country_athletes.sample(team_size)
      team.athletes = team_athletes

      contests = discipline.contests.sample(rand(2..3))

      contests.each do |contest|
        format = sport.format
        participations_count = contest.participations.count
        full_two_teams = (format == "grid" || format == "circular") && participations_count == 2
        next if full_two_teams || participations_count > 7

        score = nil
        rank = nil
        if contest.published?
          score = rand(3)
          rank = rand(1..5)
        end
        participation = Participation.create!(
          team: team,
          contest: contest,
          score: score,
          rank: rank
        )
      end
    end
  end
  p "country #{i} created"
end

p "countries created"
