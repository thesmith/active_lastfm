require 'rubygems'
require 'activeresource'
require 'patch'

# This abstract base-class extends ActiveResource::Base to make requests to last.fm
# Based largely on the ActiveYouTube examples found at:
# * link:http://www.quarkruby.com/2008/1/15/activeresource-and-youtube
# * link:http://www.quarkruby.com/2008/3/11/consume-non-rails-style-rest-apis
# * link:http://www.quarkruby.com/2008/2/12/active-youtube
class ActiveLastfm < ActiveResource::Base
  # The core Last.fm WS URL is the only URI used in this interface
  self.site = 'http://ws.audioscrobbler.com/2.0/'

  class << self
    ## Remove format from the url.
    def element_path(id, prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{query_string(query_options)}"
    end
  
    ## Remove format from the url.
    def collection_path(prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{query_string(query_options)}"
    end

    ## For a collection call, ActiveResource formatting is not 
    ## compliant with YouTube's output.
    def instantiate_collection(collection, prefix_options = {})
      puts collection.inspect
      unless collection.kind_of? Array
        [instantiate_record(collection, prefix_options)]
      else
        collection.collect! { |record| instantiate_record(record, prefix_options) }
      end
    end
  end
end
