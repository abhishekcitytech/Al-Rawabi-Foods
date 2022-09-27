//
//  celltabvdateslot.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/06/22.
//

import UIKit

class celltabvdateslot: UITableViewCell
{
    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lblseparator: UILabel!
    @IBOutlet weak var lblstartdate: UILabel!
    @IBOutlet weak var lblenddate: UILabel!
    @IBOutlet weak var btnedit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
