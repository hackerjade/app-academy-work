require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      [req.query_string, req.body].each { |param| parse_n_build(param)}
      route_params.each { |k, v| params[k] = v  }
    end

    def parse_n_build(param)
      param ? parse_www_encoded_form(param) : params
    end

    def [](key)
      @params[key]
    end

    def params
      @params ||= ActiveSupport::HashWithIndifferentAccess.new
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      queries = URI::decode_www_form(www_encoded_form)
      data = []
      queries.each do |key, value|
        data << [parse = parse_key(key), value]
      end
         build_params(data)
    end

    # def merge_queries()

    def build_params(data)
      data.each do |pair|
        key = pair.first
        value = pair.last
        current = params
        key.each_with_index do |k, i|
          if i == key.length - 1
            current[k] = value
          else
            current[k] ||= {}
            current = current[k]
          end
        end
      end

      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
