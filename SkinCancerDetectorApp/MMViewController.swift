//
//  MMViewController.swift
//  SkinCancerDetectorApp
//
//  Created by Krish Malik on 4/25/20.
//  Copyright © 2020 RenatoGamboa. All rights reserved.
//

import UIKit

class MMViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var MMImageCollectionView: UICollectionView!
    @IBOutlet weak var MMCollectionView: UICollectionView!
    
    var MMSymptomsArray = ["A change in an existing mole", "The development of a new pigmented or unusual-looking growth on your skin", "Melanoma does not always start out as a mole: can be a new pigmented growth on your skin"]


    var MMImagesArray = [UIImage(named: "MM1"), UIImage(named: "MM2"), UIImage(named: "MM3-1"),]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView==MMCollectionView){
            return 3
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let MMcell = MMCollectionView.dequeueReusableCell(withReuseIdentifier: "MMCollectionViewCell", for: indexPath) as! MMCollectionViewCell
        let MMcell2 = MMImageCollectionView.dequeueReusableCell(withReuseIdentifier: "MMImagesCollectionViewCell", for: indexPath) as! MMImagesCollectionViewCell
        
        
        MMcell.MMSymptomsLabel.text = MMSymptomsArray[indexPath.row]
        MMcell2.MMImages.image = MMImagesArray[indexPath.row]
        
        MMcell.contentView.layer.cornerRadius = 4.0
        MMcell.contentView.layer.borderWidth = 1.0
        MMcell.contentView.layer.borderColor = UIColor.clear.cgColor
        MMcell.contentView.layer.masksToBounds = false
        MMcell.layer.shadowColor = UIColor.gray.cgColor
        MMcell.layer.shadowOffset = CGSize(width: 0, height: 1)
        MMcell.layer.shadowRadius = 4.0
        MMcell.layer.shadowOpacity = 0.5
        MMcell.layer.masksToBounds = false
        
        MMcell2.contentView.layer.cornerRadius = 4.0
        MMcell2.contentView.layer.borderWidth = 1.0
        MMcell2.contentView.layer.borderColor = UIColor.clear.cgColor
        MMcell2.contentView.layer.masksToBounds = false
        MMcell2.layer.shadowColor = UIColor.gray.cgColor
        MMcell2.layer.shadowOffset = CGSize(width: 0, height: 1)
        MMcell2.layer.shadowRadius = 4.0
        MMcell2.layer.shadowOpacity = 0.5
        MMcell2.layer.masksToBounds = false
        
        if (collectionView==MMCollectionView) {
            return MMcell
        }
        return MMcell2
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        MMCollectionView.reloadData()
        MMCollectionView.dataSource = self
        MMCollectionView.delegate = self
        MMImageCollectionView.reloadData()
        MMImageCollectionView.dataSource = self
        MMImageCollectionView.delegate = self

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
