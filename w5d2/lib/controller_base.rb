require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'
require_relative './params'
require_relative './session'


class ControllerBase
  attr_reader :params, :req, :res

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = Params.new(req, route_params)
    @already_built_response = false
  end

  def already_built_response?
    @already_built_response
  end

  def invoke_action(name)
    self.send(name)
    render(name) unless already_built_response?
  end

  def redirect_to(url)
    raise Exception if already_built_response?
    @res["Location"] = url
    @res.status = 302
    @already_built_response = true
    session.store_session(@res)
  end

  def render(template_name)
    controller_name = self.class.to_s.underscore
    template_path = "views/#{controller_name}/#{template_name}.html.erb"
    template_content = ERB.new(File.read(template_path)).result(binding)

    render_content(template_content, "text/html")
  end

  def render_content(content, content_type)
    raise Exception if already_built_response?
    @res.body = content
    @res.content_type = content_type
    @already_built_response = true
    session.store_session(@res)
  end

  def session
    @session ||= Session.new(@req)
  end
end
