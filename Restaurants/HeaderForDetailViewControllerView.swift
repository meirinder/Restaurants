//
//  HeaderForDetailViewControllerView.swift
//  Restaurants
//
//  Created by Savely on 17.12.2018.
//  Copyright © 2018 Kulizhnikov. All rights reserved.
//

import UIKit

class HeaderForDetailViewControllerView: UIView {

    
    
    @IBOutlet var label: UILabel!
    

// imageView + height ConstraintImageView
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        label.preferredMaxLayoutWidth = label.bounds.width
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
