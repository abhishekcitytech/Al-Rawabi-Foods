//
//  Subscriptionpaymentmethod.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 31/10/22.
//

import UIKit
import NISdk
import Alamofire
import SwiftyJSON
import CoreData

class Subscriptionpaymentmethod: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,CardPaymentDelegate,UITableViewDelegate,UITableViewDataSource
{
    
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
    @IBOutlet weak var btnrechargewallet: UIButton!

    @IBOutlet weak var lblrechargewallet1: UILabel!
    @IBOutlet weak var lblrechargewallet2: UILabel!
    @IBOutlet weak var lblrechargewallet3: UILabel!
    
    
    @IBOutlet weak var viewcoupon: UIView!
    @IBOutlet weak var txtcouponcode: UITextField!
    @IBOutlet weak var btnremovecouponcode: UIButton!
    @IBOutlet weak var btnapplycouponcode: UIButton!
    @IBOutlet weak var btnviewcouponcode: UIButton!
    @IBOutlet weak var lbldiscountedamountvalue: UILabel!
    
    @IBOutlet weak var viewrewardpoints: UIView!
    @IBOutlet weak var lblrewardpoints: UILabel!
    @IBOutlet weak var txtrewardpoints: UITextField!
    @IBOutlet weak var lblmaximumrewardpointsused: UILabel!
    @IBOutlet weak var btnapplyrewardpoints: UIButton!
    @IBOutlet weak var btnremoverewardpoints: UIButton!
    
    
    @IBOutlet var viewcouponlist: UIView!
    @IBOutlet weak var viewcouponlistheader1: UIView!
    @IBOutlet weak var lblcouponlistpopupheader: UILabel!
    @IBOutlet weak var btncrosscouponlistpopup: UIButton!
    @IBOutlet weak var tabvcouponlistpopup: UITableView!
    var reuseIdentifier2 = "cellcoupon"
    var viewPopupAddNewExistingBG2 = UIView()
    var msg1 = ""
    var arrMCoupons = NSMutableArray()
    
    
    var arrMpaymentmethodlist = NSMutableArray()
    
    var strselectedpaymentmethodID = ""
    
    var strsubtotalamount = ""
    var strshippingchargesamount = ""
    
    var strpageidentifier = ""
    var strpageidentifierplanname = ""
    
    var strwalletremainingbalance = ""
    var strcurrency = ""
    
    var authCode = ""
    var CardReference = ""
    var CardOutletId = ""
    var refNumber:String?
    
    var strselectedslotname = ""
    var strselectedslotid = ""
    var strpaymentype = ""
    var strselectedaddressid = ""
    var strautorenewvalue = ""
    
    var arrmShippingchargeslist1 = NSMutableArray()
    
    var dicCREATEORDER = NSMutableDictionary()
    var strSubscriptionincreamentalId = ""
    
    var strDiscountAmount = ""
    var strDiscountCouponCode = ""
    
    var strAppliedRewardAmount = ""
    var strAppliedRewardAmountPoint = ""
    
    var strGRANDTOTAL = ""
    
    var strloayltypointsavailable = ""
    var strloayltypointsmax = ""
    var strloayltypointsmin = ""
    
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
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language185")
        
        txtcouponcode.placeholder = myAppDelegate.changeLanguage(key: "msg_language229")
        btnremovecouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language49")), for: .normal)
        btnapplycouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language234")), for: .normal)
        btnviewcouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language113")), for: .normal)
        
        lblCardPaymentOrderAmount.text = myAppDelegate.changeLanguage(key: "msg_language312")
        txtCardPaymentOrderAmount.placeholder = myAppDelegate.changeLanguage(key: "msg_language313")
        btnpayment.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        
        txtwalletbalance.placeholder = myAppDelegate.changeLanguage(key: "msg_language314")
        txtpaymentamount.placeholder = myAppDelegate.changeLanguage(key: "msg_language312")
        txtremainingbalance.placeholder = myAppDelegate.changeLanguage(key: "msg_language315")
        btnpaymentwallet.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        btnrechargewallet.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language218")), for: .normal)
        
      
        lblrechargewallet1.text = myAppDelegate.changeLanguage(key: "msg_language314")
        lblrechargewallet2.text = myAppDelegate.changeLanguage(key: "msg_language312")
        lblrechargewallet3.text = myAppDelegate.changeLanguage(key: "msg_language315")
        
        
        txtrewardpoints.placeholder = myAppDelegate.changeLanguage(key: "msg_language353")
        btnapplyrewardpoints.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language234")), for: .normal)
        btnremoverewardpoints.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language49")), for: .normal)
        
        lblmaximumrewardpointsused.textColor = UIColor(named: "darkgreencolor")!
        lblmaximumrewardpointsused.text = myAppDelegate.changeLanguage(key: "msg_language377")
        
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
        
        btnrechargewallet.layer.cornerRadius = 14.0
        btnrechargewallet.layer.masksToBounds = true
        
        viewcoupon.layer.borderWidth = 1.0
        viewcoupon.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcoupon.layer.cornerRadius = 6.0
        viewcoupon.layer.masksToBounds = true
        
        txtcouponcode.setLeftPaddingPoints(10)
        txtcouponcode.layer.borderWidth = 0.0
        txtcouponcode.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        txtcouponcode.layer.cornerRadius = 0.0
        txtcouponcode.layer.masksToBounds = true
        
        btnapplycouponcode.layer.cornerRadius = 0.0
        btnapplycouponcode.layer.masksToBounds = true
        
        
        viewbottom.layer.borderWidth = 1.0
        viewbottom.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewbottom.layer.cornerRadius = 6.0
        viewbottom.layer.masksToBounds = true
        
        viewbottom1.layer.borderWidth = 1.0
        viewbottom1.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewbottom1.layer.cornerRadius = 6.0
        viewbottom1.layer.masksToBounds = true
        
        viewrewardpoints.layer.borderWidth = 1.0
        viewrewardpoints.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewrewardpoints.layer.cornerRadius = 6.0
        viewrewardpoints.layer.masksToBounds = true
        
        btnapplyrewardpoints.layer.cornerRadius = 0.0
        btnapplyrewardpoints.layer.masksToBounds = true
        
        txtrewardpoints.setLeftPaddingPoints(10)
       
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDoneRewardPoints))
        toolbarDone.items = [barBtnDone]
        txtrewardpoints.inputAccessoryView = toolbarDone
        
        if strselectedpaymentmethodID.count == 0{
            self.viewbottom.isHidden = true
            self.viewbottom1.isHidden = true
            self.viewcoupon.isHidden = true
            self.viewrewardpoints.isHidden = true
        }
        
        if self.btnapplycouponcode.isUserInteractionEnabled == false
        {
            btnremovecouponcode.isHidden = false
        }
        else{
            btnremovecouponcode.isHidden = true
        }
        
        if txtrewardpoints.isUserInteractionEnabled == false
        {
            btnremoverewardpoints.isHidden = false
        }
        else
        {
            btnremoverewardpoints.isHidden = true
        }
        
        createmethodsview()
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
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
                    let fltamount  = (self.strGRANDTOTAL as NSString).floatValue
                    self.postApplyRewardPointsSubscriptionAPI(strorderamount: String(format: "%0.2f", fltamount))
                }
                else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                {
                    let fltamount  = (self.strGRANDTOTAL as NSString).floatValue
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
                let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
                let fltamount11  = (self.strAppliedRewardAmount as NSString).floatValue
                
                fltupdated = Double(fltamount1 + fltamount11)
                print("fltupdated",fltupdated)
                self.strGRANDTOTAL = String(format: "%0.2f",fltupdated)
                
                self.txtCardPaymentOrderAmount.text = String(format: "%@ %@",self.strcurrency,self.strGRANDTOTAL)

            }
            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
            {
                var fltupdated = 0.00
                let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
                let fltamount11  = (self.strAppliedRewardAmount as NSString).floatValue
                
                fltupdated = Double(fltamount1 + fltamount11)
                print("fltupdated",fltupdated)
                self.strGRANDTOTAL = String(format: "%0.2f",fltupdated)
                
                let fltamount3  = (strwalletremainingbalance as NSString).doubleValue
                print("fltamount3",fltamount3)
                
                let fltamount4  = (self.strGRANDTOTAL as NSString).doubleValue
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
        if strpageidentifier == "100"{
            //DAILY
            self.createorderDataDAILYSubscription()
        }
        else if strpageidentifier == "200"{
            //WEEKLY
            self.createorderDataWEEKLYSubscription()
        }
        else if strpageidentifier == "300"{
            //MONTHLY
            self.createorderDataMONTHLYSubscription()
        }
    }
    
    //MARK: - press Recharge Wallet method
    @IBAction func pressrechargewallet(_ sender: Any)
    {
        let ctrl = rechargewallet(nibName: "rechargewallet", bundle: nil)
        ctrl.strpageFromPayment = "1021"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press payment Wallet method
    @IBAction func presspaymentwallet(_ sender: Any)
    {
        //let ctrl = ordersuccess(nibName: "ordersuccess", bundle: nil)
        //self.navigationController?.pushViewController(ctrl, animated: true)
        
        if strpageidentifier == "100"{
            //DAILY
            self.createorderDataDAILYSubscription()
        }
        else if strpageidentifier == "200"{
            //WEEKLY
            self.createorderDataWEEKLYSubscription()
        }
        else if strpageidentifier == "300"{
            //MONTHLY
            self.createorderDataMONTHLYSubscription()
        }
    }
    
    //MARK: - press View coupon code
    @IBAction func pressViewcouponcode(_ sender: Any)
    {
        self.getallCoupons()
    }
    
    
    //MARK: - press Apply / Remove coupon code
    @IBAction func pressApplycouponcode(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtcouponcode.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language346"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
            {
                let fltamount  = (self.strGRANDTOTAL as NSString).floatValue
                self.postApplyCouponMethod(strcode: txtcouponcode.text!, strsubtotal: String(format: "%0.2f", fltamount))
            }
            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
            {
                let fltamount  = (self.strGRANDTOTAL as NSString).floatValue
                self.postApplyCouponMethod(strcode: txtcouponcode.text!, strsubtotal: String(format: "%0.2f", fltamount))
            }
            
        }
    }
    @IBAction func pressRemovecouponcode(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        print("self.strsubtotalamount",self.strsubtotalamount)
        print("self.strDiscountAmount",self.strDiscountAmount)
        print("self.strshippingchargesamount",self.strshippingchargesamount)
        print("self.strcurrency",self.strcurrency)
        
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language347"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            
            print("Handle Continue Logic here")
            
            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
            {
                var fltupdated = 0.00
                let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
                let fltamount11  = (self.strDiscountAmount as NSString).floatValue
                
                fltupdated = Double(fltamount1 + fltamount11)
                print("fltupdated",fltupdated)
                self.strGRANDTOTAL = String(format: "%0.2f",fltupdated)
                
                self.txtCardPaymentOrderAmount.text = String(format: "%@ %@",self.strcurrency,self.strGRANDTOTAL)

            }
            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
            {
                var fltupdated = 0.00
                let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
                let fltamount11  = (self.strDiscountAmount as NSString).floatValue
                
                fltupdated = Double(fltamount1 + fltamount11)
                print("fltupdated",fltupdated)
                self.strGRANDTOTAL = String(format: "%0.2f",fltupdated)
                
                let fltamount3  = (strwalletremainingbalance as NSString).doubleValue
                print("fltamount3",fltamount3)
                
                let fltamount4  = (self.strGRANDTOTAL as NSString).doubleValue
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
            self.strDiscountAmount = ""
            self.strDiscountCouponCode = ""
            self.txtcouponcode.isUserInteractionEnabled = true
            self.txtcouponcode.text = ""
            self.btnapplycouponcode.isUserInteractionEnabled = true
            self.btnapplycouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language234")), for: .normal)
            self.btnremovecouponcode.isHidden = true
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - create POPUP COUPON LIST method
    func createCOUPONLIST()
    {
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewcouponlist.layer.cornerRadius = 6.0
        self.viewcouponlist.layer.masksToBounds = true
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        self.lblcouponlistpopupheader.text = appDel.changeLanguage(key: "msg_language228")
        
        tabvcouponlistpopup.register(UINib(nibName: "cellcoupon", bundle: nil), forCellReuseIdentifier: reuseIdentifier2)
        tabvcouponlistpopup.separatorStyle = .none
        tabvcouponlistpopup.backgroundView=nil
        tabvcouponlistpopup.tag = 1111
        tabvcouponlistpopup.backgroundColor=UIColor.clear
        tabvcouponlistpopup.separatorColor=UIColor.clear
        tabvcouponlistpopup.showsVerticalScrollIndicator = false
        
        viewPopupAddNewExistingBG2 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG2.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG2.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG2.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG2.addSubview(self.viewcouponlist)
        self.viewcouponlist.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG2)
        
        self.tabvcouponlistpopup.reloadData()
    }
    @IBAction func presscrosscouponpopup(_ sender: Any)
    {
        viewPopupAddNewExistingBG2.removeFromSuperview()
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if arrMCoupons.count == 0 {
            self.tabvcouponlistpopup.setEmptyMessage(msg)
        } else {
            self.tabvcouponlistpopup.restore()
        }
        return arrMCoupons.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as! cellcoupon
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMCoupons.object(at: indexPath.row)as! NSDictionary
        
        let strcouponcode = String(format: "%@", dic.value(forKey: "code")as? String ?? "")
        let strexpdate = String(format: "%@", dic.value(forKey: "expiration_date")as? String ?? "DD/MM/YYYY")
        
        cell.lblselectcopy.layer.cornerRadius = 6.0
        cell.lblselectcopy.layer.masksToBounds = true
        
        cell.lblcouponcode.text = String(format: "%@ %@", myAppDelegate.changeLanguage(key: "msg_language230"),strcouponcode)
        cell.lblexpdate.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language231"),strexpdate)
     
        //cell.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
        cell.viewcell.backgroundColor = .white
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 69.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.arrMCoupons.object(at: indexPath.row)as! NSDictionary
        let strcouponcode = String(format: "%@", dic.value(forKey: "code")as? String ?? "")
        //let strexpdate = String(format: "%@", dic.value(forKey: "expiration_date")as? String ?? "DD/MM/YYYY")
        print("strcouponcode",strcouponcode)
        
        self.txtcouponcode.text = strcouponcode
        
        viewPopupAddNewExistingBG2.removeFromSuperview()
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var strpreviouslyselectedcode = self.strselectedpaymentmethodID
        
        let dictemp = arrMpaymentmethodlist.object(at: indexPath.row)as? NSDictionary
        let strcode = String(format: "%@", dictemp?.value(forKey: "code")as! CVarArg)
        let strtitle = String(format: "%@", dictemp?.value(forKey: "title")as? String ?? "")
        
        self.strselectedpaymentmethodID = strcode
        
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
                            self.strcurrency = "AED"
                        }
                        
                        let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
                        
                        self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltamount1)
                    }
                    else if strcode.containsIgnoreCase("walletpayment") || strcode.containsIgnoreCase("walletsystem")
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
                    self.strcurrency = "AED"
                }
                
                let fltamount1  = (self.strGRANDTOTAL as NSString).floatValue
                
                self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltamount1)
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
        print("self.strGRANDTOTAL",self.strGRANDTOTAL)
        let fltamount4  = (self.strGRANDTOTAL as NSString).doubleValue
        
        let fltamount3  = (strwalletremainingbalance as NSString).doubleValue
        print("fltamount3",fltamount3)
        
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
        
        let strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod40,"")
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
                            
                            self.viewcoupon.isHidden = false
                            self.viewrewardpoints.isHidden = false
                            
                            
                            if self.strselectedpaymentmethodID.count > 0
                            {
                                //ALREADY SELECTED PRE DEFINED PAYMENT METHOD, NO NEED TO RELOAD PAGE
                            }
                            else
                            {
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
                            }
                            
                            
                            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
                            {
                                self.viewbottom.isHidden = false
                                self.viewbottom1.isHidden = true
                                
                                if self.strcurrency.count == 0{
                                    self.strcurrency = "AED"
                                }
                                var fltTotal = 0.00
                                let fltamount1  = (self.strsubtotalamount as NSString).floatValue
                                let fltamount2  = (self.strshippingchargesamount as NSString).floatValue
                                fltTotal = Double(fltamount1 + fltamount2)
                                
                                self.strGRANDTOTAL = String(format: "%0.2f",fltTotal)
                                self.txtCardPaymentOrderAmount.text = String(format: "%@ %@",self.strcurrency,self.strGRANDTOTAL)
                            }
                            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                            {
                                self.viewbottom.isHidden = true
                                self.viewbottom1.isHidden = false
                                
                                if self.strcurrency.count == 0{
                                    self.strcurrency = "AED"
                                }
                                var fltTotal = 0.00
                                let fltamount1  = (self.strsubtotalamount as NSString).floatValue
                                let fltamount2  = (self.strshippingchargesamount as NSString).floatValue
                                fltTotal = Double(fltamount1 + fltamount2)
                                
                                self.strGRANDTOTAL = String(format: "%0.2f",fltTotal)
                                
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
        self.btnrechargewallet.isHidden = false
        
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
                            let strwallet_remaining_amount = dictemp.value(forKey: "wallet_remaining_amount")as? String ?? ""
                            let strcurrency = dictemp.value(forKey: "currency")as? String ?? ""
                            self.strcurrency = strcurrency
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
    
    
    
    //MARK: - get All Coupons API method
    func getallCoupons()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod22,"")
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
                    
                    print("json --->",json)
                    
                    let dictemp = json as NSDictionary
                    
                   
                     let strstatus = dictemp.value(forKey: "status")as? Int ?? 0
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            if self.arrMCoupons.count > 0{
                                self.arrMCoupons.removeAllObjects()
                            }
                            
                            let arrmcoupon = json.value(forKey: "list") as? NSArray ?? []
                            self.arrMCoupons = NSMutableArray(array: arrmcoupon)
                            print("arrMCoupons --->",self.arrMCoupons)
                            
                            if self.arrMCoupons.count == 0{
                                self.msg = "No orders found!"
                            }
                            
                            self.createCOUPONLIST()
                        }
                        else
                        {
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
    
    //MARK: - post Apply Coupon code Method
    func postApplyCouponMethod(strcode:String,strsubtotal:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["couponCode": strcode,"subTotal":strsubtotal] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod51)
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
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async { [self] in
                        
                        if strsuccess == true
                        {
                            //let strsubtotal = String(format: "%@", dictemp.value(forKey: "subtotal")as? String ?? "")
                            let strdiscount_amount = String(format: "%@", dictemp.value(forKey: "discount_amount")as! CVarArg)
                            let strcoupon_code = String(format: "%@", dictemp.value(forKey: "coupon_code")as? String ?? "")
                            
                            self.strDiscountAmount = strdiscount_amount
                            self.strDiscountCouponCode = strcoupon_code
                            
                            self.txtcouponcode.isUserInteractionEnabled = false
                            self.btnapplycouponcode.isUserInteractionEnabled = false
                            self.btnapplycouponcode.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language361")), for: .normal)
                            
                            self.btnremovecouponcode.isHidden = false

                            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
                            {
                                var fltupdated = 0.00
                                
                                print("self.strGRANDTOTAL",self.strGRANDTOTAL)
                                let fltgrand  = (self.strGRANDTOTAL as NSString).floatValue
                                
                                print("self.strDiscountAmount",self.strDiscountAmount)
                                let fltdiscountamount  = (self.strDiscountAmount as NSString).floatValue
                                fltupdated = Double(fltgrand - fltdiscountamount)
                                
                                self.strGRANDTOTAL = String(format: "%0.2f", fltupdated)
                                
                                self.txtCardPaymentOrderAmount.text = String(format: "%@ %@",self.strcurrency,self.strGRANDTOTAL)
                            }
                            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                            {
                                var fltupdated = 0.00
                                
                                print("self.strGRANDTOTAL",self.strGRANDTOTAL)
                                let fltgrand  = (self.strGRANDTOTAL as NSString).floatValue
                                
                                print("self.strDiscountAmount",self.strDiscountAmount)
                                let fltdiscountamount  = (self.strDiscountAmount as NSString).floatValue
                                fltupdated = Double(fltgrand - fltdiscountamount)
                                
                                self.strGRANDTOTAL = String(format: "%0.2f", fltupdated)
                                
                                self.getwalletremainingbalancelist()
                            }
                            
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language232"), preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        else{
                            
                            self.btnremovecouponcode.isHidden = true
                            
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
                    
                            self.strloayltypointsavailable =  strpoints
                            print("self.strloayltypointsavailable",self.strloayltypointsavailable)
                            
                            self.lblrewardpoints.text = String(format: "%@ %@ %@", myAppDelegate.changeLanguage(key: "msg_language359"),self.strloayltypointsavailable,myAppDelegate.changeLanguage(key: "msg_language360"))
                            
                            if strpoints == "0" || strpoints == "0.0"
                            {
                                self.lblmaximumrewardpointsused.textColor = UIColor(named: "darkmostredcolor")!
                                self.lblmaximumrewardpointsused.text = myAppDelegate.changeLanguage(key: "msg_language355")
                                self.btnapplyrewardpoints.isUserInteractionEnabled = false
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
                    
                    //let str_availableRewardPoint = dictemp.value(forKey: "availableRewardPoint")as! CVarArg
                    let str_appliedRewardPoint = dictemp.value(forKey: "appliedRewardPoint")as! CVarArg
                    //let str_remainingRewardPoint = dictemp.value(forKey: "remainingRewardPoint")as! CVarArg
                    let str_amountDeducted = dictemp.value(forKey: "amountDeducted")as! CVarArg

                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    self.strAppliedRewardAmountPoint = String(format: "%@", str_appliedRewardPoint)
                    self.strAppliedRewardAmount = String(format: "%@", str_amountDeducted)

                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
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
                                
                                print("self.strGRANDTOTAL",self.strGRANDTOTAL)
                                let fltgrand  = (self.strGRANDTOTAL as NSString).floatValue
                                
                                print("self.strAppliedRewardAmount",self.strAppliedRewardAmount)
                                let fltdeductedrewardamount  = (self.strAppliedRewardAmount as NSString).floatValue
                                fltupdated = Double(fltgrand - fltdeductedrewardamount)
                                
                                self.strGRANDTOTAL = String(format: "%0.2f", fltupdated)
                                
                                self.txtCardPaymentOrderAmount.text = String(format: "%@ %@",self.strcurrency,self.strGRANDTOTAL)
                            }
                            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                            {
                                var fltupdated = 0.00
                                
                                print("self.strGRANDTOTAL",self.strGRANDTOTAL)
                                let fltgrand  = (self.strGRANDTOTAL as NSString).floatValue
                                
                                print("self.strDiscountAmount",self.strDiscountAmount)
                                let fltdeductedrewardamount  = (self.strAppliedRewardAmount as NSString).floatValue
                                fltupdated = Double(fltgrand - fltdeductedrewardamount)
                                
                                self.strGRANDTOTAL = String(format: "%0.2f", fltupdated)
                                
                                self.getwalletremainingbalancelist()
                            }
                        }
                        else
                        {
                            self.txtrewardpoints.backgroundColor = .white
                            
                            self.txtrewardpoints.isUserInteractionEnabled = true
                            self.btnapplyrewardpoints.isUserInteractionEnabled = true
                            
                            self.btnremoverewardpoints.isHidden = true
                            
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
                    self.txtrewardpoints.isUserInteractionEnabled = true
                    self.btnapplyrewardpoints.isUserInteractionEnabled = true
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    
    //MARK: - create DAILY / WEEKLY / MONTHLY Subscription Create Order Data
    @objc func createorderDataDAILYSubscription()
    {
        
        print("arrmShippingchargeslist1",self.arrmShippingchargeslist1)
        
        self.fetchDataSubscriptionmodelTableAUTORENEW()
        print("self.strautorenewvalue",self.strautorenewvalue)
        
        let dateString = String(format: "%@", Date.getCurrentDate())
        
        var strpaymentoption = ""
        if strpaymentype == "FULL"{
            strpaymentoption = "1"
        }else{
            strpaymentoption = "2"
        }
        
        dicCREATEORDER.setValue("1", forKey: "plan_id")
        dicCREATEORDER.setValue(dateString, forKey: "subscription_date")
        dicCREATEORDER.setValue(strselectedslotid, forKey: "slot")
        dicCREATEORDER.setValue(strselectedaddressid, forKey: "delivery_address_id")
        dicCREATEORDER.setValue("1", forKey: "status")
        dicCREATEORDER.setValue(self.strautorenewvalue, forKey: "is_auto_renewal")
        dicCREATEORDER.setValue(dateString, forKey: "subscription_created_date")
        //dicCREATEORDER.setValue("", forKey: "subscription_increment_id")
        dicCREATEORDER.setValue(strpaymentoption, forKey: "paymentcondition")
        
        
        //FETCH DATE LIST FROM DAILY-MODEL
        let arrMDateBlock = NSMutableArray()
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"1")
        do {
            let result = try manageContent.fetch(fetchData)
            //print("result",result)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    dictemp.setValue(data.value(forKeyPath: "isrenew") ?? "", forKey: "isrenew")
                    dictemp.setValue(data.value(forKeyPath: "selected") ?? "", forKey: "selected")
                    dictemp.setValue(data.value(forKeyPath: "subscriptionid") ?? "", forKey: "subscriptionid")
                    dictemp.setValue(data.value(forKeyPath: "userid") ?? "", forKey: "userid")
                    
                    arrMDateBlock.add(dictemp)
                    
                }
            }
            else{
                
            }
        }catch {
            print("err")
        }
        
        let dict = arrMDateBlock.object(at: 0)as! NSMutableDictionary
        let strstartdate = String(format: "%@", dict.value(forKey: "date")as? String ?? "")
        let dict1 = arrMDateBlock.lastObject as! NSMutableDictionary
        let strenddate = String(format: "%@", dict1.value(forKey: "date")as? String ?? "")
        
        dicCREATEORDER.setValue(strstartdate, forKey: "subscription_start_date")
        dicCREATEORDER.setValue(strenddate, forKey: "subscription_end_date")
        
        let arrMsubscription_order_details = NSMutableArray()
        for jj in 0 ..< arrMDateBlock.count
        {
            let dictm1 = arrMDateBlock.object(at: jj)as? NSMutableDictionary
            let strdate1 = String(format: "%@", dictm1!.value(forKey: "date")as? String ?? "")
            let day1 = String(format: "%@", dictm1!.value(forKey: "day")as? String ?? "")
            
            let dictshipping = self.arrmShippingchargeslist1.object(at: jj)as? NSDictionary
            let strcharges = String(format: "%@", dictshipping?.value(forKey: "delivery_charge")as? String ?? "0.00")
            print("strcharges",strcharges)
            
            let dictemp1 = NSMutableDictionary()
            dictemp1.setValue(strdate1, forKey: "order_date")
            dictemp1.setValue(day1, forKey: "day")
            dictemp1.setValue(strcharges, forKey: "shipping_amount")
            dictemp1.setValue("0", forKey: "payment_status")
            
            
            let dictm = arrMDateBlock.object(at: jj)as? NSMutableDictionary
            let strdate = String(format: "%@", dictm!.value(forKey: "date")as? String ?? "")
            
            let arrMproduct = NSMutableArray()
            
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
            fetchData.predicate = NSPredicate(format: "date = %@",strdate)
            do {
                let result = try manageContent.fetch(fetchData)
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        let dictMproduct = NSMutableDictionary()
                        dictMproduct.setValue(data.value(forKeyPath: "productid") ?? "", forKey: "product_id")
                        dictMproduct.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "product_price")
                        dictMproduct.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "product_original_price")
                        dictMproduct.setValue(data.value(forKeyPath: "qtyonce") ?? "", forKey: "qty")
                        dictMproduct.setValue(data.value(forKeyPath: "qtyall") ?? "", forKey: "qty_all")
                        dictMproduct.setValue("", forKey: "discount_amount")

                        arrMproduct.add(dictMproduct)
                    }
                    //print("arrMproduct",arrMproduct)
                    dictemp1.setValue(arrMproduct, forKey: "order_product")
                }
            }catch {
                print("err")
            }
            arrMsubscription_order_details.add(dictemp1)
        }
        
        //print("arrMsubscription_order_details",arrMsubscription_order_details)
        dicCREATEORDER.setValue(arrMsubscription_order_details, forKey: "subscription_order_details")
        
        var fltTotal = 0.00
        let fltamount1  = (strsubtotalamount as NSString).floatValue
        let fltamount2  = (strshippingchargesamount as NSString).floatValue
        fltTotal = Double(fltamount1 + fltamount2)
        
        dicCREATEORDER.setValue(strsubtotalamount, forKey: "subTotal")
        dicCREATEORDER.setValue(String(format: "%.2f", fltTotal), forKey: "grandTotal")
        dicCREATEORDER.setValue(strselectedaddressid, forKey: "shippingAddressId")
        dicCREATEORDER.setValue(self.strDiscountAmount, forKey: "discountAmount")
        dicCREATEORDER.setValue(self.strDiscountCouponCode, forKey: "couponCode")
        dicCREATEORDER.setValue(strshippingchargesamount, forKey: "shippingAmount")
        
        dicCREATEORDER.setValue(self.strAppliedRewardAmount, forKey: "appliedRewardAmount")
        dicCREATEORDER.setValue(self.strAppliedRewardAmountPoint, forKey: "appliedRewardPoint")

        print("dicCREATEORDER ----->",dicCREATEORDER)
        
        //CALL API
        self.postSusbscriptionCreateOrder()
    }
    @objc func createorderDataWEEKLYSubscription()
    {
        print("arrmShippingchargeslist1",self.arrmShippingchargeslist1)
        
        self.fetchDataSubscriptionmodelTableAUTORENEW()
        print("self.strautorenewvalue",self.strautorenewvalue)
        
        let dateString = String(format: "%@", Date.getCurrentDate())
        
        var strpaymentoption = ""
        if strpaymentype == "FULL"{
            strpaymentoption = "1"
        }else{
            strpaymentoption = "2"
        }
        
        dicCREATEORDER.setValue("2", forKey: "plan_id")
        dicCREATEORDER.setValue(dateString, forKey: "subscription_date")
        dicCREATEORDER.setValue(strselectedslotid, forKey: "slot")
        dicCREATEORDER.setValue(strselectedaddressid, forKey: "delivery_address_id")
        dicCREATEORDER.setValue("1", forKey: "status")
        dicCREATEORDER.setValue(self.strautorenewvalue, forKey: "is_auto_renewal")
        dicCREATEORDER.setValue(dateString, forKey: "subscription_created_date")
        //dicCREATEORDER.setValue("", forKey: "subscription_increment_id")
        dicCREATEORDER.setValue(strpaymentoption, forKey: "paymentcondition")
        
        
        //FETCH DATE LIST FROM DAILY-MODEL
        let arrMDateBlock = NSMutableArray()
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && selected == %@", strcustomerid,"2","1")
        do {
            let result = try manageContent.fetch(fetchData)
            //print("result",result)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    dictemp.setValue(data.value(forKeyPath: "isrenew") ?? "", forKey: "isrenew")
                    dictemp.setValue(data.value(forKeyPath: "selected") ?? "", forKey: "selected")
                    dictemp.setValue(data.value(forKeyPath: "subscriptionid") ?? "", forKey: "subscriptionid")
                    dictemp.setValue(data.value(forKeyPath: "userid") ?? "", forKey: "userid")
                    
                    arrMDateBlock.add(dictemp)
                    
                }
            }
            else{
                
            }
        }catch {
            print("err")
        }
        
        let dict = arrMDateBlock.object(at: 0)as! NSMutableDictionary
        let strstartdate = String(format: "%@", dict.value(forKey: "date")as? String ?? "")
        let dict1 = arrMDateBlock.lastObject as! NSMutableDictionary
        let strenddate = String(format: "%@", dict1.value(forKey: "date")as? String ?? "")
        dicCREATEORDER.setValue(strstartdate, forKey: "subscription_start_date")
        dicCREATEORDER.setValue(strenddate, forKey: "subscription_end_date")
        
        let arrMsubscription_order_details = NSMutableArray()
        for jj in 0 ..< arrMDateBlock.count
        {
            let dictm1 = arrMDateBlock.object(at: jj)as? NSMutableDictionary
            let strdate1 = String(format: "%@", dictm1!.value(forKey: "date")as? String ?? "")
            let day1 = String(format: "%@", dictm1!.value(forKey: "day")as? String ?? "")
            
            let dictshipping = self.arrmShippingchargeslist1.object(at: jj)as? NSDictionary
            let strcharges = String(format: "%@", dictshipping?.value(forKey: "delivery_charge")as? String ?? "0.00")
            print("strcharges",strcharges)
            
            let dictemp1 = NSMutableDictionary()
            dictemp1.setValue(strdate1, forKey: "order_date")
            dictemp1.setValue(day1, forKey: "day")
            dictemp1.setValue(strcharges, forKey: "shipping_amount")
            dictemp1.setValue("0", forKey: "payment_status")
            
            
            let dictm = arrMDateBlock.object(at: jj)as? NSMutableDictionary
            let strdate = String(format: "%@", dictm!.value(forKey: "date")as? String ?? "")
            
            let arrMproduct = NSMutableArray()
            
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
            fetchData.predicate = NSPredicate(format: "date = %@",strdate)
            do {
                let result = try manageContent.fetch(fetchData)
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        let dictMproduct = NSMutableDictionary()
                        dictMproduct.setValue(data.value(forKeyPath: "productid") ?? "", forKey: "product_id")
                        dictMproduct.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "product_price")
                        dictMproduct.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "product_original_price")
                        dictMproduct.setValue(data.value(forKeyPath: "qtyonce") ?? "", forKey: "qty")
                        dictMproduct.setValue(data.value(forKeyPath: "qtyall") ?? "", forKey: "qty_all")
                        dictMproduct.setValue("", forKey: "discount_amount")

                        arrMproduct.add(dictMproduct)
                    }
                    //print("arrMproduct",arrMproduct)
                    dictemp1.setValue(arrMproduct, forKey: "order_product")
                }
            }catch {
                print("err")
            }
            arrMsubscription_order_details.add(dictemp1)
        }
        
        //print("arrMsubscription_order_details",arrMsubscription_order_details)
        dicCREATEORDER.setValue(arrMsubscription_order_details, forKey: "subscription_order_details")
        
        var fltTotal = 0.00
        let fltamount1  = (strsubtotalamount as NSString).floatValue
        let fltamount2  = (strshippingchargesamount as NSString).floatValue
        fltTotal = Double(fltamount1 + fltamount2)
        
        dicCREATEORDER.setValue(strsubtotalamount, forKey: "subTotal")
        dicCREATEORDER.setValue(String(format: "%.2f", fltTotal), forKey: "grandTotal")
        dicCREATEORDER.setValue(strselectedaddressid, forKey: "shippingAddressId")
        dicCREATEORDER.setValue(self.strDiscountAmount, forKey: "discountAmount")
        dicCREATEORDER.setValue(self.strDiscountCouponCode, forKey: "couponCode")
        dicCREATEORDER.setValue(strshippingchargesamount, forKey: "shippingAmount")
        
        dicCREATEORDER.setValue(self.strAppliedRewardAmount, forKey: "appliedRewardAmount")
        dicCREATEORDER.setValue(self.strAppliedRewardAmountPoint, forKey: "appliedRewardPoint")
        
        print("dicCREATEORDER ----->",dicCREATEORDER)
        
        //CALL API
        self.postSusbscriptionCreateOrder()
    }
    @objc func createorderDataMONTHLYSubscription()
    {
        print("arrmShippingchargeslist1",self.arrmShippingchargeslist1)
        
        self.fetchDataSubscriptionmodelTableAUTORENEW()
        print("self.strautorenewvalue",self.strautorenewvalue)
        
        let dateString = String(format: "%@", Date.getCurrentDate())
        
        var strpaymentoption = ""
        if strpaymentype == "FULL"{
            strpaymentoption = "1"
        }else{
            strpaymentoption = "2"
        }
        
        dicCREATEORDER.setValue("3", forKey: "plan_id")
        dicCREATEORDER.setValue(dateString, forKey: "subscription_date")
        dicCREATEORDER.setValue(strselectedslotid, forKey: "slot")
        dicCREATEORDER.setValue(strselectedaddressid, forKey: "delivery_address_id")
        dicCREATEORDER.setValue("1", forKey: "status")
        dicCREATEORDER.setValue(self.strautorenewvalue, forKey: "is_auto_renewal")
        dicCREATEORDER.setValue(dateString, forKey: "subscription_created_date")
        //dicCREATEORDER.setValue("", forKey: "subscription_increment_id")
        dicCREATEORDER.setValue(strpaymentoption, forKey: "paymentcondition")
        
        
        //FETCH DATE LIST FROM DAILY-MODEL
        let arrMDateBlock = NSMutableArray()
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@ && selected == %@", strcustomerid,"3","1")
        do {
            let result = try manageContent.fetch(fetchData)
            //print("result",result)
            if result.count > 0{
                
                for data in result as! [NSManagedObject]{
                    
                    let dictemp = NSMutableDictionary()
                    dictemp.setValue(data.value(forKeyPath: "date") ?? "", forKey: "date")
                    dictemp.setValue(data.value(forKeyPath: "day") ?? "", forKey: "day")
                    dictemp.setValue(data.value(forKeyPath: "isrenew") ?? "", forKey: "isrenew")
                    dictemp.setValue(data.value(forKeyPath: "selected") ?? "", forKey: "selected")
                    dictemp.setValue(data.value(forKeyPath: "subscriptionid") ?? "", forKey: "subscriptionid")
                    dictemp.setValue(data.value(forKeyPath: "userid") ?? "", forKey: "userid")
                    
                    arrMDateBlock.add(dictemp)
                    
                }
            }
            else{
                
            }
        }catch {
            print("err")
        }
        
        let dict = arrMDateBlock.object(at: 0)as! NSMutableDictionary
        let strstartdate = String(format: "%@", dict.value(forKey: "date")as? String ?? "")
        let dict1 = arrMDateBlock.lastObject as! NSMutableDictionary
        let strenddate = String(format: "%@", dict1.value(forKey: "date")as? String ?? "")
        dicCREATEORDER.setValue(strstartdate, forKey: "subscription_start_date")
        dicCREATEORDER.setValue(strenddate, forKey: "subscription_end_date")
        
        let arrMsubscription_order_details = NSMutableArray()
        for jj in 0 ..< arrMDateBlock.count
        {
            let dictm1 = arrMDateBlock.object(at: jj)as? NSMutableDictionary
            let strdate1 = String(format: "%@", dictm1!.value(forKey: "date")as? String ?? "")
            let day1 = String(format: "%@", dictm1!.value(forKey: "day")as? String ?? "")
            
            let dictshipping = self.arrmShippingchargeslist1.object(at: jj)as? NSDictionary
            let strcharges = String(format: "%@", dictshipping?.value(forKey: "delivery_charge")as? String ?? "0.00")
            print("strcharges",strcharges)
            
            let dictemp1 = NSMutableDictionary()
            dictemp1.setValue(strdate1, forKey: "order_date")
            dictemp1.setValue(day1, forKey: "day")
            dictemp1.setValue(strcharges, forKey: "shipping_amount")
            dictemp1.setValue("0", forKey: "payment_status")
            
            
            let dictm = arrMDateBlock.object(at: jj)as? NSMutableDictionary
            let strdate = String(format: "%@", dictm!.value(forKey: "date")as? String ?? "")
            
            let arrMproduct = NSMutableArray()
            
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
            fetchData.predicate = NSPredicate(format: "date = %@",strdate)
            do {
                let result = try manageContent.fetch(fetchData)
                if result.count > 0{
                    
                    for data in result as! [NSManagedObject]{
                        
                        let dictMproduct = NSMutableDictionary()
                        dictMproduct.setValue(data.value(forKeyPath: "productid") ?? "", forKey: "product_id")
                        dictMproduct.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "product_price")
                        dictMproduct.setValue(data.value(forKeyPath: "productprice") ?? "", forKey: "product_original_price")
                        dictMproduct.setValue(data.value(forKeyPath: "qtyonce") ?? "", forKey: "qty")
                        dictMproduct.setValue(data.value(forKeyPath: "qtyall") ?? "", forKey: "qty_all")
                        dictMproduct.setValue("", forKey: "discount_amount")

                        arrMproduct.add(dictMproduct)
                    }
                    //print("arrMproduct",arrMproduct)
                    dictemp1.setValue(arrMproduct, forKey: "order_product")
                }
            }catch {
                print("err")
            }
            arrMsubscription_order_details.add(dictemp1)
        }
        
        //print("arrMsubscription_order_details",arrMsubscription_order_details)
        dicCREATEORDER.setValue(arrMsubscription_order_details, forKey: "subscription_order_details")
        
        var fltTotal = 0.00
        let fltamount1  = (strsubtotalamount as NSString).floatValue
        let fltamount2  = (strshippingchargesamount as NSString).floatValue
        fltTotal = Double(fltamount1 + fltamount2)
        
        dicCREATEORDER.setValue(strsubtotalamount, forKey: "subTotal")
        dicCREATEORDER.setValue(String(format: "%.2f", fltTotal), forKey: "grandTotal")
        dicCREATEORDER.setValue(strselectedaddressid, forKey: "shippingAddressId")
        dicCREATEORDER.setValue(self.strDiscountAmount, forKey: "discountAmount")
        dicCREATEORDER.setValue(self.strDiscountCouponCode, forKey: "couponCode")
        dicCREATEORDER.setValue(strshippingchargesamount, forKey: "shippingAmount")
        
        dicCREATEORDER.setValue(self.strAppliedRewardAmount, forKey: "appliedRewardAmount")
        dicCREATEORDER.setValue(self.strAppliedRewardAmountPoint, forKey: "appliedRewardPoint")
        
        print("dicCREATEORDER ----->",dicCREATEORDER)
        
        //CALL API
        self.postSusbscriptionCreateOrder()
    }
    
    //MARK: - Fetch SubscriptionmodelTable data AUTONENEW exist or not
    func fetchDataSubscriptionmodelTableAUTORENEW()
    {
        var tablnametag = ""
        if strpageidentifier == "100"{
            //DAILY
            tablnametag = "Daily"
        }
        else if strpageidentifier == "200"{
            //WEEKLY
            tablnametag = "Weekly"
        }
        else if strpageidentifier == "200"{
            //MONTHLY
            tablnametag = "Monthly"
        }
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,tablnametag)
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            if result.count > 0
            {
                // result available
                
                for data in result as! [NSManagedObject]{
                    
                    let strautonewcode = data.value(forKeyPath: "isrenew") ?? ""
                    print("strautonewcode", strautonewcode)

                    if strautonewcode as! String == "0"
                    {
                        self.strautorenewvalue = "0"
                    }
                    else{
                        self.strautorenewvalue = "1"
                    }
                }
            }
            else{
                //result not available
            }
        }catch {
            print("err")
        }
    }
    
    //MARK: - post Create Subscription Create Order Method
    func postSusbscriptionCreateOrder()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        print("dic",dicCREATEORDER)
        //let parameters = ["customeraddressId": strselectedaddressid] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod50)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: dicCREATEORDER) as NSData
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
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async { [self] in
                        
                        if strsuccess == true
                        {
                            print("CREATE SUCCESS ORDER")
                            
                            let strsubscription_id = String(format: "%@", dictemp.value(forKey: "subscription_id")as? String ?? "")
                            let strsubscription_increment_id = String(format: "%@", dictemp.value(forKey: "subscription_increment_id")as? String ?? "")
                            
                            self.strSubscriptionincreamentalId = strsubscription_increment_id
                            
                            //CHECKING
                            if self.strselectedpaymentmethodID.containsIgnoreCase("ngeniusonline")
                            {
                                var fltTotal = 0.00
                                let fltamount1  = (self.strsubtotalamount as NSString).floatValue
                                let fltamount2  = (self.strshippingchargesamount as NSString).floatValue
                                fltTotal = Double(fltamount1 + fltamount2)
                                
                                let orderCreationViewController = CreateOrderViewController(paymentAmount: fltTotal, refNumber: refNumber ?? "", and: self)
                                orderCreationViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
                                orderCreationViewController.modalPresentationStyle = .overCurrentContext
                                orderCreationViewController.cardPaymentCtrl = self
                                self.present(orderCreationViewController, animated: false, completion: nil)

                            }
                            else if self.strselectedpaymentmethodID.containsIgnoreCase("walletsystem") || self.strselectedpaymentmethodID.containsIgnoreCase("walletpayment")
                            {
                                print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
                                self.postPlaceOrder(strpaymentmethodcode: self.strselectedpaymentmethodID)
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
    
    
    //MARK: - post Place Order API -- WALLET -- method
    func postPlaceOrder(strpaymentmethodcode:String)
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
                            
                            if self.strpageidentifier == "100"
                            {
                                //DAILY LOCAL DB DELETED
                                self.removeLOcalDBDAILY()
                            }
                            else if self.strpageidentifier == "200"
                            {
                                //WEEKLY LOCAL DB DELETED
                                self.removeLOcalDBWEEKLY()
                            }
                            else if self.strpageidentifier == "300"
                            {
                                //MONTHLY LOCAL DB DELETED
                                self.removeLOcalDBMONTHLY()
                            }
                            
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
    
    //MARK: - post Place Order API -- CREDIT CARD -- method
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
                            
                            if self.strpageidentifier == "100"
                            {
                                //DAILY LOCAL DB DELETED
                                self.removeLOcalDBDAILY()
                            }
                            else if self.strpageidentifier == "200"
                            {
                                //WEEKLY LOCAL DB DELETED
                                self.removeLOcalDBWEEKLY()
                            }
                            else if self.strpageidentifier == "300"
                            {
                                //MONTHLY LOCAL DB DELETED
                                self.removeLOcalDBMONTHLY()
                            }
                            
                            let strorderIncrementId = dictemp.value(forKey: "orderIncrementId")as? String ?? ""
                            
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
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(status == .PaymentSuccess)
        {
            print("Success")
            
            print("CardReference >> ",CardReference)
            print("CardOutletId >>",CardOutletId)
            print("self.strSubscriptionincreamentalId >>",self.strSubscriptionincreamentalId)
            
            print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
            self.postPlaceOrder(strpaymentmethodcode: self.strselectedpaymentmethodID,strorderefernce: CardReference,stroutletid: CardOutletId,strorderincreamentalid: self.strSubscriptionincreamentalId)
            
            /*print("authCode",authCode)
            if authCode.count == 0
            {
                //checkOrderStatus()
            }
            else
            {
                //PaymentStatus()
                
                print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
                self.postPlaceOrder(strpaymentmethodcode: self.strselectedpaymentmethodID)
            }*/
        }
        else if(status == .PaymentFailed)
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language348") , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
            }))
        }
        else if(status == .PaymentCancelled)
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language349") , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
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
    
    //MARK: - DELETE  LOCAL DATABASE METHOD  DAILY / WEEKLY / MONTHLY
    func removeLOcalDBDAILY()
    {
        //Remove Subscriptionmodel table data
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData1.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"1")
        let objects1 = try! manageContent1.fetch(fetchData1)
        for obj in objects1 {
            manageContent1.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent1.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Dailymodel table data
        guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent2 = appDelegate2.persistentContainer.viewContext
        let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
        fetchData2.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"1")
        let objects2 = try! manageContent2.fetch(fetchData2)
        for obj in objects2 {
            manageContent2.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent2.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Dailyproduct table data
        guard let appDelegate3 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent3 = appDelegate3.persistentContainer.viewContext
        let fetchData3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
        let objects3 = try! manageContent3.fetch(fetchData3)
        for obj in objects3 {
            manageContent3.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent3.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    func removeLOcalDBWEEKLY()
    {
        //Remove Subscriptionmodel table data
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData1.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"2")
        let objects1 = try! manageContent1.fetch(fetchData1)
        for obj in objects1 {
            manageContent1.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent1.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Weeklymodel table data
        guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent2 = appDelegate2.persistentContainer.viewContext
        let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
        fetchData2.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"2")
        let objects2 = try! manageContent2.fetch(fetchData2)
        for obj in objects2 {
            manageContent2.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent2.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Weeklyproduct table data
        guard let appDelegate3 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent3 = appDelegate3.persistentContainer.viewContext
        let fetchData3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
        let objects3 = try! manageContent3.fetch(fetchData3)
        for obj in objects3 {
            manageContent3.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent3.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
    func removeLOcalDBMONTHLY()
    {
        //Remove Subscriptionmodel table data
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData1.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
        let objects1 = try! manageContent1.fetch(fetchData1)
        for obj in objects1 {
            manageContent1.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent1.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Monthlymodel table data
        guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent2 = appDelegate2.persistentContainer.viewContext
        let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
        fetchData2.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
        let objects2 = try! manageContent2.fetch(fetchData2)
        for obj in objects2 {
            manageContent2.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent2.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Monthlyproduct table data
        guard let appDelegate3 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent3 = appDelegate3.persistentContainer.viewContext
        let fetchData3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
        let objects3 = try! manageContent3.fetch(fetchData3)
        for obj in objects3 {
            manageContent3.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent3.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
    }
}
extension Date {
 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
