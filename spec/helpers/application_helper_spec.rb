require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#render_markdown' do
    let(:markdown_text) { '#markdown' }

    it 'returns calls Redcarpet Markdown' do
      expect(helper.render_markdown(markdown_text)).to eq("<h1>markdown</h1>\n")
    end
  end
end
