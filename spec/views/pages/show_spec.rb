require 'rails_helper'

RSpec.describe "pages/show" do # Type braucht's glaubs nicht!
  before { @user = create :user, :donald }

  describe "Rendering notes" do
    before { assign :page, create(:page, creator: @user).decorate }

    it 'renders to admins' do
      allow(controller).to receive(:current_user).and_return(create :admin)
      render
      expect(rendered).to have_selector('.notes')
    end

    it "doesn't render to normal users" do
      allow(controller).to receive(:current_user).and_return(create :user)
      render
      expect(rendered).not_to have_selector('.notes')
    end
  end

  describe "Rendering images" do
    before { assign :page, create(:page, images: [create(:image, creator: @user)], creator: @user).decorate }

    it 'renders to admins' do
      allow(controller).to receive(:current_user).and_return(create :admin)
      render
      expect(rendered).to have_selector('.images')
    end

    it "doesn't render to normal users" do
      allow(controller).to receive(:current_user).and_return(create :user)
      render
      expect(rendered).not_to have_selector('.images')
    end
  end

  describe "Rendering codes" do
    before { assign :page, create(:page, codes: [create(:code, creator: @user)], creator: @user).decorate }

    it 'renders to admins' do
      allow(controller).to receive(:current_user).and_return(create :admin)
      render
      expect(rendered).to have_selector('.codes')
    end

    it "doesn't render to normal users" do
      allow(controller).to receive(:current_user).and_return(create :user)
      render
      expect(rendered).not_to have_selector('.codes')
    end
  end
end
