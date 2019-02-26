require 'rss'
require 'open-uri'

url = 'http://www.shiftylook.com/_comics/rss_en'
open(url) do |rss|
    feed = RSS::Parser.parse(rss)
    feed.items
        .select { |item| item.title.include? 'Tower of Babel'}
        .each { |item| puts item.inspect }
end
