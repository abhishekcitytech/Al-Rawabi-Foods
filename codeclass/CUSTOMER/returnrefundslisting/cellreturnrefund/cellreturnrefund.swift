//
//  cellreturnrefund.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/11/22.
//

import UIKit

class cellreturnrefund: UITableViewCell
{
    
    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var lblorderno: UILabel!
    @IBOutlet weak var lblordernovalue: UILabel!
    
    @IBOutlet weak var lblreturndate: UILabel!
    @IBOutlet weak var lblreturndtevalue: UILabel!
    
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lblqtyvalue: UILabel!
    
    @IBOutlet weak var lblorderamount: UILabel!
    @IBOutlet weak var lblorderamountvalue: UILabel!
    
    @IBOutlet weak var lblrefundamount: UILabel!
    @IBOutlet weak var lblrefundamountvalue: UILabel!
    
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var btndetails: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
