class Feed < ActiveType::Object
  attr_reader :upload

  delegate :description, :author, :picture_url, to: :upload

  def initialize(upload)
    @upload = upload
  end

  def title
    upload.name
  end

  def image
    upload.picture_url
  end

  def items
    upload.uploaded_files_ordered.map do |uploaded_file|
      Feed::Item.new(uploaded_file, upload)
    end
  end
end
