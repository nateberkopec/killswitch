#!/usr/bin/env ruby
require 'rubygems'
require 'thor'
require './lib/killswitch'

class Killswitch < Thor
  map "-L" => :list
  
  desc "install APP_NAME", "install one of the available killswitches"
  method_options :force => :boolean, :alias => :string
  def install(name)
    user_alias = options[:alias]
    if options.force?
      # do something
    end
    # other code
  end
  
  desc "list [SEARCH]", "list all of the available killswitches"
  def list(search="")
    # list everything
  end

  desc "config APP_NAME", "configure one of the installed killswitches"
  def config(name)
    # config
  end

  desc "kill", "run all installed killswitches"
  method_options :force => :boolean, :alias => :string
  def kill
    # aw lawdy
  end

  desc "killconfig", "configure global kill behavior"
  def killconfig
    # confirm required, password required, etc
  end

end

Killswitch.start