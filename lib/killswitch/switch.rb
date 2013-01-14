class Switch

  def kill!
    #kill that sumbitch
    #mechanize goes here
    raise "The author of this switch did not redefine this method"
  end

  def self.name
    raise "The author of this switch did not redefine this method"
  end

  def name
    self.class.name
  end

end