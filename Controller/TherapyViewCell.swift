//
//  TherapyViewCell.swift
//  Tesi
//
//  Created by TonySellitto on 18/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class TherapyViewCell: UITableViewCell {

    @IBOutlet weak var clockImage: UIImageView!
    
    @IBOutlet weak var timeLab: UILabel!
    
    @IBOutlet weak var nameMedicine: UILabel!
    
    @IBOutlet weak var qtaMedicine: UILabel!
    
    @IBOutlet weak var ripMedicine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set (newFrame) {
//            var frame = newFrame
//            let newWidth = frame.width * 0.95 // get 80% width here
//            let newHeigth = frame.height * 0.95
//            let space = (frame.width - newWidth) / 2
//            let space2 = (frame.height - newHeigth) / 2
//            frame.size.width = newWidth
//            frame.size.height = newHeigth
//            frame.origin.x += space
//            frame.origin.y += space2
//            super.frame = frame
//            
//        }
//    }
}
