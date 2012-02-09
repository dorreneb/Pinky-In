class WinerequestController < ApplicationController
  require 'net/http'

def form
  # will render view/winerequest/form.html.erb
end

def search
  
  baseURI=URI.parse("http://services.wine.com/api/beta2/service.svc/json")
  key="64ba3033b310a41261d07d4a95726bd5"
  temp=URI.parse("/catalog?filter=categories(490+124)&offset=10&size=5&apikey=#{key}")

  @bottles = getRequiredBottles(params[:numPeople])
  @pricePer = params[:budget].to_i/@bottles
  #@pricePer.round_to(2)

  @results = Net::HTTP::Get.new(baseURI,temp)
  
  return render :text => results

  #render 'results'
end

def getRequiredBottles(numPeople)
  glassPerBottle=5.to_i
  glassPerPerson=2.to_i
  num = (numPeople.to_i * glassPerPerson)/glassPerBottle;
  num
end



end
