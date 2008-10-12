$:.unshift "#{File.dirname(__FILE__)}/../test"
require 'abstract_unit'
require 'active_lastfm'

class ActiveLastfmTest < Test::Unit::TestCase
  def feed(name)
    path = File.dirname(__FILE__) + "/../test/fixtures/#{name}.xml"
    return nil unless File.exists?(path)
    File.read path
  end

  def setup
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get "/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&artist=cher&method=artist.search", {}, feed("artist.search")
      mock.get "/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=track.search&track=Belive", {}, feed("track.search")
      mock.get "/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&artist=cher&method=artist.gettoptracks", {}, feed("artist.track.search")
    end
  end

  def test_site
    assert_equal(URI.parse('http://ws.audioscrobbler.com/2.0/'), ActiveLastfm.site)
  end

  def test_artist_search
    result = ActiveLastfm.find(:first, :params => {
        :api_key => 'b25b959554ed76058ac220b7b2e0a026',
        :artist  => 'cher',
        :method  => 'artist.search',
    })
    assert_not_nil result
    assert_not_nil result.results.artistmatches
    assert_equal 20, result.results.artistmatches.artist.size
  end

  def test_track_search
    result = ActiveLastfm.find(:first, :params => {
        :api_key => 'b25b959554ed76058ac220b7b2e0a026',
        :track  => 'Belive',
        :method  => 'track.search',
    })
    assert_not_nil result
    assert_not_nil result.results.trackmatches
    assert_equal 20, result.results.trackmatches.track.size
  end

  def test_artist_track_search
    result = ActiveLastfm.find(:first, :params => {
        :api_key => 'b25b959554ed76058ac220b7b2e0a026',
        :artist  => 'cher',
        :method  => 'artist.gettoptracks',
    })
    assert_not_nil result
    assert_not_nil result.toptracks
    assert_equal 50, result.toptracks.track.size
  end
end
