//
//  HospitalsVC.swift
//  HealthWebServices
//
//  Created by Himanshu Joshi on 29/12/19.
//  Copyright © 2019 Himanshu Joshi. All rights reserved.
//

import UIKit
import MapKit

@available(iOS 13.0, *)
class ItemVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    var namesArray = [String]()
    var phoneArray = [String]()
    var urlArray = [String]()
    var addressArray = [String]()
    var distanceBtnArray = [String]()
    var coordinateArray = [CLLocationCoordinate2D]()
    var itemCategory = ""
    var itemLocationLabel = ""
    
    let tableView: UITableView = UITableView()
    
    func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 75, width: self.view.frame.width, height: self.view.frame.height - 100)
        tableView.register(UINib(nibName: "ItemsCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        tableView.rowHeight = 141.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        self.view.addSubview(tableView)
    }
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20.0)
        return button
    }()
    func setupDoneButton() {
        self.view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.isUserInteractionEnabled = true
        doneButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        doneButton.addTarget(self, action: #selector(done), for: .allTouchEvents)
    }
    @objc func done() {
        self.dismiss(animated: true, completion: remove)
    }
    func remove() {
        namesArray.removeAll()
        phoneArray.removeAll()
        urlArray.removeAll()
        addressArray.removeAll()
        distanceBtnArray.removeAll()
        coordinateArray.removeAll()
    }
    let hospitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        return label
    }()
    func setupHospitalLabel() {
        self.view.addSubview(hospitalLabel)
        hospitalLabel.translatesAutoresizingMaskIntoConstraints = false
        hospitalLabel.isUserInteractionEnabled = false
        hospitalLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        hospitalLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    func setupLocationLabel() {
        self.view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.isUserInteractionEnabled = false
        locationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 53).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        self.view.overrideUserInterfaceStyle = .dark

        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    
        hospitalLabel.text = itemCategory
        locationLabel.text = itemLocationLabel
        setupDoneButton()
        setupHospitalLabel()
        setupLocationLabel()
        setupTableView()
    }
    
    //UITableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemsCell {
            let item = Items(itemName: namesArray[indexPath.row], itemPhone: phoneArray[indexPath.row], itemAddress: addressArray[indexPath.row], itemDistance: "\(distanceBtnArray[indexPath.row]) km away")
            cell.configureCell(items: item)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func createHyperLink() {
            let urlString = self.urlArray[indexPath.row]
            if urlString == " " {
                let alert = UIAlertController(title: "Error", message: "No Website found corresponding to this. Please try manually to go to the website.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                return
            }
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        func openMaps() {
            let latitude: CLLocationDegrees = coordinateArray[indexPath.row].latitude
            let longitude: CLLocationDegrees = coordinateArray[indexPath.row].longitude

            let regionDistance: CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = namesArray[indexPath.row]
            mapItem.openInMaps(launchOptions: options)
        }
        
        let alert = UIAlertController(title: "Select any one action...", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Open Website", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            createHyperLink()
        })
        let action2 = UIAlertAction(title: "Get Directions", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            openMaps()
        })
        let action3 = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        present(alert, animated: true, completion: nil)
    }
    
}
