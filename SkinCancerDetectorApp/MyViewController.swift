//
//  MyViewController.swift
//  CheckMySkin
//
//  Created by admin on 25/05/2018.
//  Copyright © 2018 Stephane LEAP. All rights reserved.
//

import UIKit
import CoreML
import Vision

class MyViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var scene: UIImageView!
    @IBOutlet weak var pickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image2 = UIImage(named: "no_image.png")
        else
        {
            fatalError("can't load Photograhier.png")
        }
        scene.image = image2
        pickButton.setTitle("Upload a photo of your mole", for: UIControlState.normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let img = scene.image else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        let ciImage = CIImage(image:img)
        if let destinationController = segue.destination as? ResultViewController{
            destinationController.analysedPict = ciImage
        }
        
    }
    

    
    @IBAction func onButtonTap(_ sender: Any)
    {
        showActionSheet(vc: self)
    }
    
    func showActionSheet(vc: UIViewController)
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.pickFromCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.pickFromPhotoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func pickFromCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            present(myPickerController, animated: true)
        }
    }
    
    func pickFromPhotoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            // image picker
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .savedPhotosAlbum
            present(pickerController, animated: true)
        }
    }
    
}


extension MyViewController
{
    func detectScene(image: CIImage)
    {
        self.performSegue(withIdentifier: "showResultVC", sender: nil)
    }
}


extension MyViewController: UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            fatalError("couldn't load image from Photos")
        }
        
        scene.image = image
        
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        
        detectScene(image: ciImage)
    }
}
