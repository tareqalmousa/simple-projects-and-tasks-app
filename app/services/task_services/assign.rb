module TaskServices
  class Assign < ApplicationService

    attr_reader :user_id, :task_id

    def initialize user_id, task_id
      @task_id = task_id
      @user_id = user_id
    end

    def call
      ActiveRecord::Base.transaction do
        check_task_exists?
        check_user_exists?
        assign_task_to_user
      rescue StandardError => e
        result false, e.message, nil
      end
    end

   private

    def check_task_exists?
      @prev_task = Task.find_by(id: @task_id.to_i)
      raise StandardError, "Task Doesn't exist" unless @prev_task.present?
    end

    def check_user_exists?
      @prev_user = User.find_by(id: @user_id.to_i)
      raise StandardError, "User Doesn't exist" unless @prev_user.present?
    end

    def assign_task_to_user
      @prev_task.update!(user_id: @user_id.to_i)
      SendPushNotificationToUser.perform_inline(@prev_user.email)
      result true, nil, @prev_task
    end

 end
end
