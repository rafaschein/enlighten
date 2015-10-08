module ApplicationHelper
  def render_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

    markdown.render(text).html_safe
  end

  def counter_link(text, count, url)
    content_tag(:a, href: url, rel: 'nofollow', 'data-method': :put, class: 'counter-link') do
      content_tag(:span, text, class: 'counter-link__label') + content_tag(:span, count, class: 'counter-link__counter')
    end
  end
end
