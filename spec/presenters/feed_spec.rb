require 'rails_helper'

describe Feed do
  let(:author) { 'My Audiobook Author' }
  let(:link) { 'http://test.host/feeds/my_audiobook_name' }
  let(:name) { 'My Audiobook Name' }
  let(:description) { 'My Audiobook Description' }
  let(:upload) do
    create(:upload, name: name, description: description)
  end
  let!(:uploaded_file) { create(:uploaded_file, upload: upload) }
  let(:feed) { described_class.new(upload) }

  it { expect(feed.title).to eq(name) }
  it { expect(feed.description).to eq(description) }

  xit { expect(feed.author).to eq(author) }
  xit { expect(feed.link).to eq(link) }

  describe '#items' do
    let(:items) { feed.items }

    it { expect(items).to be_an(Array) }
    it { expect(items.size).to eq(1) }
    it { expect(items.first).to be_a(Feed::Item) }
  end
end