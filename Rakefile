#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

task :add_images => :environment do
    load './add_images.rb'
    add_image_directory
end

Imrollin::Application.load_tasks