namespace :seatgeek do
  desc "Fetch events and more from the SeatGeek API."
  task get_events: :environment do
    sg = SeatGeek::Connection


    options = {
      "geoip" => "97214",
      "per_page" => 25,
      "page" => 1,
      "range" => "15mi"
    }

    total_events = sg.events(options)["meta"]["total"]
    total_requests_needed = (total_events / options["per_page"]).ceil

    for i in 1..total_requests_needed
      options["page"] = i
      page_results = sg.events(options)

      page_results["events"].each do |event|
        performers = []

        # ap event

        event["performers"].each do |performer|
          # ap performer
          
          p = Performer.create(
            name: performer["name"],
            short_name: performer["short_name"],
            url: performer["url"],
            image: performer["image"],
            image_large: performer["images"]["large"],
            image_huge: performer["images"]["huge"],
            seatgeek_id: performer["id"],
            score: performer["score"],
            performer_type: performer["type"],
            slug: performer["slug"]
          )

          performers << p
        end

        event_venue = event["venue"]
        # ap venue["name"]

        venue = Venue.create(
          name: event_venue["name"],
          url: event_venue["url"],
          seatgeek_id: event_venue["id"],
          score: event_venue["score"],
          city: event_venue["city"],
          state: event_venue["state"],
          postal_code: event_venue["postal_code"],
          lat: event_venue["location"]["lat"],
          lng: event_venue["location"]["lon"],
          address: event_venue["address"]
        )
        
        e = Event.create(
          title: event["title"],
          url: event["url"],
          datetime_local: event["datetime_local"],
          short_title: event["short_title"],
          datetime_utc: event["datetime_utc"],
          score: event["score"],
          event_type: event["type"],
          seatgeek_id: event["id"],
          venue: venue,
          performers: performers
        )

        ap "Created " + event["title"] + "..."
      end
    end
  end
end
