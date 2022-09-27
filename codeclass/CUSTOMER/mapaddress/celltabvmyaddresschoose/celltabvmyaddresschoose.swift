//
//  celltabvmyaddresschoose.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 12/09/22.
//

import UIKit

class celltabvmyaddresschoose: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lbldefault: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblmobile: UILabel!
    @IBOutlet weak var txtvaddress: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
