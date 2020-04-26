//
//  MapViewController.swift
//  CheckMySkin
//
//  Created by Madiha Latafi on 26/05/2018.
//  Copyright © 2018 Stephane LEAP. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView?
    @IBOutlet weak var tableView: UITableView?
    var collectionOfDermatologists = [MKMapItem]()
    var link = "http://maps.apple.com/?q=dermatologist"
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.delegate = self
        locationManager.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // based on your data, this is the number of rows you have
        return collectionOfDermatologists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DermatologistCell", for: indexPath) as? DermatologistCell else {
            assertionFailure("J'ai pas trouvé de cell qui allait")
            return UITableViewCell()
        }
        let thisDermatologist = collectionOfDermatologists[indexPath.row]
        cell.nameLabel?.text = thisDermatologist.name
        cell.phoneNumberLabel?.text = thisDermatologist.phoneNumber
        cell.addressLabel?.text = thisDermatologist.placemark.postalCode
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = "dermatologist"
        localSearchRequest.region = mapView.region
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { [weak self](response, error) in
            
            if error != nil {
                print(error!)
            }
            self?.collectionOfDermatologists = response?.mapItems ?? []
            self?.tableView?.reloadData()
            self?.mapView?.removeAnnotations(self?.mapView?.annotations ?? [])
            for item in self?.collectionOfDermatologists ?? [] {
                var annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.subtitle = item.phoneNumber
                mapView.addAnnotation(annotation)
            }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return  }
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView?.region = region
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class DermatologistCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    @IBOutlet weak var phoneNumberLabel: UILabel?
    
}
