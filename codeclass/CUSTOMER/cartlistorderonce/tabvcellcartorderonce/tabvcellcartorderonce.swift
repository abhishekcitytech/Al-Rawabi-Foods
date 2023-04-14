//
//  tabvcellcartorderonce.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/09/22.
//

import UIKit

class tabvcellcartorderonce: UITableViewCell {

    @IBOutlet weak var viewcell: UIView!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var lblproductmessage: UILabel!
    @IBOutlet weak var imgvprod: UIImageView!
    @IBOutlet weak var lblprodprice: UILabel!
    @IBOutlet weak var lblincludetax: UILabel!
    
    @IBOutlet weak var viewplusminus: UIView!
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var txtqty: UITextField!
    
    @IBOutlet weak var btntrash: UIButton!
    
    @IBOutlet weak var lbloutofstock: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
