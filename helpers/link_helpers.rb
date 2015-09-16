module LinkHelpers
  def nav_link(link_text, page_url, options = {})
    options[:class] ||= ""
    if current_page.url.length > 1
      current_url = current_page.url.chop
    else
      current_url = current_page.url
    end
    options[:class] << " active" if page_url == current_url

    content_tag :li, :class => "nav-link" do
      link_to(link_text, page_url, options)
    end
  end
end
