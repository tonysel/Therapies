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
    
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var codTer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.customView.layer.cornerRadius = 15
        self.customView.layer.shadowColor = UIColor.darkGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
