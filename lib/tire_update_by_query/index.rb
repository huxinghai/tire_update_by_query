module Tire
  class Index
    def update_by_query(type, options = {})
      options.symbolize_keys!
      raise ArgumentError, "Please pass a document type" unless type
      raise ArgumentError, "Please pass a query" unless options.key?(:query)
      unless options.key?(:script) || options.key?(:update)
        raise ArgumentError, "Please pass a update or script"
      end
      _params = options.slice(:update)
      options.delete(:update)
      (options[:params] ||= {}).merge!(_params[:update])
      format = lambda{|opts| opts.map{|k, v| v.is_a?(Hash) ? format.call(v).map{|vl| "#{k}.#{vl.is_a?(Array) ? vl.join('.') : vl}" } : k} }
      options[:script] = format.call(_params[:update]).flatten.map{|v| "ctx._source.#{v}=#{v}" }.join(";")
      url = "#{self.url}/#{type}/_update_by_query"
      Configuration.client.post url, MultiJson.encode(options)
    ensure
      curl = %Q|curl -X POST "#{url}" -d '#{MultiJson.encode(options, :pretty => Configuration.pretty)}'|
      logged('update_by_query', curl)
    end
  end
end