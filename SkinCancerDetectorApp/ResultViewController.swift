//
//  ViewController.swift
//  Checkmyskin_ML
//
//  Created by Madiha Latafi on 26/05/2018.
//  Copyright © 2018 Madiha Latafi. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ResultViewController: UIViewController {

    @IBOutlet weak var resultmessage: UILabel!
    @IBOutlet weak var molepercent: UILabel!
    @IBOutlet weak var melanomapercent: UILabel!
    @IBOutlet weak var doctorbutton: UIButton!
    @IBOutlet weak var molepercentbar: UIProgressView!
    @IBOutlet weak var melanomapercentbar: UIProgressView!
    @IBOutlet weak var moleLabel: UILabel!
    @IBOutlet weak var melanomaLabel: UILabel!
    
    var analysedPict: CIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.molepercent.text = "........"
        self.melanomapercent.text = "..processing..."
        self.doctorbutton.isHidden = true
        self.molepercent.isHidden = true
        self.melanomapercent.isHidden = true
        self.doctorbutton.isHidden = true
        self.molepercentbar.isHidden = true
        self.melanomapercentbar.isHidden = true
        self.resultmessage.isHidden = true
        self.moleLabel.isHidden = true
        self.melanomaLabel.isHidden = true
        
        self.AnalyseData()
        
        doctorbutton.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ResultViewController
{
    func AnalyseData()
    {
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: CheckMySkin2_597627832().model) else
         {
         fatalError("can't load Places ML model")
         }
        
        
         // Create a Vision request with completion handler
         let request = VNCoreMLRequest(model: model) { [weak self] request, error in
         guard let results = request.results as? [VNClassificationObservation],
         let topResult = results.first else {
         fatalError("unexpected result type from VNCoreMLRequest")
         }
            var mole_confidence = Float(0.9)
            var melanoma_confidence = Float(0.2)
            let max_risk = Float(50.5)
            let min_confidence = Float(85.0)
            
            if(topResult.identifier == "Mole")
            {
                mole_confidence = topResult.confidence * 100
                melanoma_confidence = results[1].confidence * 100
            }
            else
            {
                melanoma_confidence = topResult.confidence * 100
                mole_confidence = results[1].confidence * 100
            }
            
            var mole_percent_score = Float(mole_confidence/100)
            var melanoma_percent_score = Float(melanoma_confidence/100)
            
            //DispatchQueue.main.async { [weak self] in self?.answerLabel.text = ""}
            
            self?.molepercentbar.setProgress(mole_percent_score, animated: true)
            self?.melanomapercentbar.setProgress(melanoma_percent_score, animated: true)
            self?.molepercent.text = String(format:"%.2f",mole_confidence)+"%"
            self?.melanomapercent.text = String(format:"%.2f",melanoma_confidence)+"%"
            if (melanoma_confidence < max_risk && mole_confidence > min_confidence) {
                self?.resultmessage.text = "Good news ! It seems like a normal mole :)"
                self?.resultmessage.textColor = UIColor(red: 0, green: 1, blue: 0,alpha: 0.5)
                self?.doctorbutton.setTitle( "Double-check with a doctor nearby" , for: .normal )
            }
            else if (mole_confidence < max_risk && melanoma_confidence > min_confidence) {
                self?.resultmessage.text = "Seems odd... You should check it with a doctor"
                self?.doctorbutton.setTitle( "Find a doctor nearby" , for: .normal )
            }
            else {
                self?.resultmessage.text = "Inconclusive results... Your photo doesn't provide with a reliable result, try again or check directly with a doctor"
                self?.doctorbutton.setTitle( "Find a doctor nearby" , for: .normal )
            }
            
            self?.doctorbutton.isHidden = false
            self?.molepercent.isHidden = false
            self?.melanomapercent.isHidden = false
            self?.doctorbutton.isHidden = false
            self?.molepercentbar.isHidden = false
            self?.melanomapercentbar.isHidden = false
            self?.resultmessage.isHidden = false
            self?.moleLabel.isHidden = false
            self?.melanomaLabel.isHidden = false
            
         }
        // Run the Core ML classifier on global dispatch queue
        let handler = VNImageRequestHandler(ciImage: analysedPict)
        //DispatchQueue.global(qos: .userInteractive).async { // too slow
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
              }
        //}
    }
}

