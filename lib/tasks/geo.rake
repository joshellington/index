require 'json'

namespace :geo do
  desc "TODO"
  task add_coords: :environment do
    Business.all.each do |business|
      url = URI.encode('https://query.yahooapis.com/v1/public/yql?q=select * from geo.placefinder where text="'+business.address+', '+business.city+'"&format=json')
      # puts url.inspect
      begin
        results = JSON.parse(open(url).read)["query"]

        unless business.lat
          if results["results"]["Result"]["latitude"]
            puts "Updating #{business.name}..."
            business.lat = results["results"]["Result"]["latitude"]
            business.lng = results["results"]["Result"]["longitude"]
            business.save
          else
            puts "No coords exist for #{business.name}..."
          end
        else
          puts "Coords already exist for #{business.name}..."
        end
      rescue Exception => e
        puts "#{url}"
        puts "Bad response: #{e}"
      end
    end
  end

end
