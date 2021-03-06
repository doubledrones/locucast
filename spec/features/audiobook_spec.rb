require 'rails_helper'

describe 'audiobook', :type => :feature do
  it 'renders view', js: true do
    login_as(create(:user), :scope => :user)
    visit '/audiobooks/new'
    expect(page).to have_content('Add Audiobook')
    fill_in('Title', with: 'my audiobook')
    fill_in('Author', with: 'my new audiobook author')
    fill_in('Description', with: 'my new audiobook')
    # TODO: add multiple files
    #expect {
      #expect {
        #click_button('Create Upload')
      #}.to change(Upload, :count).by(1)
    #}.to change(UploadedFile, :count).by(3)
  end
end
