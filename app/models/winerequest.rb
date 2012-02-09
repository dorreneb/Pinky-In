class Winerequest < ActiveRecord::Base

  attr_reader :budget, :numPeople

  validates :budget, :presence => true
  validates :numPeople, :presence => true

  def initialize(money, people)
    @budget = money
    @numPeople = people
  end

  def save
  end
  
  def save?
  end

end
