require 'rails_helper'

describe 'Listing timetracks' do
  before do
    @timetrack = create :timetrack,
                        :with_project

    login_as(create :admin)
  end

  it 'displays timetracks' do
    visit timetracks_path

    expect(page).to have_title 'Timetrack - Project Manager'
    expect(page).to have_active_navigation_items 'Timetrack', 'List of Timetrack'
    expect(page).to have_breadcrumbs 'Project Manager', 'Timetrack'
    expect(page).to have_headline 'Timetrack'

    within dom_id_selector(@timetrack) do
      expect(page).to have_css '.name a',           text: 'Timetrack test name'
      expect(page).to have_css '.description pre',  text: "Timetrack test description"
      expect(page).to have_css '.project a',        text: 'Project test name'
      expect(page).to have_link 'Edit'
      expect(page).to have_link 'Delete'
    end

    within 'div.actions' do
      expect(page).to have_css 'h2', text: 'Actions'
      expect(page).to have_link 'Create Timetrack'
    end
  end
end
