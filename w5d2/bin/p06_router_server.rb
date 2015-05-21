require 'webrick'
# require_relative '../lib/phase6/controller_base'
# require_relative '../lib/phase6/router'
require_relative '../lib/flash.rb'
require_relative '../lib/session.rb'
require_relative '../lib/router.rb'
require_relative '../lib/params.rb'

require_relative '../lib/controller_base.rb'


# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

$cats = [
  { id: 1, name: "Curie" },
  { id: 2, name: "Markov" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Curie loves string!" },
  { id: 2, cat_id: 2, text: "Markov is mighty!" },
  { id: 3, cat_id: 1, text: "Curie is cool!" }
]

class StatusesController < ControllerBase
  def index
    statuses = $statuses.select do |s|
      s[:cat_id] == Integer(params[:cat_id])
    end

    render_content(statuses.to_s, "text/text")
  end
end

class Cats2Controller < ControllerBase
  def index
    render_content($cats.to_s, "text/text")
  end
end

class Cats3Controller < ControllerBase
  def index
    render(:index)
  end

  def go
    flash["go"] = "i'm going"
    redirect_to "http://localhost:3000/catsy"
  end

  def show
    @params
    render :show
  end

  def stay
    flash.now["stay"] = "I'm staying"
    render :stay
    # redirect_to "http://localhost:3000/catsy"
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/cats$"), Cats2Controller, :index
  get Regexp.new("^/catsy$"), Cats3Controller, :index
  get Regexp.new("^/catsy/1$"), Cats3Controller, :show
  get Regexp.new("^/catsy/2$"), Cats3Controller, :show
  get Regexp.new("^/catsy/3$"), Cats3Controller, :show
  get Regexp.new("^/go$"), Cats3Controller, :go
  get Regexp.new("^/stay$"), Cats3Controller, :stay

  get Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
