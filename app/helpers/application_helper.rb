# frozen_string_literal: true

module ApplicationHelper
  # rubocop:disable Rails/OutputSafety
  def markdown(text)
    options = %i[hard_wrap autolink no_intra_emphasis fenced_code_blocks]
    Markdown.new(text, *options).to_html.html_safe
  end
  # rubocop:enable Rails/OutputSafety
end
