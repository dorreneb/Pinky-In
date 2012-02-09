class WinerequestController < ApplicationController

def form
  # will render view/winerequest/form.html.erb
end

def search
  query = Winerequest.new(params[:budget], params[:numPeople])

  if query.valid?
    render 'results'
  else
    flash[:notice] = "Error: invalid entries."
    render 'form'
  end
end

def persists?
  false
end

end
