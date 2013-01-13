#!/usr/bin/env ruby
require 'rubygems'
require 'thor'
require './lib/killswitch'

class Killswitch < Thor
  attr_accessor :killer

  def initialize(*)
    super
    @killer = Killer.new
  end

  desc "install APP_NAME", "install one of the available killswitches"
  def install(name)

  end

  desc "uninstall APP_NAME", "uninstall one of the installed killswitches"
  def uninstall(name)

  end
  
  desc "list [SEARCH]", "list all of the available killswitches"
  map "-L" => :list
  def list(search="")
    # list everything
  end

  desc "config APP_NAME", "configure one of the installed killswitches"
  def config(name)
    # config
  end

  desc "configview APP_NAME", "display config of installed killswitches"
  def configview
    # config
  end

  desc "kill", "run all installed killswitches"
  method_options :force => :boolean, :alias => :string
  def kill
    # aw lawdy
  end

end

Killswitch.start