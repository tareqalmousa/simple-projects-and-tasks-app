module TaskServices
  class Creator < ApplicationService

    attr_reader :title, :project_id

    def initialize project_id, title
      @project_id = project_id
      @title = title
    end

    def call
      ActiveRecord::Base.transaction do
        check_project_exists?
        create_task
      rescue => e
        result false, e.message, nil
      end
    end

   private

    def check_project_exists?
      prev_project = Project.find_by id: @project_id.to_i
      raise StandardError, "Project Doesn't exist" unless prev_project.present?
    end

    def create_task
      @task = Task.create!(title: @title, project_id: @project_id, status: Task.statuses['open'])
      result true, nil, @task
    end

 end
end
