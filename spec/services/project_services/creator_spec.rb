require 'rails_helper'

RSpec.describe ProjectServices::Creator, type: :model do
  describe '#call' do
    let (:user) { create_user }

    context 'When create a project' do
      it 'project is valid' do
        project_service = ProjectServices::Creator.call(user.id, 'title', 'description')
        expect(project_service.success?).to eq(true)
        expect(project_service.error).to eq(nil)
      end

      it 'project is invalid' do
        project_service = ProjectServices::Creator.call(0, 'title', 'description')
        expect(project_service.success?).to eq(false)
        expect(project_service.error).to eq("User Doesn't exist")
      end
    end

  end
end
