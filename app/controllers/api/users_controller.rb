module Api
  class UsersController < Api::BaseController

    before_action :find_user, only: %w[show create_project projects_created task_assigned]

    # GET /users/:id
    def show
      render_json_response(@user)
    end

    # POST /users/:id/create_project
    def create_project
      verify_missing_params(missing_params(params, %i[title description])) and return
      render_service(ProjectServices::Creator.call(@user.id, params['title'], params['description']))
    end

    # POST /users/create_task
    def create_task
      verify_missing_params(missing_params(params, %i[title projectId])) and return
      render_service(TaskServices::Creator.call(params['projectId'], params['title']))
    end

    # POST /users/assign_task
    def assign_task
      verify_missing_params(missing_params(params, %i[userId taskId])) and return
      render_service(TaskServices::Assign.call(params['userId'], params['taskId']))
    end

    # GET /users/:id/projects_created
    def projects_created
      render_json_response(@user.projects_created)
    end

    # GET /users/:id/task_assigned
    def task_assigned
      render_json_response(@user.task_assigned)
    end

    # GET /all_users
    def all_users
      render_json_response(User.all)
    end

    private

    def find_user
      @user = User.find(params[:id])
    rescue StandardError => e
      raise_api_error(e, 404)
    end

    def render_service(service)
      if service.success?
        render_json_response(service.result)
      else
        raise_api_error(service.error, 400)
      end
    end

    def verify_missing_params(missing_params)
      raise_api_error("missing params #{missing_params.join(', ')}", 400) unless missing_params.empty?
    end

  end

end
