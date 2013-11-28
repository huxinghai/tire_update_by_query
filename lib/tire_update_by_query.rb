require "tire_update_by_query/version"
require 'tire/index'
require 'tire_update_by_query/index'

module Tire
  module Model
    module UpdateByQuery

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def index_update_by_query(*args)
          options = args.extract_options!
          _type = args[0] || self.tire.document_type
          self.index.update_by_query(_type, options)
        end
      end
    end
  end
end