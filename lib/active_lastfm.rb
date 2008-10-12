require 'rubygems'
require 'activeresource'
require 'patch'

class ActiveLastfm < ActiveResource::Base
  self.site = 'http://ws.audioscrobbler.com/2.0/'
  # This abstract base-class extends ActiveResource::Base to make requests to last.fm
  # Based largely on the ActiveYouTube examples found at:
  # - http://www.quarkruby.com/2008/1/15/activeresource-and-youtube
  # - http://www.quarkruby.com/2008/3/11/consume-non-rails-style-rest-apis

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
