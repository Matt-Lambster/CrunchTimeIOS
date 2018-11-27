//
//  LibraryTableViewController.swift
//  CrunchTime
//
//  Created by Matthew Lam on 11/14/18.
//  Copyright © 2018 Matt & Sinj. All rights reserved.
//

import UIKit
import FirebaseDatabase
class LibraryTableViewController: UITableViewController {
var libraryList = ["Moffitt Library", "Doe Memorial Library"]
var selectedLibrary = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    func getNumbLibraries() -> Int {
        var count = 0
        let dbRef = Database.database().reference()
        dbRef.child("Libraries").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let libraries = snapshot.value as? [String:AnyObject] {
                    for (key, value) in libraries {
                        count += 1
                    }
                }
            }
        })
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as! LibraryTableViewCell
        let dbRef = Database.database().reference()
        dbRef.child("Libraries").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let libraries = snapshot.value as? [String:AnyObject] {
                    for (key, value) in libraries {
                        if key == self.libraryList[indexPath.row] {
                            cell.capacity.text = "Capacity: " + String(value["Capacity"] as! Int)
                            cell.library.text = key
                            cell.libraryImage.image = UIImage(named: value["Image"] as! String)
                        }
                    }
                }
            }
        })
        // Configure the cell...'
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLibrary = self.libraryList[indexPath.row]
        performSegue(withIdentifier: "tableSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination : LibraryViewController = segue.destination as! LibraryViewController
        destination.chosenLibrary = selectedLibrary
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
