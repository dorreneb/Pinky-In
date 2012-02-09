class WinerequestController < ApplicationController
  require 'net/http'

def form
  # will render view/winerequest/form.html.erb
end

def search

  #render 'results'
  query = Winerequest.new(params[:budget], params[:numPeople])


  baseURI=URI.parse("http://services.wine.com/api/beta2/service.svc/json")
  key="64ba3033b310a41261d07d4a95726bd5"
  temp=URI.parse("/catalog?filter=categories(490+124)&offset=10&size=5&apikey=#{key}")

  @bottles = getRequiredBottles(query.budget.to_i)
  @pricePer = query.budget.to_i/@bottles
  #@pricePer.round_to(2)

  @results = Net::HTTP::Get.new(baseURI,temp)

  if query.valid?
    render 'results'
  else
    flash[:notice] = "Error: invalid entries."
    render 'form'
  end

end

def getRequiredBottles(numPeople)
  glassPerBottle=5.to_i
  glassPerPerson=2.to_i
  num = (numPeople.to_i * glassPerPerson)/glassPerBottle;
  num
end

<<<<<<< HEAD

=======
def persists?
  false
end
>>>>>>> 3c00fb0952db20e2147caee6f5c84ecd0bc09867

end
