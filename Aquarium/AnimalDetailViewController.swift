//
//  AnimalDetailViewController.swift
//  Aquarium
//
//  Created by TLPAAdmin on 11/26/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit
import QuartzCore
import FirebaseStorageUI


class AnimalDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var animalNameLabel: UILabel!
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var animalInfo: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var ThreeDView: UIButton!
    
    @IBOutlet weak var conservationStatusImage: UIImageView!
    
    var name = ""
    var image = UIImageView()
    var info = ""
    var imageReference = ""
    var animal = "none"
    var status = "none"
    var imageType = "animal"
    var imageHeroID = ""
    var titleLabelHeroID = ""
    var dismissButtonHeroID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient(self.view)
        dismissButton.layer.cornerRadius = 19.5
        ThreeDView.layer.cornerRadius = 5.0
        
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        
        view.addGestureRecognizer(gesture)
        
        gesture.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let reference = FIRStorageReference().child(self.imageReference)
        self.animalImage.sd_setImage(with: reference, placeholderImage: #imageLiteral(resourceName: "fishFilled"))
        
        self.animalNameLabel.text = name
        self.animalInfo.text = info
        animalImage.layer.cornerRadius = 5.0
        animalImage.clipsToBounds = true
        
        self.animalImage.heroID = self.imageHeroID
        self.animalNameLabel.heroID = self.titleLabelHeroID
        self.dismissButton.heroID = self.dismissButtonHeroID
        
        // Added to test 3D model functionality. Will hide button if no 3D Model is available.
        if self.name == "Blacktip Reef Shark" {
            self.ThreeDView.isHidden = false
            
        } else {
            self.ThreeDView.isHidden = true
        }
        
        
        switch self.status {
        case "Least Concern": conservationStatusImage.image = #imageLiteral(resourceName: "LeastConcern")
        case "Near Threatened": conservationStatusImage.image = #imageLiteral(resourceName: "NearThreatened")
        case "Vulnerable": conservationStatusImage.image = #imageLiteral(resourceName: "Vulnerable")
        case "Endangered": conservationStatusImage.image = #imageLiteral(resourceName: "Endangered")
        case "Critically Endangered": conservationStatusImage.image = #imageLiteral(resourceName: "CriticallyEndangered")
        case "Extinct in the Wild": conservationStatusImage.image = #imageLiteral(resourceName: "Extinct_In_Wild")
        default: break
        }
        
    }

    
    @IBAction func toModelButtonTapped(_ sender: Any) {
        
        if self.name == "Blacktip Reef Shark" {
            self.performSegue(withIdentifier: "toModel", sender: self)
        }
    }
    
    
    @IBAction func heatmapButtonTapped(_ sender: Any) {
        
        if self.imageType == "animal" {
            self.animalImage.image = #imageLiteral(resourceName: "FrogHeatMap_Example")
            self.imageType = "heatmap"
        } else {
            let reference = FIRStorageReference().child(self.imageReference)
            self.animalImage.sd_setImage(with: reference, placeholderImage: #imageLiteral(resourceName: "fishFilled"))
            self.imageType = "animal"
        }
    }
    
    
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateInfo(animal: AnimalTest) {
        self.name = animal.animalName ?? ""
        self.info = animal.animalInfo ?? ""
        self.status = animal.conservationStatus ?? ""
        self.imageReference = animal.animalImage ?? ""
    }
    
    
    
    func panGesture(recognizer: UIPanGestureRecognizer) {
        /*
         if recognizer.isUp(view: self.view) == false {
         
         let transition = CATransition()
         transition.duration = 0.5
         transition.type = kCATransitionFade
         //                transition.subtype = kCATransitionFromBottom
         
         self.view.window?.layer.add(transition, forKey: nil)
         self.dismiss(animated: false, completion: nil)
         }
         */
    }
    
}

extension UIPanGestureRecognizer {
    
    func isUp(view: UIView) -> Bool {
        
        let direction: CGPoint = velocity(in: view)
        if direction.y < 0 {
            // Panning up
            return true
        } else {
            // Panning Down
            return false
        }
    }
}
