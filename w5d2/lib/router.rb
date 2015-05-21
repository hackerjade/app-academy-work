class Route
  # extend RouteHelper
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method, @controller_class, @action_name =
      pattern, http_method, controller_class, action_name
  end

  def matches?(req)
    req.path.match(pattern) &&
    req.request_method.downcase.to_sym == http_method
  end

  def run(req, res)
    if matches?(req)
      route_match_data, route_params = req.path.match(pattern), {}
      route_match_data.names.each_with_index do |key, idx|
        route_params[key] = route_match_data[idx + 1]
      end

      controller = controller_class.new(req, res, route_params)
      controller.invoke_action(action_name)
    end
  end
end

module RouteHelper
  # (post_path(@post) = "")

end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, http_method, controller_class, action_name)
    @routes << Route.new(pattern, http_method, controller_class, action_name)
  end

  def draw(&proc)
    instance_eval(&proc)
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end

  end

  def match(req)
    match = @routes.select { |route| route.matches?(req) }

    match.empty? ? nil : match
  end

  def run(req, res)
    match(req) ? match(req)[0].run(req, res) : res.status = 404
  end
end
