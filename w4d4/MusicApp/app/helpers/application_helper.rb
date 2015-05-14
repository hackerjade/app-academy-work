module ApplicationHelper
  def protect_from_forgery
      html = (<<-HTML)
      <input type="hidden"
      name="authenticity_token"
      value="#{h(form_authenticity_token)}">

      HTML

      html.html_safe
  end

end
