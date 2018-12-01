//
//  LibraryViewController.swift
//  CrunchTime
//
//  Created by Matthew Lam on 11/14/18.
//  Copyright © 2018 Matt & Sinj. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class LibraryViewController: UIViewController {
    @IBOutlet weak var libraryImage: UIImageView!
    @IBOutlet weak var capacity: UILabel!
    var chosenLibrary: String = ""
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var graph: LineChartView!
    
    @IBOutlet weak var yAxis: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let dbRef = Database.database().reference()
        dbRef.child("Libraries").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let libraries = snapshot.value as? [String:AnyObject] {
                    for (key, value) in libraries {
                        if key == self.chosenLibrary {
                            self.libraryImage.image = UIImage(named: value["Image"] as! String)
                            self.capacity.text = value["name"] as! String
                            var chartEntry = [ChartDataEntry]()
                            let hour1 = value["hour1"] as! Double
                            let hour2 = value["hour2"] as! Double
                            let hour3 = value["hour3"] as! Double
                            
                            let capacities = [hour1, hour2, hour3]
                            
                            self.yAxis.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
                            
                            //        let hour1 = 1
                            //        let hour2 = 2
                            //        let hour3 = 10
                            //        let capacity = [hour1, hour2, hour3]
                            let times = [1, 2, 3]
                            
                            for i in times{
                                let ching = ChartDataEntry(x: Double(i), y: Double(capacities[i-1]))
                                chartEntry.append(ching)
                            }
                            let line1 = LineChartDataSet(values: chartEntry, label: "Number")
                            //line1.fill = Fill.fillWithColor(CGColor.init(red))
                            let data = LineChartData(dataSet: line1)
                            //        data.addDataSet(line1)
                            self.graph.rightAxis.enabled = false
                            self.graph.leftAxis.drawGridLinesEnabled = false
                            self.graph.xAxis.drawGridLinesEnabled = false
                            self.graph.rightAxis.drawGridLinesEnabled = false
                            
                            //        graph.leftAxis.drawZeroLineEnabled = true
                            //        graph.rightAxis.drawZeroLineEnabled = true
                            self.graph.data = data
                        }
                    }
                }
            }
        })
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
