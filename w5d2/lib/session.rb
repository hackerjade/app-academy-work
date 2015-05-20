require 'json'
require 'webrick'

class Session
  def initialize(req)
    @cookies = {}
    req.cookies.each do |cookie|
      if cookie.name == "_rails_lite_app"
        @cookies = JSON.parse(cookie.value)
      end
    end
  end

  def [](key)
    @cookies[key]
  end

  def []=(key, val)
    @cookies[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new(
      "_rails_lite_app",
      @cookies.to_json
    )
  end
end
