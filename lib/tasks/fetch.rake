namespace :fetch do
  desc "Fetch Yelp API data."
  task yelp: :environment do
    params = {
      limit: 20
    }

    results = Yelp.client.search('Portland', params)
    total = results.total
    total_requests = (results.total / 20).ceil
    
    # for i in 1..total_requests
    for i in 1..total_requests
      offset = i * 20
      page_params = {
        limit: 20,
        offset: offset
      }

      puts "//////////////////////////"
      puts Time.now
      puts "Current offset: #{offset}"
      puts '--------------------------'

      page_results = Yelp.client.search('Portland', page_params)

      page_results.businesses.each do |business|
        neighborhoods = []
        categories = []
        parking_options = []
        
        begin
          business.location.neighborhoods.each do |name|
            neighborhood = Neighborhood.find_or_create_by(
              name: name
            )
            neighborhoods << neighborhood
          end
        rescue
        end

        begin
          business.categories.each do |category|
            category = Category.find_or_create_by(
              name: category[0],
              alias: category[1]
            )
            categories << category
          end
        rescue
        end
        
        webpage = Nokogiri::HTML(open(business.mobile_url,
          'User-Agent' => 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4'
        ))

        begin
          parking_text = webpage.at('.subtle-text:contains("Parking")').parent.parent.text.strip.gsub!("Parking","").squish

          types = parking_text.split(", ")          
          types.each do |name|
            parking_type = ParkingOption.find_or_create_by(
              name: name
            )
            parking_options << parking_type
          end

          # puts parking_options.inspect
        rescue Exception => e
          puts e.inspect
          parking_text = false
        end

        begin
          Business.create(
            yelp_id: business.id,
            name: business.name,
            image_url: business.image_url,
            url: business.url,
            mobile_url: business.mobile_url,
            phone: business.phone,
            display_phone: business.display_phone,
            review_count: business.review_count,
            rating: business.rating,
            rating_img_url_large: business.rating_img_url_large,
            snippet_text: business.snippet_text,
            address: business.location.address.join(", "),
            city: business.location.city,
            state_code: business.location.state_code,
            postal_code: business.location.postal_code,
            country_code: business.location.country_code,
            neighborhoods: neighborhoods,
            categories: categories,
            parking_options: parking_options
          )

          puts "Created #{business.name}..."
        rescue Exception => e
          puts "Error with #{business.name}:"
          puts e.inspect
          puts '----------------------------'
        end
      end
    end
  end

  desc "TODO"
  task seatgeek: :environment do
  end

  desc "Fetch Google Places data."
  task google_places: :environment do
    lat = 45.523062
    lng = -122.676482


  end

end
