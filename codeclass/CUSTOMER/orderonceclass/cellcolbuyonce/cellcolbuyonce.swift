//
//  cellcolbuyonce.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 06/07/22.
//

import UIKit

class cellcolbuyonce: UICollectionViewCell {

    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var imgv: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblbrand: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblincludetax: UILabel!
    
    @IBOutlet weak var btnfav: UIButton!

    @IBOutlet weak var btnaddtocart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
