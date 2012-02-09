class WinerequestController < ApplicationController
  require 'net/http'

def form
  # will render view/winerequest/form.html.erb
end

def search

  query = Winerequest.new(params[:budget], params[:numPeople])

 
  if query.valid?
    baseURI=URI.parse("http://services.wine.com/api/beta2/service.svc/json")
    key="64ba3033b310a41261d07d4a95726bd5"
    temp=URI.parse("/catalog?filter=categories(490+124)&offset=10&size=5&apikey=#{key}")

    @bottles = getRequiredBottles(query.budget)
    @pricePer = query.budget/@bottles
    #@pricePer.round_to(2)

    #@results = Net::HTTP.get(baseURI,temp)

    render 'results'
  else
    flash[:notice] = "Error: invalid entries."
    render 'form'
  end

end

def getRequiredBottles(numPeople)
  glassPerBottle = 5
  glassPerPerson = 2
  num = (numPeople * glassPerPerson)/glassPerBottle;
  num
end

def persists?
  false
end

end
