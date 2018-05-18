//
//  NewNoteViewController.swift
//  GeoNotes
//
//  Created by Andrius Kelly on 5/17/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//



import UIKit
import CoreData
import CoreLocation


fileprivate let OSUCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(44.5 ), longitude: CLLocationDegrees(-123.2 ))


class NewNoteViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var noteText: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var stackViewBottomConstant: CGFloat!
    
    
    var locationManager: CLLocationManager!
    var currentLocation = OSUCoordinate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //save stackView Bottom Layout Constraint
        stackViewBottomConstant = bottomConstraint.constant
        
        //location manager implimentation: https://www.hackingwithswift.com/read/22/2/requesting-location-core-location
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        //keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }

    
    //MARK: submit note
    @IBAction func submitNote(_ sender: Any?) {
        
        guard let text = noteText.text, !text.isEmpty else {
            let alert = UIAlertController(title: nil, message: "Your note must have a title", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        //get context to create note object
        let dbContext =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let note = Note(context:dbContext)
        
        note.text = text
        note.latitude = Float(currentLocation.latitude)
        note.longitude = Float(currentLocation.longitude)
        
        //save note
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //pop viewcontroller off stack
        let _ = navigationController?.popViewController(animated: true)
    }
    
    
    //get location when user changes location authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            currentLocation = (manager.location?.coordinate)!
        }
        else {
            currentLocation = OSUCoordinate
        }
    }
    

    //MARK: keyboard functionality
    //keyboard animation from:
    func keyboardWillChangeFrame(notification: NSNotification){

        //raise stackview bottom constraint to keyboard height
        let userInfo = notification.userInfo!
        
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            bottomConstraint.constant = -keyboardFrame.cgRectValue.height
            
            //get keyboard animation constants(http://effortlesscode.com/auto-layout-keyboard-shown-hidden/)
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            let curve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
            let animationCurve = UIViewAnimationOptions(rawValue: UInt(curve))
            
            stackView.setNeedsLayout()
            UIView.animate(withDuration: duration, delay: 0, options: animationCurve, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}

