module ProjectServices
  class Creator < ApplicationService

    attr_reader :user_id, :title, :description

    def initialize user_id, title, description
      @user_id = user_id
      @title = title
      @description = description
    end

    def call
      ActiveRecord::Base.transaction do
        check_user_exists?
        create_project
      rescue StandardError => e
        result false, e.message, nil
      end
    end

    private

    def check_user_exists?
      prev_user = User.find_by id: @user_id.to_i
      raise StandardError, "User Doesn't exist" unless prev_user.present?
    end

    def create_project
      @project = Project.create!(title: @title, description: @description, user_id: @user_id.to_i)
      result true, nil, @project
    end

  end
end
