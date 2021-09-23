//
//  ViewController.swift
//  WeatherApp
//
//  Created by Darya on 9/17/21.
//

import UIKit
import ApiNetwork

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class ViewController: UIViewController {
    
    @IBOutlet var weatherWidget: [UIView]!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var windStrength: UILabel!
    let tableView = UITableView()
    private var datePicker: UIDatePicker = UIDatePicker()
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var condition: UILabel!
    
    var location: String?
    
//    fileprivate let data = [
//        CustomData(title: "The Islands!", url: "maxcodes.io/enroll", backgroundImage: UIImage(named: "Partly")!),
//        CustomData(title: "Subscribe to maxcodes boiiii!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
//        CustomData(title: "StoreKit Course!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
//        CustomData(title: "Collection Views!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
//        CustomData(title: "MapKit!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
//    ]
    
    var weatherData = [Weather]() {
        didSet {
            DispatchQueue.main.async {
                print(self.weatherData[0].forecast.forecastday.count)
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
                self.tableView.reloadData()
                self.cityName.text = self.weatherData[0].location.name
                self.date.text = self.weatherData[0].location.localtime
                self.temperature.text = "\(self.weatherData[0].current.tempC)°C"
                self.condition.text = self.weatherData[0].current.condition.text
                self.windStrength.text = "\(self.weatherData[0].current.windKph) mph"
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
    
//    fileprivate let tableView: UITableView = {
//        let layout = UITableView()
//        //layout.scrollDirection = .horizontal
//        let cv = UITableView(frame: .zero)
//        cv.translatesAutoresizingMaskIntoConstraints = false
//        //cv.register(TableCell.self, forCellWithReuseIdentifier: "cell")
//        return cv
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.weatherWidget[0].layer.cornerRadius = 15
        view.addSubview(collectionView)
        view.addSubview(tableView)
        self.view.addSubview(datePicker)
        collectionView.backgroundColor = .clear
//        collectionView.delegate = self
//        collectionView.dataSource = self
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
//        tableView.delegate = self
//        tableView.dataSource = self
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
            print("location")
        }
        else {
            location = "Minsk"
        }
    }
    
    func getData() {
        let weatherRequest = WeatherRequest(location: location ?? "Minsk")
        weatherRequest.fetchData{ [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self?.weatherData.append(weather)
            }
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        print("Selected value \(selectedDate)")
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(weatherData.count)
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor(named: "DarkBackground")
        cell.layer.cornerRadius = 10
        cell.data = self.weatherData[0].forecast.forecastday[0]
        return cell
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableCell
        cell.backgroundColor = .clear
        cell.data = self.weatherData[0].forecast.forecastday[0].hour[indexPath.row*3]
        return cell
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
