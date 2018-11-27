//
//  LibraryViewController.swift
//  CrunchTime
//
//  Created by Matthew Lam on 11/14/18.
//  Copyright © 2018 Matt & Sinj. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LibraryViewController: UIViewController {
    @IBOutlet weak var libraryImage: UIImageView!
    @IBOutlet weak var capacity: UILabel!
    var chosenLibrary: String = ""
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dbRef = Database.database().reference()
        dbRef.child("Libraries").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let libraries = snapshot.value as? [String:AnyObject] {
                    for (key, value) in libraries {
                        if key == self.chosenLibrary {
                            self.libraryImage.image = UIImage(named: value["Image"] as! String)
                            self.capacity.text = "Capacity: " + String(value["Capacity"] as! Int)
                            //cell.libraryImage.image = UIImage(named: value["Image"] as! String)
                        }
                    }
                }
            }
        })
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
