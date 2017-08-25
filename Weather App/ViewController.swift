//
//  ViewController.swift
//  Weather App
//
//  Created by wan muzaffar Wan Hashim on 25/08/2017.
//  Copyright © 2017 iTrain Asia Pte Ltd. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    var locationManager : CLLocationManager!
    var arrayWeather : [Weather] = []
    var iconDict : [String:Data] = Dictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let weather = arrayWeather[indexPath.row]
        cell.weatherLbl.text = weather.weather
        cell.tempLbl.text = "\(weather.temp - 273) C"
        cell.dateLbl.text = weather.date
        cell.weatherDescLbl.text = weather.weatherDesc
        if let weatherImage = iconDict[weather.iconId] {
            cell.weatherImageView.image = UIImage(data: weatherImage)
        }
        else {
            
            
            let imageURL = "https://openweathermap.org/img/w/\(weather.iconId).png"
            let url = URL(string: imageURL)
            do {
                let data = try Data(contentsOf: url!)
                cell.weatherImageView.image = UIImage(data: data)
                self.iconDict[weather.iconId] = data
                
            }
            catch {
                print("error")
            }
            
        }
        
        return cell
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        let location = locations.first!
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude

        let urlString = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appId=8131be7e3e6b2014b3af931e011bd730"
        let url = URL(string: urlString)
        
        do {
        
            let data  = try Data(contentsOf: url!)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            print(json)
            
            let results  = json["list"] as! [[String:Any]]
            for result in results {
                var temperature : Int
                var dateTime  : String
                var pressure : Double
                var humidity : Int
                var iconId : String
                var weatherDesc : String
                var weather : String
                
                let mainDict = result["main"] as! [String:Any]
                if let temp = mainDict["temp"] as! Int? {
                    temperature = temp
                    if let dateTimeTemp = result["dt_txt"] as! String?{
                        dateTime = dateTimeTemp
                        if let humidityTemp = mainDict["humidity"] as! Int? {
                            humidity = humidityTemp
                    let weatherDictArr = result["weather"] as! [[String: Any]]
                            let weatherDict = weatherDictArr.first!
                            
                            
                            
                            if let weatherDescTemp = weatherDict["description"] as! String?{
                                weatherDesc = weatherDescTemp
                                
                                if let pressureTemp = mainDict["pressure"] as! Double? {
                                    pressure = pressureTemp
                                    if let iconIdTemp = weatherDict["icon"] as! String?{
                                        iconId = iconIdTemp
                                        if let weatherTemp = weatherDict["main"] as! String?{
                                            weather = weatherTemp
                                            let newWeather = Weather(iconId: iconId, weather: weather, weatherDesc: weatherDesc, temp: temperature, humidity: humidity, pressure: pressure, date: dateTime)
                                            
                                            arrayWeather.append(newWeather)
                                        }
                                    }
                                   

                                }

                           
                            }
                        }
                    }

                }
                
            }
            self.tableView.reloadData()
        }
        catch {
            print("error")
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

