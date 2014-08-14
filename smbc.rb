require 'rss'
require 'open-uri'
require 'nokogiri'

#(1..3237).each do |id|
comics = {}
(1..3240).map do |id|
    # Generate URI
    uri = "http://www.smbc-comics.com/?id=#{id}"
    puts "Fetching page at #{uri}."

    # Get the document
    doc = Nokogiri::HTML(open(uri))

    # Get the comic URL
    comic = doc.css('div#comicimage img')[0]
    comicUrl = comic.attribute('src').to_s

    # Get the aftercomic url
    aftercomic = doc.css('div#aftercomic img')[0]
    aftercomicUrl = aftercomic.attribute('src').to_s

    # Parse out the date
    date = (!comicUrl.match(/\/(\d{8})/).nil?) ?
        comicUrl.match(/\/(\d{8})/)[1].insert(4, '-').insert(7, '-') :
        Time.now.to_s

    comics[comicUrl] = {
        'url' => comicUrl,
        'aftercomicUrl' => aftercomicUrl,
        'date' => date,
        'id' => id
    }
end

# Create ATOM feed
feed = RSS::Maker.make('rss2.0') do |maker|

    # Feed metadata
    maker.channel.title = 'Saturday Morning Breakfast Cereal'
    maker.channel.author = 'Zach Weiner'
    maker.channel.updated = Time.now.to_s
    maker.channel.link = 'http://www.smbc-comics.com/archives.php'
    maker.channel.description = 'SMBC archives feed.'

    comics.each do |url, comic|

        # Generate the content string
        content = "<p><img src=\"#{comic['url']}\"></p>"
        content << "<p><img src=\"#{comic['aftercomicUrl']}\"></p>" if !comic['aftercomicUrl'].empty?

        # Output the feed item
        maker.items.new_item do |item|
            item.id = comic['comicUrl']
            item.title = "Comic #{comic['id']}"
            item.link = comic['url']
            item.updated = comic['date']
            item.description = "<![CDATA[#{content}]]>"

        end

    end

end

# Convert escaped angle brackets
output = feed.to_s
    .gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
    .gsub!(/&quot;/, '"')

# Write the feed to a file, smbc.atom
File.open('smbc.xml', 'w') { |file| file.write(output) }