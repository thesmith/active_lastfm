## Patched ActiveResouce code
## Will follow edge code and remove when included in a release
module ActiveResource
  class Base
    def load(attributes)
      raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
      @prefix_options, attributes = split_options(attributes)
      attributes.each do |key, value|
        @attributes[key.to_s] =
          case value
            when Array
              resource = find_or_create_resource_for_collection(key)
#<<<          value.map { |attrs| resource.new(attrs) }
              value.map { |attrs| attrs.is_a?(String) ? attrs.dup : resource.new(attrs) }
            when Hash
              resource = find_or_create_resource_for(key)
              resource.new(value)
            else
              value.dup rescue value
          end
      end
      self
    end
  end

  class ConnectionError < StandardError
    def build_request_headers(headers, http_method=nil)
#<<<    authorization_header.update(default_header).update(headers).update(http_format_header(http_method))
        authorization_header.update(default_header).update(headers)
    end
  end
end
