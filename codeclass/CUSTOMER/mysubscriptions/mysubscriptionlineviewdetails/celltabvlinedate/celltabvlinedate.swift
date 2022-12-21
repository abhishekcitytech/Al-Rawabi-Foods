//
//  celltabvlinedate.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 15/11/22.
//

import UIKit

class celltabvlinedate: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblorderdateday: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblshipping: UILabel!
    
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
