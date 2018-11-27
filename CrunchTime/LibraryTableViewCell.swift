//
//  LibraryTableViewCell.swift
//  CrunchTime
//
//  Created by Matthew Lam on 11/14/18.
//  Copyright © 2018 Matt & Sinj. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    @IBOutlet weak var libraryImage: UIImageView!
    @IBOutlet weak var library: UILabel!
    @IBOutlet weak var capacity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
