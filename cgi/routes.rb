#!/usr/bin/ruby

begin
  require './application'
  require './controller/application_controller'
  LOAD_DIR = %w(model controller)
  LOAD_DIR.each do |dir|
    Dir.glob("./#{dir}/*.rb").each do |file|
      require file
    end
  end

  #create controller
  controller_name = Application.get_controller_and_action_name[:controller]
  action_name = Application.get_controller_and_action_name[:action] || "index"
  @controller = Kernel.const_get([controller_name, "_controller"].join.split("_").map(&:capitalize).join).new

  #call action
  eval "@controller.#{action_name}"

  #render view
  @controller.render

rescue Exception
  # when exctption 404 Not Found

  puts "Status: 404 Not Found\n"
  puts "Content-Type: text/html\n\n"
  puts ""
  puts ""
  puts ""
  puts "404 Not Found "
  puts ""

  #write to stderr
  $stderr.puts "#{$!} (#{$!.class})"
  $stderr.puts $@.join("\n")
end
