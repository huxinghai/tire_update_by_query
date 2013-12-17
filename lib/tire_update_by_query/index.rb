module Tire
  class Index
    def update_by_query(type, options = {})
      options.symbolize_keys!
      raise ArgumentError, "Please pass a document type" unless type
      raise ArgumentError, "Please pass a query" unless options.key?(:query)
      unless options.key?(:script) || options.key?(:update)
        raise ArgumentError, "Please pass a update or script"
      end
      _params = options[:update]
      options.delete(:update)
      (options[:params] ||= {}).merge!(_params)
      options[:script] = join_field(_params) unless options.key?(:script)
      url = "#{self.url}/#{type}/_update_by_query"
      Configuration.client.post url, MultiJson.encode(options)
    ensure
      curl = %Q|curl -X POST "#{url}" -d '#{MultiJson.encode(options, :pretty => Configuration.pretty)}'|
      logged('update_by_query', curl)
    end

    private
    def join_field(params)
      format_options(params).map{|v| "ctx._source.#{v}=#{v}" }.join(";")
    end

    def format_options(opts, key = "", values = [])
      opts.each do |k, v|
        _key = key.empty? ? k : "#{key}.#{k}"
        if v.is_a?(Hash)
          format_options(v, _key, values)
        else
          values << _key
        end
      end
      values
    end
  end
end