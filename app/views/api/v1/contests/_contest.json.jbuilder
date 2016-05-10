json.merge! contest.as_json

json.participations contest.participations,
                    partial: 'api/v1/participations/participation',
                    as: :participation
