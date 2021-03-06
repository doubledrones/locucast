require 'rails_helper'

describe '/chapters', :type => :request do
  subject { post request_url, query }

  include_context :vcr_chain
  let(:vcr_chain_cassettes) { :upload_url_mp3 }

  let(:request_url) { '/chapters' }
  let(:query) { {} }

  context 'when unauthenticated' do
    before { subject }

    it 'redirects to login form' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when authenticated' do
    before do
      login_as(user, :scope => :user)
    end

    let(:query) do
      {
        "url"=>"https://locucast.s3.amazonaws.com/uploads%2F1446896910415-8mcz3zgh72ai3sor-fc3f6b9942b170e9fec3f28906543ef6%2Fimage.png",
        "filepath"=>"/uploads%2F1446896910415-8mcz3zgh72ai3sor-fc3f6b9942b170e9fec3f28906543ef6%2Fimage.png",
        "filename"=>"image.png",
        "filesize"=>"2716",
        "lastModifiedDate"=>"Sat Nov 07 2015 11:35:51 GMT+0100 (CET)",
        "filetype"=>"image/png",
        "unique_id"=>"8mcz3zgh72ai3sor",
        "file"=>"https://locucast.s3.amazonaws.com/uploads%2F1446896910415-8mcz3zgh72ai3sor-fc3f6b9942b170e9fec3f28906543ef6%2Fimage.png",
        "upload_id"=>upload.id
      }
    end
    let(:user) { create(:user) }
    let!(:upload) { create(:upload, user: user) }

    it "redirects to Upload" do
      subject

      expect(response).to redirect_to(audiobook_path(assigns(:upload)))
    end

    it "creates UploadedFile" do
      expect { subject }.to change { upload.uploaded_files.count }.by(1)

      uploaded_file = UploadedFile.last
      expect(uploaded_file.url).to eq(
        "https://locucast.s3.amazonaws.com/uploads/1446896910415-8mcz3zgh72ai3sor-fc3f6b9942b170e9fec3f28906543ef6/image.png"
      )
    end
  end
end
