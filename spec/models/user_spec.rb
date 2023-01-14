require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user' do

    let (:user) { create_user }

    context 'When create a valid user' do
      it 'user is valid' do
        expect(user).to be_valid
      end
    end

    context 'When create a invalid user' do
      it 'user invalid email' do
        create_user_invalid_email
      rescue StandardError => e
        expect(e.to_s).to eq('Validation failed: Email is invalid')
      end

      it 'user email has already been taken' do
        create_user
      rescue StandardError => e
        expect(e.to_s).to eq('Validation failed: Email has already been taken')
      end
    end

  end
end
