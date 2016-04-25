json.partial! 'location', location: @location

json.events @events,
            partial: 'api/v1/events/event',
            as: :event
