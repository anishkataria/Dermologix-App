//
//  SearchCategoryVC.swift
//  HealthApp
//
//  Created by Himanshu Joshi on 16/02/20.
//  Copyright © 2020 Himanshu Joshi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@available(iOS 13.0, *)
class TextViewVC: UIViewController {
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Place Finder"
        label.font = UIFont(name: "HelveticaNeue", size: 25.0)
        return label
    }()
    func setupTopLabel() {
        self.view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.isUserInteractionEnabled = false
        topLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "This application helps you to search for nearby places like salons, fast food shops, shopping malls and other day to day places. If you want to search for places in other city or country then go ahead and search for them. There are two views of this app. Map View and Default View. So check them out and i hope you love this wonderful app."
        label.font = UIFont(name: "HelveticaNeue", size: 13.0)
        label.textAlignment = .center
        label.numberOfLines = 10
        return label
    }()
    func setupSecondLabel() {
        self.view.addSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.isUserInteractionEnabled = false
        secondLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50.0).isActive = true
        secondLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        secondLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
        secondLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0).isActive = true
    }
    
    let barsLbl: UILabel = {
        let label = UILabel()
        label.text = "Bars"
        return label
    }()
    let restaurantLbl: UILabel = {
        let label = UILabel()
        label.text = "Restaurant"
        return label
    }()
    let salonLbl: UILabel = {
        let label = UILabel()
        label.text = "Salon"
        return label
    }()
    let fastFoodLbl: UILabel = {
        let label = UILabel()
        label.text = "Fast Food"
        return label
    }()
    let pharmacyLbl: UILabel = {
        let label = UILabel()
        label.text = "Pharmacy"
        return label
    }()
    let atmLbl: UILabel = {
        let label = UILabel()
        label.text = "Bank ATMs"
        return label
    }()
    let mallLbl: UILabel = {
        let label = UILabel()
        label.text = "Shopping Mall"
        return label
    }()
    let hospitalLbl: UILabel = {
        let label = UILabel()
        label.text = "Hospitals"
        return label
    }()
    let petrolLbl: UILabel = {
        let label = UILabel()
        label.text = "Petrol Pump"
        return label
    }()
    
    let barsBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "bar.png"), for: .normal)
        return button
    }()
    func setupbarsBtn() {
        self.view.addSubview(barsBtn)
        barsBtn.translatesAutoresizingMaskIntoConstraints = false
        barsBtn.isUserInteractionEnabled = true
        barsBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true
        barsBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        barsBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        barsBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        barsBtn.addTarget(self, action: #selector(setBarsLabel), for: .allEvents)
    }
    func setupBarsLabel() {
        self.view.addSubview(barsLbl)
        barsLbl.translatesAutoresizingMaskIntoConstraints = false
        barsLbl.isUserInteractionEnabled = false
        barsLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        barsLbl.centerXAnchor.constraint(equalTo: barsBtn.centerXAnchor, constant: 0).isActive = true
    }
    
    let petrolBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "petrol.png"), for: .normal)
        return button
    }()
    func setupPetrolBtn() {
        self.view.addSubview(petrolBtn)
        petrolBtn.translatesAutoresizingMaskIntoConstraints = false
        petrolBtn.isUserInteractionEnabled = true
        petrolBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true
        petrolBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        petrolBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        petrolBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        petrolBtn.addTarget(self, action: #selector(setPetrolLabel), for: .allEvents)
    }
    func setupPetrolLabel() {
        self.view.addSubview(petrolLbl)
        petrolLbl.translatesAutoresizingMaskIntoConstraints = false
        petrolLbl.isUserInteractionEnabled = false
        petrolLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        petrolLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    let restaurantBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "restaurant.png"), for: .normal)
        return button
    }()
    func setupRestaurantBtn() {
        self.view.addSubview(restaurantBtn)
        restaurantBtn.translatesAutoresizingMaskIntoConstraints = false
        restaurantBtn.isUserInteractionEnabled = true
        restaurantBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true
        restaurantBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        restaurantBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        restaurantBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        restaurantBtn.addTarget(self, action: #selector(setRestaurantLabel), for: .allEvents)
    }
    func setupRestaurantLabel() {
        self.view.addSubview(restaurantLbl)
        restaurantLbl.translatesAutoresizingMaskIntoConstraints = false
        restaurantLbl.isUserInteractionEnabled = false
        restaurantLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        restaurantLbl.centerXAnchor.constraint(equalTo: restaurantBtn.centerXAnchor, constant: 0).isActive = true
    }
    
    let atmBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "bank.png"), for: .normal)
        return button
    }()
    func setupAtmBtn() {
        self.view.addSubview(atmBtn)
        atmBtn.translatesAutoresizingMaskIntoConstraints = false
        atmBtn.isUserInteractionEnabled = true
        atmBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -190).isActive = true
        atmBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        atmBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        atmBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        atmBtn.addTarget(self, action: #selector(setBankATMLabel), for: .allEvents)
    }
    func setupAtmLabel() {
        self.view.addSubview(atmLbl)
        atmLbl.translatesAutoresizingMaskIntoConstraints = false
        atmLbl.isUserInteractionEnabled = false
        atmLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -170).isActive = true
        atmLbl.centerXAnchor.constraint(equalTo: atmBtn.centerXAnchor, constant: 0).isActive = true
    }
    
    let mallBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "mall.png"), for: .normal)
        return button
    }()
    func setupMallBtn() {
        self.view.addSubview(mallBtn)
        mallBtn.translatesAutoresizingMaskIntoConstraints = false
        mallBtn.isUserInteractionEnabled = true
        mallBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -190).isActive = true
        mallBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        mallBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        mallBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        mallBtn.addTarget(self, action: #selector(setShoppingMallLabel), for: .allEvents)
    }
    func setupMallLabel() {
        self.view.addSubview(mallLbl)
        mallLbl.translatesAutoresizingMaskIntoConstraints = false
        mallLbl.isUserInteractionEnabled = false
        mallLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -170).isActive = true
        mallLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    let hospitalBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "hospital-1.png"), for: .normal)
        return button
    }()
    func setupHospitalBtn() {
        self.view.addSubview(hospitalBtn)
        hospitalBtn.translatesAutoresizingMaskIntoConstraints = false
        hospitalBtn.isUserInteractionEnabled = true
        hospitalBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -190).isActive = true
        hospitalBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        hospitalBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        hospitalBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        hospitalBtn.addTarget(self, action: #selector(setHospitalsLabel), for: .allEvents)
    }
    func setupHospitalLabel() {
        self.view.addSubview(hospitalLbl)
        hospitalLbl.translatesAutoresizingMaskIntoConstraints = false
        hospitalLbl.isUserInteractionEnabled = false
        hospitalLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -170).isActive = true
        hospitalLbl.centerXAnchor.constraint(equalTo: hospitalBtn.centerXAnchor, constant: 0).isActive = true
    }
    
    let salonBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "salon.png"), for: .normal)
        return button
    }()
    func setupSalonBtn() {
        self.view.addSubview(salonBtn)
        salonBtn.translatesAutoresizingMaskIntoConstraints = false
        salonBtn.isUserInteractionEnabled = true
        salonBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -310).isActive = true
        salonBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        salonBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        salonBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        salonBtn.addTarget(self, action: #selector(setSalonLabel), for: .allEvents)
    }
    func setupSalonLabel() {
        self.view.addSubview(salonLbl)
        salonLbl.translatesAutoresizingMaskIntoConstraints = false
        salonLbl.isUserInteractionEnabled = false
        salonLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -290).isActive = true
        salonLbl.centerXAnchor.constraint(equalTo: salonBtn.centerXAnchor, constant: 0).isActive = true
    }
    
    let fastFoodBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "fast food.png"), for: .normal)
        return button
    }()
    func setupFastFoodBtn() {
        self.view.addSubview(fastFoodBtn)
        fastFoodBtn.translatesAutoresizingMaskIntoConstraints = false
        fastFoodBtn.isUserInteractionEnabled = true
        fastFoodBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -310).isActive = true
        fastFoodBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        fastFoodBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        fastFoodBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        fastFoodBtn.addTarget(self, action: #selector(setFastFoodLabel), for: .allEvents)
    }
    func setupFastFoodLabel() {
        self.view.addSubview(fastFoodLbl)
        fastFoodLbl.translatesAutoresizingMaskIntoConstraints = false
        fastFoodLbl.isUserInteractionEnabled = false
        fastFoodLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -290).isActive = true
        fastFoodLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    let pharmacyBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "pharmacy.png"), for: .normal)
        return button
    }()
    func setupPharmacyBtn() {
        self.view.addSubview(pharmacyBtn)
        pharmacyBtn.translatesAutoresizingMaskIntoConstraints = false
        pharmacyBtn.isUserInteractionEnabled = true
        pharmacyBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -310).isActive = true
        pharmacyBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        pharmacyBtn.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        pharmacyBtn.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        pharmacyBtn.addTarget(self, action: #selector(setPharmacyLabel), for: .allEvents)
    }
    func setupPharmacyLabel() {
        self.view.addSubview(pharmacyLbl)
        pharmacyLbl.translatesAutoresizingMaskIntoConstraints = false
        pharmacyLbl.isUserInteractionEnabled = false
        pharmacyLbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -290).isActive = true
        pharmacyLbl.centerXAnchor.constraint(equalTo: pharmacyBtn.centerXAnchor, constant: 0).isActive = true
    }
    
    @objc func setPetrolLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Petrol Pump Gas Station"
        citySelectVC?.categoryLabel = "Petrol Pumps"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @objc func setPharmacyLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Medical Chemist"
        citySelectVC?.categoryLabel = "Pharmacy"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @objc func setRestaurantLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Restaurant"
        citySelectVC?.categoryLabel = "Restaurants"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @objc func setBankATMLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Bank ATM Atm"
        citySelectVC?.categoryLabel = "Banks and ATMs"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @objc func setShoppingMallLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Shopping Mall"
        citySelectVC?.categoryLabel = "Shopping Malls"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @objc func setBarsLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Bars Bar Lounge"
        citySelectVC?.categoryLabel = "Bars and Lounge"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @objc func setHospitalsLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Hospital"
        citySelectVC?.categoryLabel = "Hospitals"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @objc func setFastFoodLabel() {
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Fast Food"
        citySelectVC?.categoryLabel = "Fast food shops"
        self.present(citySelectVC!, animated: true, completion: nil)
    }
    @available(iOS 13.0, *)
    @objc func setSalonLabel() {
        if #available(iOS 13.0, *) {
            let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        } else {
            // Fallback on earlier versions
        }
        let citySelectVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CitySelectVC") as? CitySelectVC
        citySelectVC?.categorySearchLabel = "Salon Parlour"
        citySelectVC?.categoryLabel = "Salons and Parlours"
        self.present(citySelectVC!, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupbarsBtn()
        setupPetrolBtn()
        setupRestaurantBtn()
        setupAtmBtn()
        setupMallBtn()
        setupHospitalBtn()
        setupFastFoodBtn()
        setupSalonBtn()
        setupPharmacyBtn()
        setupBarsLabel()
        setupPetrolLabel()
        setupRestaurantLabel()
        setupAtmLabel()
        setupMallLabel()
        setupHospitalLabel()
        setupSalonLabel()
        setupFastFoodLabel()
        setupPharmacyLabel()
        setupTopLabel()
        setupSecondLabel()
    
    }

}
