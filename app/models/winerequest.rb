class Winerequest < ActiveRecord::Base

  attr_reader :budget, :numPeople

  def initialize(money, people)
    begin
      @budget = money.to_i
      @numPeople = people.to_i
    rescue
      @budget = ""
      @numPeople = ""
    end
  end

  def valid?
    if @budget.is_a? Integer and @numPeople.is_a? Integer and @budget != 0 and @numPeople != 0
      true
    else
      false
    end
  end

  def save
  end
  
  def save?
  end

end
