require 'json'
require 'webrick'

class Flash
  def initialize(req)
    req.cookies.each do |cookie|
      @old_cookies = JSON.parse(cookie.value) if cookie.name == "_flash"
    end

    @old_cookies ||= {}
    @new_cookies = {}
  end

  def [](key)
    @old_cookies[key] || @new_cookies[key]
  end

  def []=(key, val)
    @new_cookies[key] = val
  end

  def now
    @old_cookies
  end

  def store_flash(res)
    cookie = WEBrick::Cookie.new(
      "_flash",
      @new_cookies.to_json
    )
    cookie.path = "/"
    res.cookies << cookie
  end
end
