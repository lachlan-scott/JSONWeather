//
//  ViewController.swift
//  JSONWeather
//
//  Created by Lachlan Scott on 2020/02/28.
//  Copyright © 2020 Fudoshin Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


	// MARK: Class Variables
	/// Although this UINavigationBar has no UINavigationController, we can address
	///  it directly (instead of through the Controller) to display information
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var tableView: UITableView!
	
	/// tableData is going to be an Array of Dictionaries that use String:Any for their Key:Value
	var tableData = [[String: Any]]()
	var weatherData:Data = Data()
	
	// MARK: Class Methods
	
	@IBAction func updateWeather(_ sender: Any) {
		getJSONWeather()
	}
	
	func checkDelegate() {
		if tableView.delegate != nil {
			if (tableView.delegate?.isEqual(self))! {
				print("Delegate is Self")
			}
		} else { print("Delegate is nil") }
	}
	
	func getJSONWeather (){
		
		let session = URLSession.shared
		/// You can change this to get different weather reports; see the README
		let url = URL(string: "https://www.metaweather.com/api/location/1118370/")!
		
		/// This defines the data task, but doesn't actually start it...
		let task = session.dataTask(with: url) { data, response, error in
			if error != nil || data == nil {
				print("Error: no suitable response")
				return
			}
			
			guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
				print("Error: http server error!")
				return
			}
			
			guard let mime = response.mimeType, mime == "application/json" else {
				print("Error: server provided wrong MIME response!")
				return
			}
			
			/// If the server responded as expected, then clear any old data, and load the new data
			self.tableData.removeAll()
			DispatchQueue.main.async {
				//print("Status: updating table data")
				self.tableView.reloadData()
			}
			
			do {
				let json = try JSONSerialization.jsonObject(with: data!, options: [])
				//print(json)
				
				if let dictionary = json as? [String: Any] {
					if let title = dictionary["title"] as? String {
						DispatchQueue.main.async { // Correct
							self.navBar.topItem?.title = "\(title) Forecast"
						}
					}
					
					/// We want to back the table with an indexed collection of weather dictionaries
					/// So we make an array of Dictionaries out of the 'consolidated_weather' array we obtained
					if let arrayOfWeatherDictionaries:[Dictionary] = dictionary["consolidated_weather"] as? [[String: Any]] {
						for weatherDictionary:Dictionary in arrayOfWeatherDictionaries {
							self.tableData.append(weatherDictionary)
							//print("\nWeather \(weatherDictionary["applicable_date"]!) \(weatherDictionary["weather_state_name"]!)")
						}
						DispatchQueue.main.async {
							self.tableView.reloadData()
						}
					}
				}
				
			} catch {
				print("Error: \(error.localizedDescription)")
			}
		}
		// start the http task
		task.resume()
		
		//print("Now completed the closure, tableData: \(tableData)")
	} // ---- from Action

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		checkDelegate()
	}
	
	// MARK: UITableView Protocol Methods
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 65.0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
		
		let weatherCellDict:Dictionary = tableData[indexPath.row]
		
		/** the dictionary for each date looks like this
			"weather_state_name" : "Heavy Rain",
			"weather_state_abbr" : "hr",
			"applicable_date" : "2020-03-02",
			"the_temp" : 8.075
		*/
		
		/// Use DateFormatter to convert the date from "2020-03-02" into something more readable, eg. "Fri 2 Mar 2020"
		let stringDate = weatherCellDict["applicable_date"] as! String
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from: stringDate)
		
		dateFormatter.dateFormat = "MMMM"
		let monthName = dateFormatter.string(from:date!)
		
		dateFormatter.dateFormat = "EEE"
		let dayName = dateFormatter.string(from:date!)
		
		dateFormatter.dateFormat = "dd"
		let dayNumber = dateFormatter.string(from: date!)
		
		let displayDate = String("\(dayName), \(dayNumber) \(monthName)")
		
		
		/// separate out the useful (first) part of the temperature eg. 7 from from '7.3453'
		let tempNumber = weatherCellDict["the_temp"] as! NSNumber
		var tempString = tempNumber.description
		tempString = tempString.components(separatedBy: ".")[0]
		
		let weatherString:String = weatherCellDict["weather_state_name"] as! String
		
		/// use the abbrevation for the weather to reference the image of the same name eg. light cloud = 'lc'
		/// then because we put the images into the projects Assets we can use that image name eg. image named 'lc'
		let imgRef = weatherCellDict["weather_state_abbr"] as! String
		let imageForCell =  UIImage(imageLiteralResourceName: imgRef)
		
		/// Finally, construct the table cell for the weather on that date
		cell?.textLabel?.text = displayDate
		cell?.detailTextLabel?.text = String("\(weatherString) \(tempString)°") // eg. Cloudy 7°
		cell?.imageView?.image = imageForCell
		
		return cell!
		
	}
}

