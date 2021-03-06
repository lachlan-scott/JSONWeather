### JSONWeather

This is an instructional app that uses an online API and parses the JSON response. We're using the MetaWeather website which provides a free API with a JSON feed. `https://www.metaweather.com/api/`  

![](Screenshots/Forecast.png)

The demo app is useful and good-looking, but the functionality is basic, so you should be able to think of many ways to use the information available through the API to extend the app to your liking. The finished project looks like this:



#### Background to Making HTTP JSON Requests


The API can use the Where In The World ID number for cities, and we can use the API itself to find out what the woeid is for the city we want like this `api/location/search/?query=(city name)`

Making the HTTP request `https://www.metaweather.com/api/location/search/?query=tokyo` returns
```JSON 
[{
	"title":"Tokyo",
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
	"etc":"etc"
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
}
}
```
#### Errors

You may get this error in your Simulator  
`nw_proxy_resolver_create_parsed_array PAC evaluation error: NSURLErrorDomain: -1003`

This seems to be a problem with the simulator using your Mac's network, and shouldn't be otherwise problematic


##### *Missing Table rows*  
If your app is working, but there's nothing showing in the table, it's quite common to have forgotten to set the binding between the UITableView and the UIViewController in UIBuilder (Storyboard). The obvious fix is to check that in UIBuilder!

However, there are a lot of points of failure in this app, and the code is written using 'guard' to check status at each point to help with this. You should also use the debugger and set breakpoints to be sure you have a datatask, a JSON response, received data, and data in your tableview, and it might be a good idea to use some code like this to check your tableview is wired to your viewcontroller

```Swift  
func checkDelegate() {
	if tableView.delegate?.isEqual(self))! {
		print("TableView's Delegate is Self")
	} else {
		print("This class is not tableview's delegated controller...") 
	}
}  
```

#### Project Checklist

<images>

#### UIBuilder/Storyboard

##### *Main.storyboard checklist*


Add a UINavBar
	Change its title
	Add a UIbutton (becomes rightbarbuttonitem)

Add a UITableView
	Size it to fit from the navbar to the screen bottom
	Add a UITableViewCell
		Select style: subtitle
		Set reuse identifier: eg. 'myCell'	
	

drag to viewcontroller ibAction
@IBAction func updateWeather(_ sender: Any) {
}



tableview drag to make viewcontroller delegate and datasource

@IBOutlet weak var tableView: UITableView!



Cell 
cellIdentifier
		let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")

constraints

Assets
iPhone App 7-12 2x 3x
all weather images to Assets
images are sized for 3x, put there

ViewController
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

@IBOutlet weak var tableView: UITableView!

@IBOutlet weak var navBar: UINavigationBar!





