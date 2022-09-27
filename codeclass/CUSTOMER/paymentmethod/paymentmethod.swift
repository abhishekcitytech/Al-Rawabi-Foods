//
//  paymentmethod.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/07/22.
//

import UIKit

class paymentmethod: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var colpaymentmethods: UICollectionView!
    var reuseIdentifier1 = "colcellmethods"
    
    @IBOutlet weak var viewcards: UIView!
    @IBOutlet weak var colcards: UICollectionView!
    var reuseIdentifier2 = "colcellcards"
    
    @IBOutlet weak var switchsaveornot: UISwitch!
    @IBOutlet weak var lblsave: UILabel!
    @IBAction func pressswitchsaveornot(_ sender: Any) {
    }
    
    @IBOutlet weak var viewbottom: UIView!
    
    @IBOutlet weak var viewnamecard: UIView!
    @IBOutlet weak var txtnamecard: UITextField!
    @IBOutlet weak var viewcardno: UIView!
    @IBOutlet weak var txtcardno: UITextField!
    @IBOutlet weak var viewmonthyear: UIView!
    @IBOutlet weak var txtmonthyear: UITextField!
    @IBOutlet weak var viewcv: UIView!
    @IBOutlet weak var txtcvv: UITextField!
    
    
    @IBOutlet weak var btnpayment: UIButton!
    
    var arrMmethods = NSMutableArray()
    var arrMmethodsimages = NSMutableArray()
    var arrMcards = NSMutableArray()
    
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Payment Method"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .clear
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.viewoverall.frame.size.width, height: self.viewoverall.frame.size.height)
        
        btnpayment.layer.cornerRadius = 18.0
        btnpayment.layer.masksToBounds = true
        
        
        viewcardno.layer.borderWidth = 1.0
        viewcardno.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcardno.layer.cornerRadius = 6.0
        viewcardno.layer.masksToBounds = true
        
        viewnamecard.layer.borderWidth = 1.0
        viewnamecard.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewnamecard.layer.cornerRadius = 6.0
        viewnamecard.layer.masksToBounds = true
        
        viewmonthyear.layer.borderWidth = 1.0
        viewmonthyear.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewmonthyear.layer.cornerRadius = 6.0
        viewmonthyear.layer.masksToBounds = true
        
        viewcv.layer.borderWidth = 1.0
        viewcv.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcv.layer.cornerRadius = 6.0
        viewcv.layer.masksToBounds = true
        
        
        createmethodsview()
        
        createcardsview()
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press payment method
    @IBAction func presspayment(_ sender: Any) {
        let ctrl = ordersuccess(nibName: "ordersuccess", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - create methods box view method
    func createmethodsview()
    {
        arrMmethods = ["Loyalty Points (AED 105.19)","Card Payment","Wallet","Cash on Delivery","Apple Pay"]
        arrMmethodsimages = ["loyalty.png","card","wallet.png","cash.png","apple.png"]
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colpaymentmethods.frame.size.width / 3 - 10, height: 115)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        colpaymentmethods.collectionViewLayout = layout
        colpaymentmethods.register(UINib(nibName: "colcellmethods", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colpaymentmethods.showsHorizontalScrollIndicator = false
        colpaymentmethods.showsVerticalScrollIndicator=false
        colpaymentmethods.backgroundColor = .clear
    }
    
    //MARK: - create cards box view method
    func createcardsview()
    {
        arrMcards = ["1","2","3"] 
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colcards.frame.size.width / 1.02, height: 191)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        colcards.collectionViewLayout = layout
        colcards.register(UINib(nibName: "colcellcards", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
        colcards.showsHorizontalScrollIndicator = false
        colcards.showsVerticalScrollIndicator=false
        colcards.backgroundColor = .clear
    }
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == colpaymentmethods
        {
            return arrMmethods.count
        }

        return arrMcards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == colpaymentmethods
        {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! colcellmethods
            cellA.contentView.backgroundColor = .white
            cellA.contentView.layer.borderWidth = 1.0
            cellA.contentView.layer.cornerRadius = 0.0
            cellA.contentView.layer.borderColor = UIColor.clear.cgColor
            cellA.contentView.layer.masksToBounds = true
            
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 1.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
            
            let strname = arrMmethods.object(at: indexPath.row)as? String ?? ""
            let strimagename = arrMmethodsimages.object(at: indexPath.row)as? String ?? ""
            
            cellA.lblname.text = strname
            cellA.imgvicon.image = UIImage(named: strimagename)
            
            
            // Set up cell
            return cellA
            
        }
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! colcellcards
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }

}
