require 'json'
require 'webrick'

class Flash
  def initialize(req)
    @flashes = {}
    req.cookies.each do |cookie|
      if cookie.name == "_rails_lite_app"
        @flashes = JSON.parse(cookie.value)
      end
    end
  end

  def now
    @flashes[key] ||= {}
    @flashes.delete(key)
  end

  def [](key)
    @flashes[key]
  end

  def []=(key, val)
    @flashes[key] = val
  end

  def store_flash(res)
    res.cookies << WEBrick::Cookie.new(
      "_flash",
      @flashes.to_json
    )
  end
end

f = Flash.new
f.now[:errors]
