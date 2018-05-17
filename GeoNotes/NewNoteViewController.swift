//
//  NewNoteViewController.swift
//  GeoNotes
//
//  Created by Andrius Kelly on 5/17/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//



import UIKit
import CoreData

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
        
        //get context to create note object
        let dbContext =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let note = Note(context:dbContext)
        note.text = text
        //save note
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let _ = navigationController?.popViewController(animated: true)
    }

    

  }
