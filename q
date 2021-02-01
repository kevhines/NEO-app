
[1mFrom:[0m /home/kevhines/code/labs/Mod1/NEO-app/lib/API.rb:24 API.get_passes_for_date:

     [1;34m6[0m: [32mdef[0m [1;36mself[0m.[1;34mget_passes_for_date[0m(date)
     [1;34m7[0m:     url = [31m[1;31m"[0m[31mhttps://api.nasa.gov/neo/rest/v1/feed?start_date=2015-09-07&end_date=2015-09-07&api_key=#{@@api_key}[0m[31m[1;31m"[0m[31m[0m
     [1;34m8[0m:     response = [1;34;4mHTTParty[0m.get(url)
     [1;34m9[0m:     puts [31m[1;31m"[0m[31mgot here[1;31m"[0m[31m[0m
    [1;34m10[0m: 
    [1;34m11[0m:     [1;34m# if response["message"][0m
    [1;34m12[0m:     [1;34m#     return false[0m
    [1;34m13[0m:     [1;34m#   end[0m
    [1;34m14[0m:     [1;34m# weather_hash = {zip_code: zip, name: response["name"], wind_speed: response["wind"]["speed"], temp: response["main"]["temp"], feels_like: response["main"]["feels_like"], cloud_cover: response["weather"][0]["description"]}[0m
    [1;34m15[0m:     [1;34m#Location.new(weather_hash)[0m
    [1;34m16[0m:     
    [1;34m17[0m:     [1;34m#loop through data and create all the passes[0m
    [1;34m18[0m:     pass_hash = {}
    [1;34m19[0m:     asteroid_hash = {}
    [1;34m20[0m:     response[[31m[1;31m"[0m[31mnear_earth_objects[1;31m"[0m[31m[0m].each [32mdo[0m |key, pass|
    [1;34m21[0m:         [1;34m#pass_hash = {:date => date }[0m
    [1;34m22[0m:        [1;34m# asteroid_hash = {:id => pass["id"], :name => pass["name"], :magnitude => pass["absolute_magnitude_h"], diameter => pass["estimated_diameter"]["miles"]["estimated_diameter_max"] }[0m
    [1;34m23[0m:         [1;34m#Pass.create_pass()[0m
 => [1;34m24[0m:         binding.pry
    [1;34m25[0m:     [32mend[0m
    [1;34m26[0m:     puts [31m[1;31m"[0m[31mgot data[1;31m"[0m[31m[0m
    [1;34m27[0m: [32mend[0m

