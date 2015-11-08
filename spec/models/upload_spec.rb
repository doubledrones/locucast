require 'rails_helper'

RSpec.describe Upload, type: :model do
  let(:described_object) { create(:upload) }

  subject { described_object }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:uploaded_files) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:name) }

  describe '#token' do
    let(:token) { described_object.token }

    it 'is autogenerated before save' do
      expect(token).to be_present
    end

    it 'is Digest::SHA256.hexdigest' do
      expect(token.size).to eq(64)
    end
  end

  describe "#uploaded_files_ordered" do
    subject { described_object.uploaded_files_ordered }

    let!(:uploaded_file_1) { create(:uploaded_file, upload: described_object) }
    let!(:uploaded_file_2) { create(:uploaded_file, upload: described_object) }
    let!(:uploaded_file_3) { create(:uploaded_file, upload: described_object) }

    before do
      described_object.update(
        uploaded_files_order: [uploaded_file_3.id, uploaded_file_2.id, uploaded_file_1.id]
      )
    end

    it "returns uploaded_files ordered based on #uploaded_files_order" do
      expect(subject).to eq(
        [
          uploaded_file_3,
          uploaded_file_2,
          uploaded_file_1
        ]
      )
    end
  end
end
