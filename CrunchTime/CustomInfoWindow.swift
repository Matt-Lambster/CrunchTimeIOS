//
//  CustomInfoWindow.swift
//  CrunchTime
//
//  Created by Matthew Lam on 11/14/18.
//  Copyright © 2018 Matt & Sinj. All rights reserved.
//

import UIKit

protocol MapMarkerDelegate: class {
    func seeMore()
}

class CustomInfoWindow: UIView {

    @IBOutlet weak var libPic: UIImageView!
    @IBOutlet weak var libName: UILabel!
    @IBOutlet weak var soundPic: UIImageView!
    @IBOutlet weak var foodPic: UIImageView!
    @IBOutlet weak var openSeats: UILabel!
    @IBOutlet weak var capacity: UILabel!
    
    @IBOutlet weak var button: UIButton!
    weak var delegate: MapMarkerDelegate?
    var spotData: NSDictionary?
    
    @IBAction func seeMore(_ sender: Any) {
        delegate?.seeMore()

    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "InfoWindow", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
