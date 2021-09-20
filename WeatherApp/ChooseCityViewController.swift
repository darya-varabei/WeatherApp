//
//  ChooseCityViewController.swift
//  WeatherApp
//
//  Created by Дарья Воробей on 9/19/21.
//

import Foundation
import UIKit

class ChooseCityViewController: UIViewController {
    
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var subtitle: [UILabel]!
    @IBOutlet var chooseCityButton: [UIButton]!
    @IBOutlet var featured: [UILabel]!
    
    @IBAction func chooseCity(_ sender: Any) {
    }
    fileprivate let data = [
        CustomData(title: "The Islands!", url: "maxcodes.io/enroll", backgroundImage: UIImage(named: "Partly")!),
        CustomData(title: "Subscribe to maxcodes boiiii!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
        CustomData(title: "StoreKit Course!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
        CustomData(title: "Collection Views!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
        CustomData(title: "MapKit!", url: "maxcodes.io/courses", backgroundImage: UIImage(named: "Partly")!),
    ]
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo:self.featured[0].bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -78).isActive = true
        collectionView.showsVerticalScrollIndicator = false
        
        self.chooseCityButton[0].layer.cornerRadius = 15
        
    }
}

extension ChooseCityViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor(named: "DarkBackground")
        cell.layer.cornerRadius = 20
        cell.data = self.data[indexPath.item]
        return cell
    }
}

