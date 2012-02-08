class WinerequestController < ApplicationController

def form
  # will render view/winerequest/form.html.erb
end

def search
  render 'results'
end

end
