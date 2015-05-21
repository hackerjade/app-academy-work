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
    p "route ps #{req}"
    @params = Params.new(req, route_params)
    @already_built_response = false
  end

  def already_built_response?
    @already_built_response
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  def invoke_action(name)
    self.send(name)
    render(name) unless already_built_response?
  end

  def link_to(link_name, link_path)
    path = digest_path(link_path)
    "<a href= #{path}>#{link_name}</a>".html_safe
  end

  def digest_path(path)
    route = path.split('_')[0]
    ids = path.scan(/@(\w+)/)
    path = "http://localhost:3000/#{route}"
    ids.each do |id|
      path += "/" + id[0]
    end

    path
  end

  def button_to(button_name = nil, button_path, method)
    path = digest_path(button_path)
    button = "<form method=\"post\" action=\"#{path}\" class=\"button_to\">"
    button +=   "<input type=\"hidden\" name=\"_method\" value=\"#{method}\">"
    button +=   "<input value=\"#{button_name}\" type=\"submit\" >"
    button += "</form>"

    button.html_safe

  end

  def redirect_to(url)
    raise Exception if already_built_response?
    @res["Location"] = url
    @res.status = 302
    @already_built_response = true
    session.store_session(@res)
    flash.store_flash(@res)
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
    flash.store_flash(@res)
  end

  def session
    @session ||= Session.new(@req)
  end
end
