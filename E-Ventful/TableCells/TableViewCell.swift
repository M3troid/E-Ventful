//
//  TableViewCell.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 4/6/22.
//

import UIKit

class TableViewCell1: UITableViewCell {

    @IBOutlet weak var eventNameHomeTxt: UILabel!
    @IBOutlet weak var eventDateFromHomeTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
