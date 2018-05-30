//
//  HistoryTherapyViewCell.swift
//  Tesi
//
//  Created by TonySellitto on 29/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class HistoryTherapyViewCell: UITableViewCell {

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

}
