require 'sinatra'
require 'active_support/all'

require 'nokogiri'
require 'open-uri'
require 'uri'

def parse rss_contents
	doc = Nokogiri::XML rss_contents
	id = 0
  doc.search('item').map do |doc_item|
    item = {}
    item[:link] = doc_item.at('link') ? doc_item.at('link').text : 'No Link'
    item[:title] = doc_item.at('title') ? doc_item.at('title').text : 'No Title'
    item[:pubDate] = doc_item.at('pubDate') ? doc_item.at('pubDate').text : 'No Publication Date'
    item[:author] = doc_item.at('author') ? doc_item.at('author').text : 'No Author'
    item[:description] = doc_item.at('description') ? doc_item.at('description').text : 'No description'
    item[:id] = id
    id += 1
    item
	end
end

feed = 'http://api.flickr.com/services/feeds/groups_pool.gne?id=1373979@N22&lang=en-us&format=rss_200'

get '/' do
	@feed = feed # Need to show original location of feed
	@reads = parse open(feed)
  erb :index
end

post '/' do
	puts feed
	feed = valid_uri?(params[:rss_source]) ? params[:rss_source] : feed
	@reads = parse open(feed)
	@feed = feed # Need to show original location of feed
	erb :index
end

helpers do
	def valid_uri?(uri)
		uri =~ URI::regexp
	end
end
