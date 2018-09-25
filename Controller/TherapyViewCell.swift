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
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    
    @IBOutlet weak var nameMedicine: UILabel!
    
    @IBOutlet weak var qtaMedicine: UILabel!
    
    @IBOutlet weak var ripMedicine: UILabel!
    
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var codTer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.customView.layer.cornerRadius = 15
        self.customView.layer.shadowColor = UIColor.darkGray.cgColor
        self.clockImage.alpha = 0.6
        
//        self.clockImage = AnalogClockView(hours: 7, minutes: 13, view: UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 56, height: 56))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
