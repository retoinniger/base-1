require 'rails_helper'

describe TimetracksController do
  before do
    @user = create :admin
    sign_in_as @user

    @project = create :project, customer: create(:customer)
  end

  context 'creating finding' do
    it 'assigns the logged in user' do
      expect_any_instance_of(Timetrack).to receive(:user=)

      post :create, params: {timetrack: {project_id: @project.id, name: 'Testuser', description: 'Blablabla', address: 'Teststreet'}}
    end
  end
end
