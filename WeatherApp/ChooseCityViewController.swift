//
//  ChooseCityViewController.swift
//  WeatherApp
//
//  Created by Дарья Воробей on 9/19/21.
//

import Foundation
import UIKit
import NetApi
import CoreData

class ChooseCityViewController: UIViewController {
    
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var subtitle: [UILabel]!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet var featured: [UILabel]!
    @IBOutlet weak var chooseCity: UIButton!
    
    @IBAction func chooseCity(_ sender: Any) {
    }
    
    private let cities = ["Minsk", "Moskou", "London", "Paris", "Riga", "Vilnus", "Warsaw", "Stockholm", "Oslo", "Helsinki", "Copenhagen", "Madrid", "Rome", "Bristol", "Berlin", "Munich", "Stambul", "Antalya"]
    private let tableView = UITableView()
    
    private  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    fileprivate var featuredCities: [FeaturedCity]?
    fileprivate var citiesData = [Weather]()
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    @IBOutlet weak var tableWeatherView: UITableView!
    fileprivate var weatherData = [Forecastday]()
    var result: String?
    
    let citiesIdentifier = "ShowCity"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(collectionView)
        view.addSubview(tableView)
//        collectionView.backgroundColor = .clear
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 120).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -78).isActive = true
//        collectionView.showsVerticalScrollIndicator = false
        
        //elf.chooseCity.layer.cornerRadius = 15
        tableWeatherView.translatesAutoresizingMaskIntoConstraints = false
        tableWeatherView.register(TextCell.self, forCellReuseIdentifier: "text")
        self.tableWeatherView.delegate = self
        self.tableWeatherView.dataSource = self
        tableWeatherView.sectionIndexColor = .clear
        tableWeatherView.backgroundColor = .clear
        tableWeatherView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 80).isActive = true
        tableWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        tableWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27).isActive = true
        tableWeatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -94).isActive = true
        tableWeatherView.showsVerticalScrollIndicator = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showCity" {
                
                let destinationVC = segue.destination as! ViewController
                
                destinationVC.location = self.result
                
            }
        }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if  segue.identifier == citiesIdentifier,
//            let destination = segue.destination as? ViewController,
//            let blogIndex = tableView.indexPathForSelectedRow?.row
//        {
//            destination.location = cities[blogIndex]
//        }
//    }
}

extension ChooseCityViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor(named: "DarkBackground")
        cell.layer.cornerRadius = 20
        cell.layer.cornerRadius = 10
        cell.data = self.citiesData[indexPath.item]
        //cell.data = self.weatherData[0].date[indexPath.item]
        return cell
    }
}

extension ChooseCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "text", for: indexPath) as! TextCell
        cell.backgroundColor = UIColor(named: "DarkBackground")
        //cell.textLabel?.text = "Minsk"
        cell.nameCity = cities[indexPath.row]
//        cell.data = self.weatherData[0].forecast.forecastday[0].hour[indexPath.row*3]
        return cell
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCity = cities[indexPath.row]
        self.result = selectedCity
        print(result!)
        self.performSegue(withIdentifier: "showCity", sender: self)
        //print(selectedCity)
         //if such cell exists and destination controller (the one to show) exists too..
//        if let subjectCell = tableView.cellForRow(at: indexPath as IndexPath), let destinationViewController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as? ViewController{
//               //This is a bonus, I will be showing at destionation controller the same text of the cell from where it comes...
//               if let text = subjectCell.textLabel?.text {
//                   destinationViewController.location = text
//               }
////               } else {
////                   destinationViewController.textToShow = "Tapped Cell's textLabel is empty"
////               }
//             //Then just push the controller into the view hierarchy
//             navigationController?.pushViewController(destinationViewController, animated: true)
//           }
        }
}
