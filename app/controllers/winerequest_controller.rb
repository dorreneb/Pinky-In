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

    #baseURI=URI.parse("http://services.wine.com/api/beta2/service.svc/json")
    key="64ba3033b310a41261d07d4a95726bd5"
    types = Array["","Any","Red","White"]
    request = URI.encode("http://services.wine.com/api/beta2/service.svc/json/catalog?state=NY&apikey=#{key}&filter=price(0|#{@pricePer})")
    if params[:type].to_i != 1    #any=1, red=2, white=3
      request = request + "&search=#{types[params[:type].to_i]}"
    end
    
    #return render :text => "The wine type requested is #{request} the type number was #{params[:type]}" 
    #return render :text => "bottles: #{@bottles.ceil} with suggested price per bottle: #{@pricePer.round(2)}"
 
    @json = JSON.parse(open(request).read)
    
    if @json.length <= 0
      render 'nosolution'
    else 
      render 'results'
    end
  else
    flash[:notice] = "Error: invalid entries."
    render 'form'
  end

end

def getRequiredBottles(numPeople)
  glassPerBottle = 5.0
  @glassPerPerson = params[:glassPB].to_i
  num = (numPeople * @glassPerPerson) / glassPerBottle
end

def persists?
  false
end

end
