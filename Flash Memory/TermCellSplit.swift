//
//  TermCellSplit.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class TermCellSplit: UITableViewCell {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var deff: UITextField!
    @IBOutlet weak var num: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func outsideTouch(_ sender: UITextField) {
        name.resignFirstResponder()
        deff.resignFirstResponder()
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
