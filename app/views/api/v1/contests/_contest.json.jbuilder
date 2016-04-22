json.merge! contest.attributes

json.participations contest.participations,
                    partial: 'api/v1/participations/participation',
                    as: :participation
