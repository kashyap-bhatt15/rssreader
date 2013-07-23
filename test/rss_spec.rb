# Test cases for RSS reader
# Since live rss feeds change often I am testing it from local xml file
require_relative '../rss_reader.rb'
require_relative 'spec_helper.rb'

# set :environment, :test

describe 'RSS Reader' do
	def app
		Sinatra::Application
	end

	def find_first path
		feed = File.read path
		items = parse feed
		item = items.first
	end

	it "says RSS Reader" do
  	get '/'
  	last_response.should be_ok
  	last_response.body.should match 'RSS Reader'
	end	

  it "should find the link" do
		item = find_first 'test/fixtures/feed.xml'
		link = 'http://www.flickr.com/photos/mattcaustin/8205498382/in/pool-1373979@N22'
    
    item[:link].should eq(link)
  end

  it "should find the title" do
    item = find_first 'test/fixtures/feed.xml'
		title = 'An Evening at Shell Beach'
    
    item[:title].should eq(title)
  end

  it "should find the time" do
		item = find_first 'test/fixtures/feed.xml'
		pubDate = 'Tue, 20 Nov 2012 23:18:47 -0800'
    
    item[:pubDate].should eq(pubDate)
  end

  it "should find the author" do
		item = find_first 'test/fixtures/feed.xml'
		author = 'nobody@flickr.com (Matt Austin Photography)'
    
    item[:author].should eq(author)
  end

end