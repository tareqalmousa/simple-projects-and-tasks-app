require 'faker'
require 'factory_bot_rails'

module UserHelpers

  def create_user
    FactoryBot.create(:user,
                      name: Faker::Internet.name,
                      email: Faker::Internet.email,
                      password: Faker::Internet.password)
  end

  def build_user
    FactoryBot.build(:user,
                     name: Faker::Internet.name,
                     email: Faker::Internet.email,
                     password: Faker::Internet.password)
  end

  def create_user_invalid_email
    FactoryBot.create(:user,
                      name: Faker::Internet.name,
                      email: 'tareqlamousa@gmail',
                      password: Faker::Internet.password)
  end

end
