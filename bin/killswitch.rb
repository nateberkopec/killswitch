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
    if @killer.install(name)
      puts "#{name} installed. Switches installed: #{@killer.switches_names}"
    else
      puts "#{name} is not an available switch."
    end
  end

  desc "uninstall APP_NAME", "uninstall one of the installed killswitches"
  def uninstall(name)
    if @killer.uninstall(name)
      puts "#{name} uninstalled. Remaining: #{@killer.switches_names}"
    else 
      puts "This switch is not installed."
    end
  end

  desc "list_installed [SEARCH]", "list all of the installed killswitches"
  def list_installed(search="")
    puts "#{@killer.switches_names}"
  end
  
  desc "list [SEARCH]", "list all of the available killswitches"
  map "-L" => :list
  def list(search="")
    puts @killer.available_switches.join(", ")
  end

  desc "config APP_NAME", "configure one of the installed killswitches"
  def config(name)
    # config
  end

  desc "configview APP_NAME", "display config of installed killswitches"
  def configview(name)
    # config
  end

  desc "kill", "run all installed killswitches"
  method_options :force => :boolean, :alias => :string
  def kill
    # aw lawdy
  end

end

Killswitch.start