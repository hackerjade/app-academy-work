require 'uri'

class Params
  def initialize(req, route_params = {})
    [req.query_string, req.body].each { |param| parse_n_build(param)}
    route_params.each { |k, v| params[k] = v  }
  end

  def [](key)
    @params[key]
  end

  def params
    @params ||= ActiveSupport::HashWithIndifferentAccess.new
  end

  def parse_n_build(param)
    param ? parse_www_encoded_form(param) : params
  end

  def to_s
    @params.to_json.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  def build_params(data)
    data.each do |pair|
      key, value, current = pair.first, pair.last, params
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

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end

  def parse_www_encoded_form(www_encoded_form)
    queries, data = URI::decode_www_form(www_encoded_form), []
    queries.each do |key, value|
      data << [parse_key(key), value]
    end

    build_params(data)
  end
end
