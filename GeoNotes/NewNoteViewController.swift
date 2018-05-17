//
//  NewNoteViewController.swift
//  GeoNotes
//
//  Created by Andrius Kelly on 5/17/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var noteText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submitNote(_ sender: UIButton) {
        
        guard let text = noteText.text, !text.isEmpty else {
            let alert = UIAlertController(title: nil, message: "Your note must have a title", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        
    }


  }
