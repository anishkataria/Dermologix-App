//
//  RingwormViewController.swift
//  SkinCancerDetectorApp
//
//  Created by Krish Malik on 4/24/20.
//  Copyright © 2020 RenatoGamboa. All rights reserved.
//

import UIKit

class RingwormViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var RingwormCollectionView: UICollectionView!
    @IBOutlet weak var RingwormImageCollectionView: UICollectionView!
    
    var ringwormSymptomsArray = ["A scaly, ring shaped area which may itch", "Round, flat patch of itchy skin", "Overlapping rings", "Hello",]

    var ringwormImagesArray = [UIImage(named: "ringworm1"), UIImage(named: "ringworm2-1"), UIImage(named: "ringworm3"),]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == RingwormCollectionView){
            return 3
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ringwormcell = RingwormCollectionView.dequeueReusableCell(withReuseIdentifier: "RingwormCollectionViewCell", for: indexPath) as! RingwormCollectionViewCell
        let ringwormcell2 = RingwormImageCollectionView.dequeueReusableCell(withReuseIdentifier: "RingwormImagesCollectionViewCell", for: indexPath) as! RingwormImagesCollectionViewCell
        
        
        ringwormcell.ringwormSymptomsLabel.text = ringwormSymptomsArray[indexPath.row]
        ringwormcell2.RingwormImage.image = ringwormImagesArray[indexPath.row]
        
        ringwormcell.contentView.layer.cornerRadius = 4.0
        ringwormcell.contentView.layer.borderWidth = 1.0
        ringwormcell.contentView.layer.borderColor = UIColor.clear.cgColor
        ringwormcell.contentView.layer.masksToBounds = false
        ringwormcell.layer.shadowColor = UIColor.gray.cgColor
        ringwormcell.layer.shadowOffset = CGSize(width: 0, height: 1)
        ringwormcell.layer.shadowRadius = 4.0
        ringwormcell.layer.shadowOpacity = 0.5
        ringwormcell.layer.masksToBounds = false
        
        ringwormcell2.contentView.layer.cornerRadius = 4.0
        ringwormcell2.contentView.layer.borderWidth = 1.0
        ringwormcell2.contentView.layer.borderColor = UIColor.clear.cgColor
        ringwormcell2.contentView.layer.masksToBounds = false
        ringwormcell2.layer.shadowColor = UIColor.gray.cgColor
        ringwormcell2.layer.shadowOffset = CGSize(width: 0, height: 1)
        ringwormcell2.layer.shadowRadius = 4.0
        ringwormcell2.layer.shadowOpacity = 0.5
        ringwormcell2.layer.masksToBounds = false
        
        if (collectionView==RingwormCollectionView) {
            return ringwormcell
        }
        return ringwormcell2
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        RingwormCollectionView.reloadData()
        RingwormCollectionView.dataSource = self
        RingwormCollectionView.delegate = self
        RingwormImageCollectionView.reloadData()
        RingwormImageCollectionView.dataSource = self
        RingwormImageCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
