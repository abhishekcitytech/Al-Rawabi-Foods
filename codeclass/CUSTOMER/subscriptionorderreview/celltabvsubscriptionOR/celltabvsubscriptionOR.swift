//
//  celltabvsubscriptionOR.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/07/22.
//

import UIKit

class celltabvsubscriptionOR: UITableViewCell {

    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var viewleft: UIView!
    @IBOutlet weak var lblseparator: UILabel!
    @IBOutlet weak var btnwarning: UIButton!
    @IBOutlet weak var lblwarning: UILabel!
    
    @IBOutlet weak var lblsubscriptiondate: UILabel!
    @IBOutlet weak var lblsubscriptionday: UILabel!
    
    @IBOutlet weak var lbltotalproducts: UILabel!
    @IBOutlet weak var lblsubtotal: UILabel!
    
    @IBOutlet weak var btnAddMore: UIButton!
    @IBOutlet weak var btndetail: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
