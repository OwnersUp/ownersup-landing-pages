module LinkHelpers
  def nav_link(link_text, page_url, options = {})
    options[:class] ||= "nav-link"
    if current_page.url.length > 1
      current_url = current_page.url.chop
    else
      current_url = current_page.url
    end
    options[:class] << " active" if page_url == current_url

    content_tag :li, options do
      link_to(link_text, page_url)
    end
  end
end
