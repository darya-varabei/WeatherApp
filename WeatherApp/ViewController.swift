//
//  ViewController.swift
//  WeatherApp
//
//  Created by Darya on 9/17/21.
//

import UIKit
import NetApi
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var weatherWidget: [UIView]!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var windStrength: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var switchTablesButton: UIButton!
    
    fileprivate let tableView = UITableView()
    private var datePicker: UIDatePicker = UIDatePicker()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    fileprivate var cities: [FeaturedCity]?
    fileprivate var citiesData = [Weather]()
    
    var location: String? {
        didSet {
            getData()
            getFeaturedData()
            tableView.reloadData()
        }
    }
    
    var showCurrentDay: Bool = true {
        didSet {
            tableView.reloadData()
            if self.showCurrentDay{
            tableView.register(TableCell.self, forCellReuseIdentifier: "cell1")
            }
            else {
                tableView.register(ForecastCell.self, forCellReuseIdentifier: "cell2")
            }
        }
    }
    
    fileprivate var weatherData = [Weather]() {
        didSet {
            DispatchQueue.main.async {
                print(self.weatherData[0].forecast.forecastday.count)
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.tableView.reloadData()
                self.cityName.text = self.weatherData[0].location.name
                self.date.text = self.weatherData[0].location.localtime
                self.temperature.text = "\(self.weatherData[0].current.tempC)°C"
                self.condition.text = self.weatherData[0].current.condition.text
                self.windStrength.text = "\(self.weatherData[0].current.windKph) mph"
                              }
        }
    }
    
    fileprivate var forecastData = [Welcome]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        fetchCities()
        getFeaturedData()
        self.weatherWidget[0].layer.cornerRadius = 15
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
        self.view.addSubview(datePicker)
        collectionView.backgroundColor = .clear
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 0)
        collectionView.topAnchor.constraint(equalTo:self.weatherWidget[0].bottomAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        collectionView.showsHorizontalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableCell.self, forCellReuseIdentifier: "cell1")
        tableView.sectionIndexColor = .clear
        tableView.backgroundColor = .clear
        tableView.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -94).isActive = true
        tableView.showsVerticalScrollIndicator = false
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor(named: "BackgroundBasic")
        datePicker.tintColor = UIColor(named: "BasicYellow")
        datePicker.timeZone = NSTimeZone.local
        datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged(_:)), for: .valueChanged)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = location {
            print(location)
        }
        else {
            location = "London"
        }
    }
    
    func getData() {
        
        if let _ = location {
            print(location)
        }
        else {
            location = "London"
        }
        var weatherRequest = WeatherRequest(location: self.location ?? "Minsk")
        weatherRequest.fetchData{ [weak self] (result : Result<[Weather],WeatherError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.weatherData.append(contentsOf: weather)
            }
        }
        weatherRequest.fetchData{ [weak self] (result : Result<[Welcome],WeatherError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.forecastData.append(contentsOf: weather)
            }
        }
    }
    
    func getFeaturedData() {
        print(cities?.count)
        if cities?.count != nil{
        for city in cities! {
            var weatherRequest = WeatherRequest(location: city.cityName ?? "London")
        print(city.cityName)
        weatherRequest.fetchData{ [weak self] (result : Result<[Weather],WeatherError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.citiesData.append(contentsOf: weather)
            }
        }
        }
        }
    }
    
    func fetchCities() {
        
        do {
            self.cities = try context.fetch(FeaturedCity.fetchRequest())
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        catch {
            print("Cities fetch failed")
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        print("Selected value \(selectedDate)")
    }
    
    @IBAction func switchTables(_ sender: UIButton) {
        if self.switchTablesButton.title(for: .normal) == "16 Days forecast" {
            self.switchTablesButton.setTitle("Day forecast", for: .normal)
            self.showCurrentDay = false
            self.tableView.reloadData()
        }
        else {
            self.switchTablesButton.setTitle("16 Days forecast", for: .normal)
            self.showCurrentDay = true
            self.tableView.reloadData()
        }
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(citiesData.count)
        return citiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor(named: "DarkBackground")
        cell.layer.cornerRadius = 10
        cell.data = self.citiesData[indexPath.item]
        return cell
    }
    
    private func collectionView(_ collectionView: UICollectionView, didSelectRowAtIndexPath indexPath: IndexPath) {
        print("cell1")
        self.location = self.citiesData[indexPath.item].location.name
        self.view.reloadInputViews()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showCurrentDay {
            return 24
        }
        else {
            return 16
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if showCurrentDay{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableCell
            cell.backgroundColor = .clear
            cell.data = self.weatherData[0].forecast.forecastday[0].hour[indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ForecastCell
            cell.backgroundColor = .clear
            cell.data = self.forecastData[0].data[indexPath.row]
            return cell
        }
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
