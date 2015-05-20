module Phase6
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern, @http_method, @controller_class, @action_name =
        pattern, http_method, controller_class, action_name
    end

    # checks if pattern matches path and method matches request method
    def matches?(req)
      req.path.match(pattern) &&
      req.request_method.downcase.to_sym == http_method
    end

    # use pattern to pull out route params (save for later?)
    # instantiate controller and call controller action
    def run(req, res)
      if matches?(req)
        md = req.path.match(pattern)
        route_params = {}
        md.names.each_with_index do |name, idx|
          route_params[name] = req.path.match(pattern)[idx + 1]
        end
        controller = controller_class.new(req, res, route_params)
        controller.invoke_action(action_name)
      end
    end
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
end
