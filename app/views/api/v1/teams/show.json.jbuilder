json.partial! 'team', team: @team

json.team_memberships @team_memberships,
                      partial: 'api/v1/team_memberships/team_membership',
                      as: :team_membership

# json.athletes @athletes,
#               partial: 'api/v1/athletes/athlete',
#               as: :athlete
