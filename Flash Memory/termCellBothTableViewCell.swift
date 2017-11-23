//
//  termCellBothTableViewCell.swift
//  Flash Memory
//
//  Created by Ty Marking on 10/9/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class termCellBothTableViewCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var deff: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setName(setName: String) {
        self.name.text = setName
    }
    public func setDeff(setDeff: String) {
        self.deff.text = setDeff
    }
    public func setNum(num: Int) {
        self.num.text = String(num)
    }

}
