//
//  mainViewController.swift
//  HealthWebServices
//
//  Created by Himanshu Joshi on 01/02/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class CitySelectVC: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    var categorySearchLabel = ""
    var categoryLabel = ""
    
    let tableView: UITableView = UITableView()
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var searchSource: [String]?
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        return activity
    }()
    func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Automatically detect your location...", for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18.0)
        return button
    }()
    func setupCitySelectButton() {
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .allEvents)
    }
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Manually search any city"
        return searchBar
    }()
    func setupSearchBar() {
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isUserInteractionEnabled = true
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
    func setupTableViewCitySelectVC() {
        tableView.frame = CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.view.frame.height - 180)
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        tableView.rowHeight = 45.0
        tableView.allowsSelection = true
        self.view.addSubview(tableView)
    }
        
    var hospitalName = [String]()
    var hospitalPhoneNumber = [String]()
    var hospitalAddress = [String]()
    var hospitalURL = [String]()
    var distanceBtw = [String]()
    var hospitalCoordinate = [CLLocationCoordinate2D]()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        self.hideKeyboardWhenTappedAround2()
        
        searchBar.delegate = self
        searchCompleter.delegate = self
        setupTableViewCitySelectVC()
        setupSearchBar()
        setupCitySelectButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideKeyboardWhenTappedAround2()
    }
    
    @objc func buttonTapped() {
        
        hospitalName.removeAll()
        hospitalAddress.removeAll()
        hospitalURL.removeAll()
        hospitalPhoneNumber.removeAll()
        distanceBtw.removeAll()
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setupActivityIndicator()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
        
    @available(iOS 13.0, *)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        setupActivityIndicator()
        
        hospitalName.removeAll()
        hospitalAddress.removeAll()
        hospitalURL.removeAll()
        hospitalPhoneNumber.removeAll()
        distanceBtw.removeAll()
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(searchBar.text!) { (placemarks, error) in
            if let error = error {
                print("Error converting coordinates from search bar text \(error)")
            }
            let center = placemarks?.first?.location?.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
            let region = MKCoordinateRegion(center: center!, span: span)
            
            let request = MKLocalSearch.Request()
            request.region = region
            request.naturalLanguageQuery = self.categorySearchLabel
            
            let search = MKLocalSearch(request: request)
            search.start { (response, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                for mapItem in response!.mapItems {
                    self.hospitalName.append(mapItem.name!)
                    if let phone = mapItem.phoneNumber {
                        self.hospitalPhoneNumber.append(phone)
                    } else {
                        self.hospitalPhoneNumber.append("No number provided")
                    }
                    self.hospitalAddress.append(mapItem.placemark.title!)
                    if let url = mapItem.url?.absoluteString {
                        self.hospitalURL.append(url)
                    } else {
                        self.hospitalURL.append(" ")
                    }
                    let hospitalLocation = mapItem.placemark.location
                    let myLocation = placemarks?.first?.location

                    let distance = (myLocation?.distance(from: hospitalLocation!))! / 1000
                    let dist = String(format: "%.0f", distance)
                    self.distanceBtw.append("\(dist)")
                    
                    self.hospitalCoordinate.append(mapItem.placemark.coordinate)
                }
                self.stopActivityIndicator()
                if #available(iOS 13.0, *) {
                    let itemVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemVC") as? ItemVC
                } else {
                    // Fallback on earlier versions
                }
                let itemVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemVC") as? ItemVC
                itemVC?.itemCategory = self.categoryLabel
                itemVC?.namesArray = self.hospitalName
                itemVC?.addressArray = self.hospitalAddress
                itemVC?.phoneArray = self.hospitalPhoneNumber
                itemVC?.urlArray = self.hospitalURL
                itemVC?.coordinateArray = self.hospitalCoordinate
                itemVC?.distanceBtnArray = self.distanceBtw
                itemVC?.itemLocationLabel = searchBar.text!
                self.present(itemVC!, animated: true, completion: nil)
            }
            
        }
        
    }
    
    //Location Manager Methods
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let center = CLLocationCoordinate2D(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!)
        let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        let region = MKCoordinateRegion(center: center, span: span)
        
        let request = MKLocalSearch.Request()
        request.region = region
        request.naturalLanguageQuery = self.categorySearchLabel
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in

        if let error = error {
            print("Error getting nearby hospitals, \(error.localizedDescription)")
        }
            
        for mapItem in response!.mapItems {
            self.hospitalName.append(mapItem.name!)
            if let phone = mapItem.phoneNumber {
                self.hospitalPhoneNumber.append(phone)
            } else {
                self.hospitalPhoneNumber.append("No number provided")
            }
            self.hospitalAddress.append(mapItem.placemark.title!)
            if let url = mapItem.url?.absoluteString {
                self.hospitalURL.append(url)
            } else {
                self.hospitalURL.append(" ")
            }
            let hospitalLocation = mapItem.placemark.location
            let myLocation = locations.first

            let distance = (myLocation?.distance(from: hospitalLocation!))! / 1000
            let dist = String(format: "%.0f", distance)
            self.distanceBtw.append("\(dist)")
            
            self.hospitalCoordinate.append(mapItem.placemark.coordinate)
        }
        
        self.stopActivityIndicator()
                      
        let itemVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemVC") as? ItemVC
        itemVC?.itemCategory = self.categoryLabel
        itemVC?.addressArray = self.hospitalAddress
        itemVC?.namesArray = self.hospitalName
        itemVC?.phoneArray = self.hospitalPhoneNumber
        itemVC?.urlArray = self.hospitalURL
        itemVC?.distanceBtnArray = self.distanceBtw
        itemVC?.coordinateArray = self.hospitalCoordinate
        itemVC?.itemLocationLabel = "Near me"
        self.present(itemVC!, animated: true, completion: nil)
        
    }
        
        hospitalName.removeAll()
        hospitalAddress.removeAll()
        hospitalURL.removeAll()
        hospitalPhoneNumber.removeAll()
        distanceBtw.removeAll()
        
    }
    
    //Hide Keyboard Function
    func hideKeyboardWhenTappedAround2() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(disissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func disissKeyboard() {
        view.endEditing(true)
    }
    
}

@available(iOS 13.0, *)
extension CitySelectVC: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
    
}

@available(iOS 13.0, *)
extension CitySelectVC: UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let searchResult = searchResults[indexPath.row]
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    cell.textLabel?.text = searchResult.title
    cell.detailTextLabel?.text = searchResult.subtitle

    return cell
}
}

@available(iOS 13.0, *)
extension CitySelectVC: UITableViewDelegate {

    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    setupActivityIndicator()
    
    hospitalName.removeAll()
    hospitalAddress.removeAll()
    hospitalURL.removeAll()
    hospitalPhoneNumber.removeAll()
    distanceBtw.removeAll()
    
    let completion = searchResults[indexPath.row]

    let searchRequest = MKLocalSearch.Request(completion: completion)
    let search = MKLocalSearch(request: searchRequest)
    search.start { (response, error) in
        self.searchBar.text = response?.mapItems[0].name
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(self.searchBar.text!) { (placemarks, error) in
            if let error = error {
                print("Error converting coordinates from search bar text \(error)")
            }
            let center = placemarks?.first?.location?.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
            let region = MKCoordinateRegion(center: center!, span: span)
            
            let request = MKLocalSearch.Request()
            request.region = region
            request.naturalLanguageQuery = self.categorySearchLabel
            
            let search = MKLocalSearch(request: request)
            search.start { (response, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                for mapItem in response!.mapItems {
                    self.hospitalName.append(mapItem.name!)
                    if let phone = mapItem.phoneNumber {
                        self.hospitalPhoneNumber.append(phone)
                    } else {
                        self.hospitalPhoneNumber.append("No number provided")
                    }
                    self.hospitalAddress.append(mapItem.placemark.title!)
                    if let url = mapItem.url?.absoluteString {
                        self.hospitalURL.append(url)
                    } else {
                        self.hospitalURL.append(" ")
                    }
                    let hospitalLocation = mapItem.placemark.location
                    let myLocation = placemarks?.first?.location

                    let distance = (myLocation?.distance(from: hospitalLocation!))! / 1000
                    let dist = String(format: "%.0f", distance)
                    self.distanceBtw.append("\(dist)")
                    
                    self.hospitalCoordinate.append(mapItem.placemark.coordinate)
                }
                self.stopActivityIndicator()
                if #available(iOS 13.0, *) {
                    let itemVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemVC") as? ItemVC
                } else {
                    // Fallback on earlier versions
                }
                let itemVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemVC") as? ItemVC
                itemVC?.itemCategory = self.categoryLabel
                itemVC?.namesArray = self.hospitalName
                itemVC?.addressArray = self.hospitalAddress
                itemVC?.phoneArray = self.hospitalPhoneNumber
                itemVC?.urlArray = self.hospitalURL
                itemVC?.coordinateArray = self.hospitalCoordinate
                itemVC?.distanceBtnArray = self.distanceBtw
                itemVC?.itemLocationLabel = self.searchBar.text!
                self.present(itemVC!, animated: true, completion: nil)
            }
            
        }
        
    }
    
    self.tableView.reloadData()
    
    }
}
