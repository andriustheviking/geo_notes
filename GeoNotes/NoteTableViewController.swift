//
//  NoteTableViewController.swift
//  GeoNotes
//
//  Created by Andrius Kelly on 5/17/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//

import UIKit
import CoreLocation


//coredata/tableview implimentation from https://www.bobthedeveloper.io/blog/beginner-guide-to-core-data-in-swift


class NoteTableViewController: UITableViewController {
    
    let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notes: [Note] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let note = notes[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("NoteTableViewCell", owner: self, options: nil)?.first as! NoteTableViewCell
        
        if let noteText = note.text {
            cell.noteTextLabel?.text = noteText
        }
        
        let lat = String(note.latitude)
        let long = String(note.longitude)
        cell.noteLocationLabel?.text = "Location: \(lat), \(long)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //fix this
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //allow for deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            dbContext.delete(note)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()

            getData()
            tableView.reloadData()
        }
    }
    
    func getData() {
        do{
            notes = try dbContext.fetch(Note.fetchRequest())
        } catch {
            print("Could not fetch Note data from CoreData")
        }
    }
}
