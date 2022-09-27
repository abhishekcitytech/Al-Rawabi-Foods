//
//  celltabvprodustitemsedit.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/07/22.
//

import UIKit

class celltabvprodustitemsedit: UITableViewCell
{
    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblspec: UILabel!
    @IBOutlet weak var lblunitprice: UILabel!
    
    @IBOutlet weak var viewplusminus: UIView!
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var txtplusminus: UITextField!
    
    @IBOutlet weak var btnremove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
