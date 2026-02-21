require_relative 'config/application'
require 'resque/tasks'
require 'resque/scheduler/tasks'

task 'resque:setup' => :environment

Rails.application.load_tasks
