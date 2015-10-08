require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#render_markdown' do
    let(:markdown_text) { '#markdown' }

    it 'returns calls Redcarpet Markdown' do
      expect(helper.render_markdown(markdown_text)).to eq("<h1>markdown</h1>\n")
    end
  end

  describe '#counter_link' do
    let(:text) { 'Follow' }
    let(:count) { 10 }
    let(:url) { '/entity/1/action' }

    it 'returns the counter link' do
      expect(helper.counter_link(text, count, url)).to eq(
        '<a href="/entity/1/action" rel="nofollow" data-method="put" class="counter-link">' \
          '<span class="counter-link__label">Follow</span>' \
          '<span class="counter-link__counter">10</span>' \
        '</a>')
    end

  end
end
