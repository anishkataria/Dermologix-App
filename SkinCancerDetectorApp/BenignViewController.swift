//
//  BenignViewController.swift
//  SkinCancerDetectorApp
//
//  Created by Krish Malik on 4/24/20.
//  Copyright © 2020 RenatoGamboa. All rights reserved.
//

import UIKit

class BenignViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var BenignCollectionView: UICollectionView!
    @IBOutlet weak var BenignImageCollectionView: UICollectionView!
    
    
     var symptomsArray = ["One color", "Round in shape", "Unchanged from month to month", "hello"]
    var benignMolesArray = [UIImage(named: "benignMoles1-1"), UIImage(named: "benignMoles2"), UIImage(named: "benignMoles3"),]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView==BenignCollectionView){
            return 3
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = BenignCollectionView.dequeueReusableCell(withReuseIdentifier: "BenignCollectionViewCell", for: indexPath) as! CollectionViewCell
        let cell2 = BenignImageCollectionView.dequeueReusableCell(withReuseIdentifier: "BenignImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        
        
        cell2.BenignImage.image = benignMolesArray[indexPath.row]
        cell.symptomsLabel.text = symptomsArray[indexPath.row]
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        
        cell2.contentView.layer.cornerRadius = 4.0
        cell2.contentView.layer.borderWidth = 1.0
        cell2.contentView.layer.borderColor = UIColor.clear.cgColor
        cell2.contentView.layer.masksToBounds = false
        cell2.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell2.layer.shadowRadius = 4.0
        cell2.layer.shadowOpacity = 0.5
        cell2.layer.masksToBounds = false

        
        if (collectionView==BenignCollectionView) {
            return cell
        }
        return cell2
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        BenignCollectionView.reloadData()
        BenignCollectionView.dataSource = self
        BenignCollectionView.delegate = self
        BenignImageCollectionView.reloadData()
        BenignImageCollectionView.dataSource = self
        BenignImageCollectionView.delegate = self
        

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
