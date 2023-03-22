//
//  renewpaymentmethodlist.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/12/22.
//

import UIKit
import NISdk
import Alamofire
import SwiftyJSON
import CoreData

class renewpaymentmethodlist: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,CardPaymentDelegate
{
    var myAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var colpaymentmethods: UICollectionView!
    var reuseIdentifier1 = "colcellmethods"
    var msg = ""
    
    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var lblCardPaymentOrderAmount: UILabel!
    @IBOutlet weak var txtCardPaymentOrderAmount: UITextField!
    @IBOutlet weak var btnpayment: UIButton!
    
    @IBOutlet weak var viewbottom1: UIView!
    @IBOutlet weak var txtwalletbalance: UITextField!
    @IBOutlet weak var txtpaymentamount: UITextField!
    @IBOutlet weak var txtremainingbalance: UITextField!
    @IBOutlet weak var btnpaymentwallet: UIButton!
    
    @IBOutlet weak var lblwalletbalance: UILabel!
    @IBOutlet weak var lblpaymentamount: UILabel!
    @IBOutlet weak var lblremainingbalance: UILabel!
    
  
    @IBOutlet weak var viewrewardpoints: UIView!
    @IBOutlet weak var lblrewardpoints: UILabel!
    @IBOutlet weak var txtrewardpoints: UITextField!
    @IBOutlet weak var lblmaximumrewardpointsused: UILabel!
    @IBOutlet weak var btnapplyrewardpoints: UIButton!
    @IBOutlet weak var btnremoverewardpoints: UIButton!
    
    var arrMpaymentmethodlist = NSMutableArray()
    var strselectedpaymentmethodID = ""
    
    
    var strSubscriptionID = ""
    var strpaymentype = ""
    var strplanid = ""
    var strdiscountamount = ""
    var strcouponcode = ""
    var strautorenew = ""
    var strselectedslotid = ""
    var strSelectedaddressID = ""
    var strsubtotalamount = ""
    var strshippingchargesamount = ""
    var strgrandtotalamount = ""
    var dicDetails = NSDictionary()
    
    
    
    var strSubscriptionincreamentalId = ""
    
    var authCode = ""
    var CardReference = ""
    var CardOutletId = ""
    var refNumber:String?
    
    var strcurrency = ""
    var strwalletremainingbalance = ""
    
    var strloayltypointsavailable = ""
    
    var strAppliedRewardAmount = ""
    var strAppliedRewardAmountPoint = ""
    
    
    
    
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
        
        self.getsubscriptionpaymentmethodlist()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = myAppDelegate.changeLanguage(key: "msg_language185")
        
        strcurrency = myAppDelegate.changeLanguage(key: "msg_language481")
        
        setupRTLLTR()
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .clear
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.viewoverall.frame.size.width, height: self.viewoverall.frame.size.height)
        
        btnpayment.layer.cornerRadius = 18.0
        btnpayment.layer.masksToBounds = true
        
        btnpaymentwallet.layer.cornerRadius = 18.0
        btnpaymentwallet.layer.masksToBounds = true
        
        
        viewbottom.layer.borderWidth = 1.0
        viewbottom.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewbottom.layer.cornerRadius = 6.0
        viewbottom.layer.masksToBounds = true
        
        viewbottom1.layer.borderWidth = 1.0
        viewbottom1.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewbottom1.layer.cornerRadius = 6.0
        viewbottom1.layer.masksToBounds = true
        
        viewrewardpoints.layer.borderWidth = 1.0
        viewrewardpoints.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        viewrewardpoints.layer.cornerRadius = 6.0
        viewrewardpoints.layer.masksToBounds = true
        
        btnapplyrewardpoints.layer.cornerRadius = 0.0
        btnapplyrewardpoints.layer.masksToBounds = true
       
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDoneRewardPoints))
        toolbarDone.items = [barBtnDone]
        txtrewardpoints.inputAccessoryView = toolbarDone
        
        if strselectedpaymentmethodID.count == 0{
            self.viewbottom.isHidden = true
            self.viewbottom1.isHidden = true
        }
        
        if txtrewardpoints.isUserInteractionEnabled == false{
            btnremoverewardpoints.isHidden = false
        }else{
            btnremoverewardpoints.isHidden = true
        }
        
        createmethodsview()
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        txtrewardpoints.placeholder = myAppDelegate.changeLanguage(key: "msg_language353")
         
        btnapplyrewardpoints.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language234")), for: .normal)
        btnremoverewardpoints.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language49")), for: .normal)

        lblCardPaymentOrderAmount.text = myAppDelegate.changeLanguage(key: "msg_language312")
        txtCardPaymentOrderAmount.placeholder = myAppDelegate.changeLanguage(key: "msg_language313")
        btnpayment.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        
        txtwalletbalance.placeholder = myAppDelegate.changeLanguage(key: "msg_language314")
        txtpaymentamount.placeholder = myAppDelegate.changeLanguage(key: "msg_language312")
        txtremainingbalance.placeholder = myAppDelegate.changeLanguage(key: "msg_language315")
        btnpaymentwallet.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        
        lblwalletbalance.text = myAppDelegate.changeLanguage(key: "msg_language314")
        lblpaymentamount.text = myAppDelegate.changeLanguage(key: "msg_language312")
        lblremainingbalance.text = myAppDelegate.changeLanguage(key: "msg_language315")

         let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
         if (strLangCode == "en")
         {
        
         }
         else
         {

         }
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language344"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            self.navigationController?.popViewController(animated: true)
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - press Reward Points Apply Method
    @objc func pressDoneRewardPoints(sender:UIButton)
    {
        self.txtrewardpoints.resignFirstResponder()
    }
    @IBAction func pressapplyrewardpoints(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let flt1  = (self.strloayltypointsavailable as NSString).floatValue
        let flt2  = (self.txtrewardpoints.text! as NSString).floatValue
        
        if self.txtrewardpoints.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language345"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if flt2 > flt1
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language379"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            let a = Float(self.txtrewardpoints.text!)
            let b = Float(10)
            let c = Float(a! / b)
            
            let numberString = String(c)
            let numberComponent = numberString.components(separatedBy :".")
            let integerNumber = Int(numberComponent [0])
            let fractionalNumber = Int(numberComponent [1])
            
            if fractionalNumber! != 0
            {
                print("DISALLOW")
                
                let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language364"), preferredStyle: UIAlertController.Style.alert)
                self.present(uiAlert, animated: true, completion: nil)
                uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                    print("Click of default button")
                }))
            }
            else
            {
                print("ALLOW")
                
                if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
                {
                    let fltamount  = (self.strgrandtotalamount as NSString).floatValue
                    self.postApplyRewardPointsSubscriptionAPI(strorderamount: String(format: "%0.2f", fltamount))
                }
                else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                {
                    let fltamount  = (self.strgrandtotalamount as NSString).floatValue
                    self.postApplyRewardPointsSubscriptionAPI(strorderamount: String(format: "%0.2f", fltamount))
                }
            }
        }
    }
    @IBAction func pressremoverewardpoints(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language354"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            
            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
            {
                var fltupdated = 0.00
                let fltamount1  = (self.strgrandtotalamount as NSString).floatValue
                let fltamount11  = (self.strAppliedRewardAmount as NSString).floatValue
                
                fltupdated = Double(fltamount1 + fltamount11)
                print("fltupdated",fltupdated)
                self.strgrandtotalamount = String(format: "%0.2f",fltupdated)
                
                self.txtCardPaymentOrderAmount.text = String(format: "%@ %@",self.strcurrency,self.strgrandtotalamount)

            }
            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
            {
                var fltupdated = 0.00
                let fltamount1  = (self.strgrandtotalamount as NSString).floatValue
                let fltamount11  = (self.strAppliedRewardAmount as NSString).floatValue
                
                fltupdated = Double(fltamount1 + fltamount11)
                print("fltupdated",fltupdated)
                self.strgrandtotalamount = String(format: "%0.2f",fltupdated)
                
                let fltamount3  = (strwalletremainingbalance as NSString).doubleValue
                print("fltamount3",fltamount3)
                
                let fltamount4  = (self.strgrandtotalamount as NSString).doubleValue
                print("fltamount4",fltamount4)
                
                if fltamount3 == 0.00
                {
                    //Wallet balance zero, Recharge Your Wallet First
                    
                    self.txtwalletbalance.text = String(format: "%@ %0.2f",self.strcurrency,fltamount3)
                    self.txtpaymentamount.text = String(format: "%@ %0.2f",self.strcurrency,fltamount4)
                    
                    self.btnpaymentwallet.isUserInteractionEnabled = false
                    self.btnpaymentwallet.setTitleColor(.black, for: .normal)
                    self.btnpaymentwallet.backgroundColor = UIColor(named: "graybordercolor")!
                }
                else if fltamount3 < fltamount4
                {
                    //Wallet balance low from Grand total
                    
                    self.txtwalletbalance.text = String(format: "%@ %0.2f",self.strcurrency,fltamount3)
                    self.txtpaymentamount.text = String(format: "%@ %0.2f",self.strcurrency,fltamount4)
                    
                    self.btnpaymentwallet.isUserInteractionEnabled = false
                    self.btnpaymentwallet.setTitleColor(.black, for: .normal)
                    self.btnpaymentwallet.backgroundColor = UIColor(named: "graybordercolor")!
                }
                else
                {
                    //Wallet Balance is sufficient to place order
                    
                    var fltremainingbalance = 0.00
                    fltremainingbalance = Double(fltamount3) - fltamount4
                    
                    self.txtwalletbalance.text = String(format: "%@ %0.2f",self.strcurrency,fltamount3)
                    
                    self.txtpaymentamount.text = String(format: "%@ %0.2f",self.strcurrency,fltamount4)
                    
                    self.txtremainingbalance.text = String(format: "%@ %0.2f",self.strcurrency,fltremainingbalance)
                    
                    self.btnpaymentwallet.isUserInteractionEnabled = true
                    self.btnpaymentwallet.setTitleColor(.white, for: .normal)
                    self.btnpaymentwallet.backgroundColor = UIColor(named: "greencolor")!
                }
                print("self.txtCardPaymentOrderAmount",self.txtpaymentamount.text!)
                
            }
            
            //RESET UI DESIGN COUPON VIEW
            self.strAppliedRewardAmount = ""
            self.strAppliedRewardAmountPoint = ""
            
            self.txtrewardpoints.backgroundColor = .white
            self.txtrewardpoints.isUserInteractionEnabled = true
            self.txtrewardpoints.text = ""
            self.btnapplyrewardpoints.isUserInteractionEnabled = true
            self.btnapplyrewardpoints.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language234")), for: .normal)
            self.btnremoverewardpoints.isHidden = true
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - create methods box view method
    func createmethodsview()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: colpaymentmethods.frame.size.width / 3 - 10, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        colpaymentmethods.collectionViewLayout = layout
        colpaymentmethods.register(UINib(nibName: "colcellmethods", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier1)
        colpaymentmethods.showsHorizontalScrollIndicator = false
        colpaymentmethods.showsVerticalScrollIndicator=false
        colpaymentmethods.backgroundColor = .clear
    }
    
    //MARK: - press payment method
    @IBAction func presspayment(_ sender: Any)
    {
       //Call Subscription Card Payment Create
        
        self.postCreateRenewDataAPIMethod()
        
    }
    
    //MARK: - press payment Wallet method
    @IBAction func presspaymentwallet(_ sender: Any)
    {
        //Call Subscription Wallet Payment Create
        
        self.postCreateRenewDataAPIMethod()
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
        return arrMpaymentmethodlist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
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
        
        let dictemp = arrMpaymentmethodlist.object(at: indexPath.row)as? NSDictionary
        let strcode = String(format: "%@", dictemp?.value(forKey: "code")as! CVarArg)
        let strtitle = String(format: "%@", dictemp?.value(forKey: "title")as? String ?? "")
        
        cellA.lblname.text = strtitle
        
        if strcode.containsIgnoreCase("ngeniusonline")
        {
            cellA.imgvicon.image = UIImage(named: "card")
        }
        else if strcode.containsIgnoreCase("walletsystem") || strcode.containsIgnoreCase("walletpayment")
        {
            cellA.imgvicon.image = UIImage(named: "wallet")
        }
        
        if strselectedpaymentmethodID == strcode
        {
            cellA.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 4.0
            cellA.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        else{
            cellA.viewcell.backgroundColor = .white
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 1.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var strpreviouslyselectedcode = self.strselectedpaymentmethodID
        
        let dictemp = arrMpaymentmethodlist.object(at: indexPath.row)as? NSDictionary
        let strcode = String(format: "%@", dictemp?.value(forKey: "code")as! CVarArg)
        let strtitle = String(format: "%@", dictemp?.value(forKey: "title")as? String ?? "")
        
        self.strselectedpaymentmethodID = strcode
        self.colpaymentmethods.reloadData()
        
        
        print("strpreviouslyselectedcode",strpreviouslyselectedcode)
        print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
        
        if strpreviouslyselectedcode.count > 0
        {
            //ALREADY PRE SELECTED PAYMENT METHOD
            
            if strpreviouslyselectedcode != self.strselectedpaymentmethodID
            {
                let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language363"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")
                    
                    self.colpaymentmethods.reloadData()
                    strpreviouslyselectedcode = ""
                    
                    if strcode.containsIgnoreCase("ngeniusonline")
                    {
                        self.viewbottom.isHidden = false
                        self.viewbottom1.isHidden = true
                        
                        if self.strcurrency.count == 0{
                            self.strcurrency = myAppDelegate.changeLanguage(key: "msg_language481")
                        }
                        var fltTotal = 0.00
                        //let fltamount1  = (strsubtotalamount as NSString).floatValue
                        //let fltamount2  = (strshippingchargesamount as NSString).floatValue
                        //fltTotal = Double(fltamount1 + fltamount2)
                        
                        print(strgrandtotalamount)
                        fltTotal  = Double((strgrandtotalamount as NSString).floatValue)
                        
                        self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
                    }
                    else if strcode.containsIgnoreCase("walletsystem") || strcode.containsIgnoreCase("walletpayment")
                    {
                        self.viewbottom.isHidden = true
                        self.viewbottom1.isHidden = false
                        
                        self.getwalletremainingbalancelist()
                    }
                }))
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
        }
        else
        {
            //ALREADY NO PRE SELECTED PAYMENT METHOD
            
            if strcode.containsIgnoreCase("ngeniusonline")
            {
                self.viewbottom.isHidden = false
                self.viewbottom1.isHidden = true
                
                if self.strcurrency.count == 0{
                    self.strcurrency = myAppDelegate.changeLanguage(key: "msg_language481")
                }
                var fltTotal = 0.00
                //let fltamount1  = (strsubtotalamount as NSString).floatValue
                //let fltamount2  = (strshippingchargesamount as NSString).floatValue
                //fltTotal = Double(fltamount1 + fltamount2)
                
                print(strgrandtotalamount)
                fltTotal  = Double((strgrandtotalamount as NSString).floatValue)
                
                self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
            }
            else if strcode.containsIgnoreCase("walletsystem") || strcode.containsIgnoreCase("walletpayment")
            {
                self.viewbottom.isHidden = true
                self.viewbottom1.isHidden = false
                
                self.getwalletremainingbalancelist()
            }
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
    
    //MARK: - populate wallet view calculation
    func populatewalletviewcalculation()
    {
        
        print(strsubtotalamount)
        print(strshippingchargesamount)
        print(strgrandtotalamount)
        
        let fltTotal  = (strgrandtotalamount as NSString).floatValue
        
        let fltamount3  = (strwalletremainingbalance as NSString).floatValue
        
        var fltremainingbalance = 0.00
        fltremainingbalance = Double(fltamount3) - Double(fltTotal)
        
        self.txtwalletbalance.text = String(format: "%@ %0.2f",self.strcurrency,fltamount3)
        self.txtpaymentamount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
        self.txtremainingbalance.text = String(format: "%@ %0.2f",self.strcurrency,fltremainingbalance)
    }
    
    
    //MARK: - get Subscription Payment Method list API method
    func getsubscriptionpaymentmethodlist()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["ordertype": "subscription"] as [String : Any]
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        let strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod40,strLangCode)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.getLoyaltyPointAPIMethod()
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    //print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            if self.arrMpaymentmethodlist.count > 0{
                                self.arrMpaymentmethodlist.removeAllObjects()
                            }
                            
                            let arrmaddress = dictemp.value(forKey: "payment_methods") as? NSArray ?? []
                            let aarrm1 = NSMutableArray(array: arrmaddress)
                            print("aarrm1",aarrm1.count)
                            
                            self.arrMpaymentmethodlist = NSMutableArray(array: aarrm1)
                            print("arrMpaymentmethodlist --->",self.arrMpaymentmethodlist)
                            
                            if self.arrMpaymentmethodlist.count == 0{
                                self.msg = "No orders found!"
                            }
                            
                            //BY DEFAULT CREDIT CARD PAYMENT SET ON PAGE LOAD
                            for jj in 0 ..< self.arrMpaymentmethodlist.count
                            {
                                let dictemp = self.arrMpaymentmethodlist.object(at: jj)as? NSDictionary
                                let strcode = String(format: "%@", dictemp?.value(forKey: "code")as! CVarArg)
                                let strtitle = String(format: "%@", dictemp?.value(forKey: "title")as? String ?? "")
                                if strcode.containsIgnoreCase("ngeniusonline")
                                {
                                    self.strselectedpaymentmethodID = strcode
                                }
                            }
                            
                            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
                            {
                                self.viewbottom.isHidden = false
                                self.viewbottom1.isHidden = true
                                
                                if self.strcurrency.count == 0{
                                    self.strcurrency = self.myAppDelegate.changeLanguage(key: "msg_language481")
                                }
                                var fltTotal = 0.00
                                
                                //let fltamount1  = (self.strsubtotalamount as NSString).floatValue
                                //let fltamount2  = (self.strshippingchargesamount as NSString).floatValue
                                //fltTotal = Double(fltamount1 + fltamount2)
                                
                                print(self.strgrandtotalamount)
                                fltTotal  = Double((self.strgrandtotalamount as NSString).floatValue)
                                self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
                            }
                            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                            {
                                self.viewbottom.isHidden = true
                                self.viewbottom1.isHidden = false
                                
                                self.getwalletremainingbalancelist()
                            }
                            
                            self.colpaymentmethods.reloadData()
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getLoyaltyPointAPIMethod()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.getLoyaltyPointAPIMethod()
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    //MARK: - get wallet remaning balance API method
    func getwalletremainingbalancelist()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod38)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    //print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
                        {
                            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            let strwallet_remaining_amount = dictemp.value(forKey: "wallet_remaining_amount")as? String ?? ""
                            let strcurrency = dictemp.value(forKey: "currency")as? String ?? ""
                            self.strcurrency = myAppDelegate.changeLanguage(key: "msg_language481")
                            self.strwalletremainingbalance = strwallet_remaining_amount
                            
                            self.populatewalletviewcalculation()
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    
    
    //MARK: - get Loyalty Point API method
    func getLoyaltyPointAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod90)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let strpoints = dictemp.value(forKey: "points")as? String ?? ""
                            
                            let strspend_max_points = String(format: "%@", dictemp.value(forKey: "max_spend")as! CVarArg)
                            let strspend_min_points = String(format: "%@", dictemp.value(forKey: "min_spend")as! CVarArg)
                            
                            self.strloayltypointsavailable =  strpoints
                            print("self.strloayltypointsavailable",self.strloayltypointsavailable)
                            
                            self.lblrewardpoints.text = String(format: "%@ %@ %@", myAppDelegate.changeLanguage(key: "msg_language359"),self.strloayltypointsavailable,myAppDelegate.changeLanguage(key: "msg_language360"))
                            
                            if strpoints == "0" || strpoints == "0.0"
                            {
                                //YOU CAN NOT APPLY REWARD POINT
                                self.lblmaximumrewardpointsused.textColor = UIColor(named: "darkmostredcolor")!
                                self.lblmaximumrewardpointsused.text = myAppDelegate.changeLanguage(key: "msg_language355")
                                self.btnapplyrewardpoints.isUserInteractionEnabled = false
                            }
                            else{
                                self.lblmaximumrewardpointsused.text = String(format: "%@ %@ %@ %@ %@", myAppDelegate.changeLanguage(key: "msg_language356"),strspend_min_points,myAppDelegate.changeLanguage(key: "msg_language357"),strspend_max_points,myAppDelegate.changeLanguage(key: "msg_language358"))
                                self.lblmaximumrewardpointsused.textColor = UIColor(named: "darkgreencolor")!
                                self.btnapplyrewardpoints.isUserInteractionEnabled = true
                            }
                            
                            
                            
                            
                            /*if strpoints == "0" || strpoints == "0.0"
                            {
                                //YOU CANT APPLY REWARD POINT
                                self.txtrewardpoints.isUserInteractionEnabled = false
                                self.btnapplyrewardpoints.isUserInteractionEnabled = false
                                self.btnremoverewardpoints.isHidden = true
                                
                            }
                            else
                            {
                                //YOU CAN APPLY
                                self.txtrewardpoints.isUserInteractionEnabled = true
                                self.btnapplyrewardpoints.isUserInteractionEnabled = true
                                self.btnremoverewardpoints.isHidden = true
                            }*/
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - Apply Reward point for Subscription Payment API method
    func postApplyRewardPointsSubscriptionAPI(strorderamount:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["grandTotal":strorderamount,"appliedRewardPoint": self.txtrewardpoints.text!] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod107)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.txtrewardpoints.isUserInteractionEnabled = true
                    self.btnapplyrewardpoints.isUserInteractionEnabled = true
                    self.view.activityStopAnimating()
                    
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            //let str_avail vableRewardPoint = dictemp.value(forKey: "availableRewardPoint")as! CVarArg
                            let str_appliedRewardPoint = dictemp.value(forKey: "appliedRewardPoint")as! CVarArg
                            //let str_remainingRewardPoint = dictemp.value(forKey: "remainingRewardPoint")as! CVarArg
                            let str_amountDeducted = dictemp.value(forKey: "amountDeducted")as! CVarArg
                            
                            self.strAppliedRewardAmountPoint = String(format: "%@", str_appliedRewardPoint)
                            self.strAppliedRewardAmount = String(format: "%@", str_amountDeducted)
                            
                            let uiAlert = UIAlertController(title: "", message: String(format: "%@ %@ %@", myAppDelegate.changeLanguage(key: "msg_language365"),self.txtrewardpoints.text!,myAppDelegate.changeLanguage(key: "msg_language366")), preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                            
                            self.txtrewardpoints.backgroundColor = UIColor(named: "greenlighter")!
                            self.txtrewardpoints.isUserInteractionEnabled = false
                            
                            self.btnapplyrewardpoints.isUserInteractionEnabled = false
                            self.btnapplyrewardpoints.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language361")), for: .normal)
                            
                            self.btnremoverewardpoints.isHidden = false
                            
                            //REFRESH
                            
                            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
                            {
                                var fltupdated = 0.00
                                
                                print("self.strGRANDTOTAL",self.strgrandtotalamount)
                                let fltgrand  = (self.strgrandtotalamount as NSString).floatValue
                                
                                print("self.strAppliedRewardAmount",self.strAppliedRewardAmount)
                                let fltdeductedrewardamount  = (self.strAppliedRewardAmount as NSString).floatValue
                                fltupdated = Double(fltgrand - fltdeductedrewardamount)
                                
                                self.strgrandtotalamount = String(format: "%0.2f", fltupdated)
                                
                                self.txtCardPaymentOrderAmount.text = String(format: "%@ %@",self.strcurrency,self.strgrandtotalamount)
                            }
                            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                            {
                                var fltupdated = 0.00
                                
                                print("self.strGRANDTOTAL",self.strgrandtotalamount)
                                let fltgrand  = (self.strgrandtotalamount as NSString).floatValue
                                
                                print("self.strAppliedRewardAmount",self.strAppliedRewardAmount)
                                let fltdeductedrewardamount  = (self.strAppliedRewardAmount as NSString).floatValue
                                fltupdated = Double(fltgrand - fltdeductedrewardamount)
                                
                                self.strgrandtotalamount = String(format: "%0.2f", fltupdated)
                                
                                self.getwalletremainingbalancelist()
                            }
                        }
                        else
                        {
                            self.txtrewardpoints.text = ""
                            self.txtrewardpoints.backgroundColor = .white
                            
                            self.txtrewardpoints.isUserInteractionEnabled = true
                            self.btnapplyrewardpoints.isUserInteractionEnabled = true
                            
                            self.btnremoverewardpoints.isHidden = true
                            
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.txtrewardpoints.isUserInteractionEnabled = true
                    self.btnapplyrewardpoints.isUserInteractionEnabled = true
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    //MARK: - NI SDK DELEGATE METHOD
    func paymentDidCompleteWithAuthCode(with status: PaymentStatus, authCode:String)
    {
        print("authCode",authCode)
        self.authCode = authCode
        paymentDidComplete(with: status)
    }
    @objc func paymentDidComplete(with status: PaymentStatus) {
        
        print("status",status)
        self.view.backgroundColor = .white
        
        if(status == .PaymentSuccess)
        {
            print("Success")
            
            print("CardReference >> ",CardReference)
            print("CardOutletId >>",CardOutletId)
            print("self.strSubscriptionincreamentalId >>",self.strSubscriptionincreamentalId)
            
            print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
            
            self.postPlaceOrder(strpaymentmethodcode: self.strselectedpaymentmethodID,strorderefernce: CardReference,stroutletid: CardOutletId,strorderincreamentalid: self.strSubscriptionincreamentalId)
            
        }
        else if(status == .PaymentFailed)
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language348") , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                //self.navigationController?.popToRootViewController(animated: true)
            }))
        }
        else if(status == .PaymentCancelled)
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language349") , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                //self.navigationController?.popToRootViewController(animated: true)
            }))
        }
    }
    /*func paymentDidComplete(with status: PaymentStatus) {
        if(status == .PaymentSuccess) {
          // Payment was successful
        } else if(status == .PaymentFailed) {
           // Payment failed
        } else if(status == .PaymentCancelled) {
          // Payment was cancelled by user
        }
      }


      func authorizationDidComplete(with status: AuthorizationStatus) {
        if(status == .AuthFailed) {
          // Authentication failed
          return
        }
        // Authentication was successful
      }
      
      // On creating an order, call the following method to show the card payment UI
      func showCardPaymentUI(orderResponse: OrderResponse) {
        let sharedSDKInstance = NISdk.sharedInstance
        sharedSDKInstance.showCardPaymentViewWith(cardPaymentDelegate: self,
                                              overParent: self,
                                              for: orderResponse)
      }*/
    
    
    
    //MARK: - post Create Renew Data API method
    func postCreateRenewDataAPIMethod()
    {
        var strpaycondition = ""
        if strpaymentype == "FULL"{
            strpaycondition = "1"
        }else{
            strpaycondition = "2"
        }
        
        let dateString = String(format: "%@", Date.getCurrentDate())
        print("subscription_created_date",dateString)
      
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        print("strSubscriptionID",strSubscriptionID)
        print("strplanid",strplanid)
        print("paymentcondition",strpaycondition)
        print("subTotal",strsubtotalamount)
        print("shippingAmount",strshippingchargesamount)
        print("grandtotal",strgrandtotalamount)
        print("discountAmount",strdiscountamount)
        print("couponcode",strcouponcode)
        print("autorenew",strautorenew)
        print("strselectedslotid",strselectedslotid)
        print("strSelectedaddressID",strSelectedaddressID)
        
           
        let parameters = ["subscriptionId": strSubscriptionID,
                          "slot": strselectedslotid,
                          "delivery_address_id": strSelectedaddressID,
                          "is_auto_renewal": strautorenew,
                          "subTotal": strsubtotalamount,
                          "grandTotal": strgrandtotalamount,
                          "shippingAmount": strshippingchargesamount,
                          "discountAmount": strdiscountamount,
                          "paymentcondition": strpaycondition,
                          "couponCode": strcouponcode,
                          "appliedRewardAmount": self.strAppliedRewardAmount,
                          "appliedRewardPoint": self.strAppliedRewardAmountPoint] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod73)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                    let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                    let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async { [self] in
                        
                        if strsuccess == true
                        {
                            let strsubscription_increment_id = String(format: "%@", dictemp.value(forKey: "subscription_increment_id")as? String ?? "")
                            self.strSubscriptionincreamentalId = strsubscription_increment_id
                            
                            //CHECKING
                            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
                            {
                                let fltTotal  = (self.strgrandtotalamount as NSString).floatValue
                                
                                let orderCreationViewController = CreateOrderViewControllerRN(paymentAmount: Double(fltTotal), refNumber: refNumber ?? "", and: self)
                                orderCreationViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
                                orderCreationViewController.modalPresentationStyle = .overCurrentContext
                                orderCreationViewController.cardPaymentCtrl = self
                                self.present(orderCreationViewController, animated: false, completion: nil)

                            }
                            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                            {
                                print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
                                self.postPlaceOrderWallet(strpaymentmethodcode: self.strselectedpaymentmethodID)
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Place Order API method - WALLET
    func postPlaceOrderWallet(strpaymentmethodcode:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        print("strpaymentmethodcode",strpaymentmethodcode)
        print("strSubscriptionincreamentalId",self.strSubscriptionincreamentalId)
        
        let parameters = ["incrementId":self.strSubscriptionincreamentalId] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod75)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let strorderIncrementId = dictemp.value(forKey: "last_order_increment_id")as? String ?? ""
                            
                            let ctrl = ordersuccess(nibName: "ordersuccess", bundle: nil)
                            ctrl.strorderid = strorderIncrementId
                            self.navigationController?.pushViewController(ctrl, animated: true)
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - post Place Order API method - CREDIT CARD
    func postPlaceOrder(strpaymentmethodcode:String,strorderefernce:String,stroutletid:String,strorderincreamentalid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["orderReference": strorderefernce,"outletId":stroutletid,"orderIncrementId":strorderincreamentalid,"paymentType":strpaymentmethodcode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod52)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let strorderIncrementId = dictemp.value(forKey: "orderIncrementId")as? String ?? ""
                            
                            UserDefaults.standard.set("3", forKey: "payfromOrderonce")
                            UserDefaults.standard.synchronize()
                            
                            let ctrl = ordersuccess(nibName: "ordersuccess", bundle: nil)
                            ctrl.strorderid = strorderIncrementId
                            self.navigationController?.pushViewController(ctrl, animated: true)
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
}
