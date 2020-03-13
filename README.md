### JSONWeather
An instructional app that uses an online API and parses the JSON response

We're using the MetaWeather website which provides a free API with a JSON feed. `https://www.metaweather.com/api/`  
The demo app is simple but useful, and looks pretty good, but you should be able to think of many ways to extend it using the information available through the API to make it quite comprehensive.

![Image description](https://github.com/lachlan-scott/JSONWeather/blob/master/Screenshots/Forecast.png)

#### Background to Making HTTP JSON Requests


The API can use the Where In The World ID number for cities, and we can use the API itself to find out what the woeid is for the city we want like this `api/location/search/?query=(city name)`

Making the HTTP request `https://www.metaweather.com/api/location/search/?query=tokyo` returns
```JSON 
[{	"title":"Tokyo",
"location_type":"City",
"woeid":1118370,
"latt_long":"35.670479,139.740921"
}]  
```  

So now we can use that woeid to construct an HTTP request for Tokyo (or any other city)
[https://www.metaweather.com/api/location/1118370/](url)

[Further Study: when the app is complete, you might think of ways to use this facility to extend the app ...]

and we'll get this content in the HTTP response from metaweather.com (complete file is in the project 'full_weather.json')
```json
{
"consolidated_weather": [  
{
"id":5869816927748096,
"weather_state_name":"Heavy Rain",
"weather_state_abbr":"hr",
"wind_direction_compass":"SE",
"created":"2020-03-10T06:20:47.406496Z",
"applicable_date":"2020-03-10",
"min_temp":13.370000000000001,
"max_temp":16.765,
"the_temp":16.175,
"wind_speed":5.458576254190196,
"wind_direction":142.82587512605093,
"air_pressure":1004.5,
"humidity":88,
"visibility":6.569446929929214,
"predictability":77		
},
{
... and more name:value weather dictionaries 
}
],		
"time":"2020-03-10T16:40:04.600642+09:00",
"sun_rise":"2020-03-10T05:57:30.455713+09:00",
"sun_set":"2020-03-10T17:44:12.547626+09:00",
"timezone_name":"JST",
"parent":{
"title":"Japan",
"location_type":"Country",
"woeid":23424856,
"latt_long":"37.487598,139.838287"
... and more like this
}
}
```
#### Errors

You may get this error in your Simulator  
`nw_proxy_resolver_create_parsed_array PAC evaluation error: NSURLErrorDomain: -1003`

it can be related to the simulator using your Mac's network, and shouldn't be problematic



#### UIBuilder/Storboard

row height
type
nav bar
title
default title
UIbutton into navbar
becomes baritem
drag to viewcontroller ibAction
@IBAction func updateWeather(_ sender: Any) {
}

uitableview
uitableviewcell
style: subtile
image

tableview drag to make viewcontroller delegate and datasource

@IBOutlet weak var tableView: UITableView!


Cell 
cellIdentifier

constraints

Assets
iPhone App 7-12 2x 3x
all weather images to Assets
images are sized for 3x, put there

ViewController
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

@IBOutlet weak var tableView: UITableView!

@IBOutlet weak var navBar: UINavigationBar!





