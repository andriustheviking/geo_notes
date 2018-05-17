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


class NewNoteViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var noteText: UITextField!
    

    //location manager implimentation: https://www.hackingwithswift.com/read/22/2/requesting-location-core-location
    var locationManager: CLLocationManager!
    
    var currentLocation = OSUCoordinate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //maybe need distance filter?

    }

    @IBAction func submitNote(_ sender: UIButton) {
        
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

  }
