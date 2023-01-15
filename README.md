# README

This is simple projects and tasks api app, allow you to create projects, create tasks on it and assign to people

* Ruby version: 2.7.4

* Rails version: 7.0.4

* System dependencies: N/A

* Configuration: N/A

* Setup project

The application can be run by 
- docker container
  1 - run docker-compose build
  2 - run docker-compose run web rails db:create db:migrate
  3 - run docker-compose up
 
- Run Server
  1 - rails db:create db:migrate
  2 - rails s
  3 - bundle exec sidekiq
  Please make sure you have postgresql run on 5432, and redis run on 6379

* How to run the test suite: rspec
  Coverage report generated for RSpec under /coverage. (39.34%) covered

Example:

1 -  Registration,
      POST signup_url, params: {
      user: {
      name: user.name,
      email: user.email,
      password: user.password
      }
      }

2 -  Login,
      POST '/api/login', params: {
      user: {
      email: user.email,
      password: user.password
      }
      }

3 -  Create_project,
      POST /users/:id/create_project, params: {
      title: "title",
      description: "description"
      }

4 -  Create_task,
      POST create_task, params: {
      title: "title",
      projectId: "projectId"
      }

5 -  Assign_task,
      POST assign_task, params: {
      userId: "userId",
      taskId: "taskId"
      }




