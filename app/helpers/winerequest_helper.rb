module WinerequestHelper

def print_wine_json(json)
  to_output = "<li>"
  to_output += "<div class=\"wine-name\">#{json["Name"]}</div>"
  to_output += "<ul class=\"wine-details\">"
    to_output+= "<li>Suggested Retail Price: $#{json["PriceRetail"]}</li>"
    to_output+= "<li>Wine.com Score: #{get_score_from_json(json)}</li>"
  to_output += "</ul>"
  to_output += "</li>"
  return raw(to_output);
end

def get_score_from_json(json)
  score = json["Ratings"]["HighestScore"]
  score = "n/a" if score.to_i == 0 
  return score
end

end
