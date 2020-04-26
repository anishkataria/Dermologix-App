//
//  MeaslesViewController.swift
//  SkinCancerDetectorApp
//
//  Created by Krish Malik on 4/24/20.
//  Copyright © 2020 RenatoGamboa. All rights reserved.
//

import UIKit

class MeaslesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var MeaslesCollectionView: UICollectionView!

    @IBOutlet weak var MeaslesImageCollectionView: UICollectionView!
    
    var measlesSymptomsArray = ["Fever", "Dry Cough", "Runny Nose", "Sore Throat", "Inflamed eyes", "Tiny white spots with bluish-white centers on a red background", "A skin rash made up of large", "Flat botches that flow into one another"]


    var measlesImagesArray = [UIImage(named: "measles1"), UIImage(named: "measles2-1"), UIImage(named: "measles3-1"),]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == MeaslesCollectionView){
            return 3
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let measlescell = MeaslesCollectionView.dequeueReusableCell(withReuseIdentifier: "MeaslesCollectionViewCell", for: indexPath) as! MeaslesCollectionViewCell
        let measlescell2 = MeaslesImageCollectionView.dequeueReusableCell(withReuseIdentifier: "MealsesImagesCollectionViewCell", for: indexPath) as! MeaslesImagesCollectionViewCell
        
        
        measlescell.measlesSymptomsLabel.text = measlesSymptomsArray[indexPath.row]
        measlescell2.MeaslesImage.image = measlesImagesArray[indexPath.row]
        
        measlescell.contentView.layer.cornerRadius = 4.0
        measlescell.contentView.layer.borderWidth = 1.0
        measlescell.contentView.layer.borderColor = UIColor.clear.cgColor
        measlescell.contentView.layer.masksToBounds = false
        measlescell.layer.shadowColor = UIColor.gray.cgColor
        measlescell.layer.shadowOffset = CGSize(width: 0, height: 1)
        measlescell.layer.shadowRadius = 4.0
        measlescell.layer.shadowOpacity = 0.5
        measlescell.layer.masksToBounds = false
        
        measlescell2.contentView.layer.cornerRadius = 4.0
        measlescell2.contentView.layer.borderWidth = 1.0
        measlescell2.contentView.layer.borderColor = UIColor.clear.cgColor
        measlescell2.contentView.layer.masksToBounds = false
        measlescell2.layer.shadowColor = UIColor.gray.cgColor
        measlescell2.layer.shadowOffset = CGSize(width: 0, height: 1)
        measlescell2.layer.shadowRadius = 4.0
        measlescell2.layer.shadowOpacity = 0.5
        measlescell2.layer.masksToBounds = false
        
        if (collectionView==MeaslesCollectionView) {
            return measlescell
        }
        return measlescell2
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        MeaslesCollectionView.reloadData()
        MeaslesCollectionView.dataSource = self
        MeaslesCollectionView.delegate = self
        MeaslesImageCollectionView.reloadData()
        MeaslesImageCollectionView.dataSource = self
        MeaslesImageCollectionView.delegate = self

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
