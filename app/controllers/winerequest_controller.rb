class WinerequestController < ApplicationController
  require 'open-uri'
  require 'json'


def form
  # will render view/winerequest/form.html.erb
end

def search

  query = Winerequest.new(params[:budget], params[:numPeople]) 

  if query.valid?
    @bottles = getRequiredBottles(query.numPeople)
    @pricePer = query.budget / @bottles

    baseURI=URI.parse("http://services.wine.com/api/beta2/service.svc/json")
    key="64ba3033b310a41261d07d4a95726bd5"
    types = Array["","Any","Red","White"]
    #temp=URI.parse("/catalog?filter=categories(490+124)&offset=10&size=5&apikey=#{key}")
    request = "http://services.wine.com/api/beta2/service.svc/json/catagorymap?apikey=#{key}"
    if params[:type].to_i != 1    #any=1, red=2, white=3
      request = request + "&search=#{types[params[:type].to_i]}"
    end
    

    #json = JSON.parse(open(request).read)
    return render :text => "The wine type requested is #{request} they type number was #{params[:type]}" 
    #return render :text => "bottles: #{@bottles.round(2)} with suggested price per bottle: #{@pricePer.round(2)}"

    render 'results'
  else
    flash[:notice] = "Error: invalid entries."
    render 'form'
  end

end

def getRequiredBottles(numPeople)
  glassPerBottle = 5.0
  @glassPerPerson = 2.0
  num = (numPeople * @glassPerPerson) / glassPerBottle
end

def persists?
  false
end

end
