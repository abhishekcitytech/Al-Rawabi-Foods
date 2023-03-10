//
//  colcelltopdeals.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 23/06/22.
//

import UIKit

class colcelltopdeals: UICollectionViewCell {

    @IBOutlet weak var viewcell: UIView!
    
    @IBOutlet weak var imgv: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblbrand: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblincludetax: UILabel!
    
    @IBOutlet weak var btnfav: UIButton!
    @IBOutlet weak var btnright: UIButton!
    
    @IBOutlet weak var btnaddonce: UIButton!
    
    @IBOutlet weak var viewPlusMinus: UIView!
    @IBOutlet weak var btnMinusCart: UIButton!
    @IBOutlet weak var btnPlusCart: UIButton!
    @IBOutlet weak var txtMinusPlusCart: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
