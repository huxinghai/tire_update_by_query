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
      format = lambda do |opts|
        f, value, lm = lambda{|k, vl| vl.is_a?(Hash) ? lm.call(k, vl) : value << k }, [], lambda{|k, vl| vl.each{|kl, v| f.call("#{k}.#{kl}", v)} }
        lm.call("", opts)
        value
      end
      options[:script] = format.call(_params[:update]).map{|v| "ctx._source.#{v}=#{v}" }.join(";")
      url = "#{self.url}/#{type}/_update_by_query"
      Configuration.client.post url, MultiJson.encode(options)
    ensure
      curl = %Q|curl -X POST "#{url}" -d '#{MultiJson.encode(options, :pretty => Configuration.pretty)}'|
      logged('update_by_query', curl)
    end
  end
end