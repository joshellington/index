require 'json'
require "i18n"

# doc = Nokogiri::HTML(open("http://www.yelp.com/search?find_desc=&find_loc=Pearl+District%2C+Portland%2C+OR&ns=1&ls=9fbb9a4f4cd59ca1#start=990", "User-Agent" => "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4"))

namespace :fetch do
  desc "Fetch Yelp API data."
  task yelp: :environment do
    $search_neighborhoods = [
      'Lloyd District',
      'Mississippi',
      'Northwest',
      'Pearl District',
      'Sellwood',
      'Southeast Portland',
      'Southwest Portland',
      'Hawthorne',
      'Buckman',
      'Alberta Arts District',
      'Alphabet District'
    ]

    def search(neighborhood)
      params = {
        limit: 20
      }

      results = Yelp.client.search("#{neighborhood}, Portland, OR", params)
      total = results.total
      puts total
      total_requests = (results.total / 20).ceil
      
      # for i in 1..total_requests
      for i in 1..total_requests
        offset = i * 20
        page_params = {
          limit: 20,
          offset: offset
        }

        puts page_params.inspect

        puts "//////////////////////////"
        puts Time.now
        puts "Current offset: #{offset}"
        puts '--------------------------'

        page_results = Yelp.client.search("#{neighborhood}, Portland, OR", page_params)

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

    def init
      $search_neighborhoods.each do |n|
        puts "Searching #{n}..."
        search(n)
      end
    end

    init()
  end

  desc "TODO"
  task seatgeek: :environment do
  end

  desc "Fetch Google Places data."
  task google_places: :environment do
    lat = 45.523062
    lng = -122.676482
  end

  desc "Scrape Yelp pages."
  task yelp_scrape: :environment do
    $search_neighborhoods = [
      'Lloyd+District',
      'Mississippi',
      'Northwest',
      'Pearl+District',
      'Sellwood',
      'Southeast+Portland',
      'Southwest+Portland',
      'Hawthorne',
      'Buckman',
      'Alberta+Arts+District',
      'Alphabet+District'
    ]

    $search_neighborhoods.each do |hood|
      open('./tmp/biz_names.txt', 'a') do |f|
        f.puts "---"
        f.puts "#{hood}"
      end

      (0..1000).step(20) do |i|
        url = "http://www.yelp.com/search?find_desc=&find_loc=#{hood}%2C+Portland%2C+OR&ns=1&ls=9fbb9a4f4cd59ca1#start=#{i}"
        puts url
        output = `phantomjs --web-security=no --ignore-ssl-errors=yes ~/Projects/phantom/parse_yelp.js "#{url}"`
        open('./tmp/biz_names.txt', 'a') do |f|
          f.puts output
        end
      end
    end    
  end

  task yelp_snippet_scrape: :environment do
    $search_neighborhoods = [
      'Lloyd District',
      'Mississippi',
      'Northwest',
      'Pearl District',
      'Sellwood',
      'Southeast Portland',
      'Southwest Portland',
      'Hawthorne',
      'Buckman',
      'Alberta Arts District',
      'Alphabet District'
    ]

    $search_neighborhoods.each do |hood|
      open('./tmp/biz_names.txt', 'a') do |f|
        f.puts "---"
        f.puts "#{hood}"
      end
      puts "Parsing #{hood}..."

      (0..1000).step(10) do |i|
        url = URI.encode("http://www.yelp.com/search/snippet?find_desc&find_loc=#{hood}, Portland, OR&start=#{i}&parent_request_id=cf484c9d9e4e64fb&request_origin=hash&bookmark=true")
        json = JSON.parse(open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36").read)
        html = Nokogiri::HTML(json["search_results"])
        links = html.css('a.biz-name').map { |link| link['href'] }
        links.each do |link|
          open('./tmp/biz_names.txt', 'a') do |f|
            f.puts link
          end
        end
      end
    end
  end

  task create_from_yelp_text: :environment do
    $search_neighborhoods = [
      'Lloyd District',
      'Mississippi',
      'Northwest',
      'Pearl District',
      'Sellwood',
      'Southeast Portland',
      'Southwest Portland',
      'Hawthorne',
      'Buckman',
      'Alberta Arts District',
      'Alphabet District'
    ]
    f = File.open("./tmp/biz_names.txt", "r")
    biz_keys = []
    f.each_line do |line|
      line = URI.decode(line.strip.gsub('/biz/',''))
      unless line.include? "---" or $search_neighborhoods.include? line
        # puts line
        biz_keys << line
      end
    end

    biz_keys.uniq!
    puts biz_keys.count

    biz_keys.each do |key|
      key = I18n.transliterate(key.split('/').last)
      # puts key
      begin
        business = Yelp.client.business(key)
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
      rescue Exception => e
        puts "Error with #{key}:"
        puts e.inspect
        puts '----------------------------'
      end
    end
  end

end
