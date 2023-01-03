//
//  paymentmethod.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/07/22.
//

import UIKit
import PassKit
import SwiftyJSON
import NISdk


class paymentmethod: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,CardPaymentDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var colpaymentmethods: UICollectionView!
    var reuseIdentifier1 = "colcellmethods"
    var msg = ""
    
    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var viewnamecard: UIView!
    @IBOutlet weak var txtnamecard: UITextField!
    @IBOutlet weak var viewcardno: UIView!
    @IBOutlet weak var txtcardno: UITextField!
    @IBOutlet weak var viewmonthyear: UIView!
    @IBOutlet weak var txtmonthyear: UITextField!
    @IBOutlet weak var viewcv: UIView!
    @IBOutlet weak var txtcvv: UITextField!
    @IBOutlet weak var lblCardPaymentOrderAmount: UILabel!
    @IBOutlet weak var txtCardPaymentOrderAmount: UITextField!
    @IBOutlet weak var btnpayment: UIButton!
    
    @IBOutlet weak var viewbottom1: UIView!
    @IBOutlet weak var txtwalletbalance: UITextField!
    @IBOutlet weak var txtpaymentamount: UITextField!
    @IBOutlet weak var txtremainingbalance: UITextField!
    @IBOutlet weak var btnpaymentwallet: UIButton!
    @IBOutlet weak var btnrechargewallet: UIButton!
    
    @IBOutlet weak var viewrewardpoints: UIView!
    @IBOutlet weak var lblrewardpoints: UILabel!
    @IBOutlet weak var txtrewardpoints: UITextField!
    @IBOutlet weak var lblmaximumrewardpointsused: UILabel!
    @IBOutlet weak var btnapplyrewardpoints: UIButton!
    
    
    var arrMpaymentmethodlist = NSMutableArray()
    var strselectedpaymentmethodID = ""
    
    var strsubtotal = ""
    var strshipping = ""
    var strgrandtotal = ""
    var strcurrency = ""
    
    
    var strcurrencywallet = ""
    var strwalletremainingbalance = ""
    
    var authCode = ""
    var CardReference = ""
    var CardOutletId = ""
    var refNumber:String?
    
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
        
        self.getOrderReview()

    }
    
    // MARK: - viewDidLoad Method
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
        
        btnpaymentwallet.layer.cornerRadius = 18.0
        btnpaymentwallet.layer.masksToBounds = true
        
        btnrechargewallet.layer.cornerRadius = 14.0
        btnrechargewallet.layer.masksToBounds = true
        
        
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
        
        viewbottom.layer.borderWidth = 1.0
        viewbottom.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewbottom.layer.cornerRadius = 6.0
        viewbottom.layer.masksToBounds = true
        
        viewbottom1.layer.borderWidth = 1.0
        viewbottom1.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewbottom1.layer.cornerRadius = 6.0
        viewbottom1.layer.masksToBounds = true
        
        viewrewardpoints.layer.borderWidth = 0.0
        viewrewardpoints.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewrewardpoints.layer.cornerRadius = 0.0
        viewrewardpoints.layer.masksToBounds = true
        
        btnapplyrewardpoints.layer.cornerRadius = 18.0
        btnapplyrewardpoints.layer.masksToBounds = true
        
        self.viewbottom.isHidden = true
        self.viewbottom1.isHidden = true
        self.viewrewardpoints.isHidden = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDoneRewardPoints))
        toolbarDone.items = [barBtnDone]
        txtrewardpoints.inputAccessoryView = toolbarDone
        
        createmethodsview()
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Reward Points Apply Method
    @objc func pressDoneRewardPoints(sender:UIButton)
    {
        self.txtrewardpoints.resignFirstResponder()
    }
    @IBAction func pressapplyrewardpoints(_ sender: Any)
    {
        if self.txtrewardpoints.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your reward points to be spend", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            self.postApplyRewardPointsOrderOnceAPI()
        }
    }
    
    //MARK: - press payment method
    @IBAction func presspayment(_ sender: Any)
    {
        if btnpayment.tag == 100 {
            //CARD
            print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
            
            let dblTotal  = (self.strgrandtotal as NSString).doubleValue
            print("dblTotal",dblTotal)
            
            let orderCreationViewController = CreateOrderViewControllerOO(paymentAmount: dblTotal, refNumber: refNumber ?? "", and: self)
            orderCreationViewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            orderCreationViewController.modalPresentationStyle = .overCurrentContext
            orderCreationViewController.cardPaymentCtrl = self
            self.present(orderCreationViewController, animated: false, completion: nil)
        }
        else if btnpayment.tag == 200 {
            //COD
            print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
            self.postPlaceOrder(strpaymentmethodcode: self.strselectedpaymentmethodID)
        }
        else{
            print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
        }
    }
    
    //MARK: - press Recharge Wallet method
    @IBAction func pressrechargewallet(_ sender: Any)
    {
        let ctrl = rechargewallet(nibName: "rechargewallet", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press payment Wallet method
    @IBAction func presspaymentwallet(_ sender: Any)
    {
        print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
        self.postPlaceOrder(strpaymentmethodcode: self.strselectedpaymentmethodID)
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
        else if strcode.containsIgnoreCase("walletpayment") || strcode.containsIgnoreCase("walletsystem")
        {
            cellA.imgvicon.image = UIImage(named: "wallet.png")
        }
        else if strcode.containsIgnoreCase("cashondelivery")
        {
            cellA.imgvicon.image = UIImage(named: "cash.png")
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
        let dictemp = arrMpaymentmethodlist.object(at: indexPath.row)as? NSDictionary
        let strcode = String(format: "%@", dictemp?.value(forKey: "code")as! CVarArg)
        let strtitle = String(format: "%@", dictemp?.value(forKey: "title")as? String ?? "")
        
        self.strselectedpaymentmethodID = strcode
        self.colpaymentmethods.reloadData()
        
        if strcode.containsIgnoreCase("ngeniusonline")
        {
            self.viewbottom.isHidden = false
            self.viewbottom1.isHidden = true
            
            let fltTotal  = (self.strgrandtotal as NSString).floatValue
           
            self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
            
            self.btnpayment.tag = 100
        }
        else if strcode.containsIgnoreCase("walletpayment") || strcode.containsIgnoreCase("walletsystem")
        {
            self.viewbottom.isHidden = true
            self.viewbottom1.isHidden = false
            
            self.getwalletremainingbalancelist()
        }
        else if strcode.containsIgnoreCase("cashondelivery")
        {
            self.viewbottom.isHidden = false
            self.viewbottom1.isHidden = true
            
            let fltTotal  = (self.strgrandtotal as NSString).floatValue
           
            self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
            
            self.btnpayment.tag = 200
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //print("Called when the cell is displayed   %ld",indexPath.row)
    }
    
    
    //MARK: - get Order Review API method
    func getOrderReview()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod41)
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
                    self.getorderoncepaymentmethodlist()
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
                   
                     let strsuccess = dictemp.value(forKey: "success")as? Bool ?? false
                     let strmessage = dictemp.value(forKey: "message")as? String ?? ""
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let strsubtotal1 = String(format: "%@", dictemp.value(forKey: "subtotal")as? String ?? "0.00")
                            let strshippingAmount = String(format: "%@", dictemp.value(forKey: "shippingAmount")as? String ?? "0.00")
                            let strgrandtotal = String(format: "%@", dictemp.value(forKey: "grandtotal")as? String ?? "0.00")
                            let strcurrency_code = String(format: "%@", dictemp.value(forKey: "currency_code")as? String ?? "")
                            
                            self.strsubtotal = strsubtotal1
                            self.strshipping = strshippingAmount
                            self.strgrandtotal = strgrandtotal
                            self.strcurrency = strcurrency_code
                            print("self.strsubtotal",self.strsubtotal)
                            print("self.strshipping",self.strshipping)
                            print("self.strgrandtotal",self.strgrandtotal)
                            print("self.strcurrency",self.strcurrency)
                            
                            
                            let stravailable_points = String(format: "%@", dictemp.value(forKey: "available_points")as! CVarArg)
                            let strspend_max_points = String(format: "%@", dictemp.value(forKey: "spend_max_points")as! CVarArg)
                            let strspend_min_points = String(format: "%@", dictemp.value(forKey: "spend_min_points")as! CVarArg)
                            
                            if stravailable_points == "0" || stravailable_points == "0.0"
                            {
                                //YOU CAN NOT APPLY REWARD POINT
                                self.lblmaximumrewardpointsused.text = "You can not use reward points now."
                                self.lblmaximumrewardpointsused.textColor = UIColor(named: "darkmostredcolor")!
                            }
                            else
                            {
                                //YOU CAN APPLY
                                self.lblmaximumrewardpointsused.text = String(format: "You can use minimum %@ & maximum %@ points", strspend_min_points,strspend_max_points)
                                self.lblmaximumrewardpointsused.textColor = UIColor(named: "darkgreencolor")!
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        self.getorderoncepaymentmethodlist()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.getorderoncepaymentmethodlist()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - get All Payment Method list API method
    func getorderoncepaymentmethodlist()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["ordertype": "other"] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod40)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                                self.msg = "No payment methods found!"
                            }
                            
                            let dictemp = self.arrMpaymentmethodlist.object(at: 0)as? NSDictionary
                            let strcode = String(format: "%@", dictemp?.value(forKey: "code")as! CVarArg)
                            let strtitle = String(format: "%@", dictemp?.value(forKey: "title")as? String ?? "")
                            self.strselectedpaymentmethodID = strcode
                            
                            if strcode.containsIgnoreCase("ngeniusonline")
                            {
                                self.viewbottom.isHidden = false
                                self.viewbottom1.isHidden = true
                                
                                let fltTotal  = (self.strgrandtotal as NSString).floatValue
                               
                                self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
                                
                                self.btnpayment.tag = 100
                            }
                            else if strcode.containsIgnoreCase("walletpayment") || strcode.containsIgnoreCase("walletsystem")
                            {
                                self.viewbottom.isHidden = true
                                self.viewbottom1.isHidden = false
                                
                                self.getwalletremainingbalancelist()
                            }
                            else{
                                self.viewbottom.isHidden = false
                                self.viewbottom1.isHidden = true
                                
                                let fltTotal  = (self.strgrandtotal as NSString).floatValue
                               
                                self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
                                
                                self.btnpayment.tag = 200
                            }
                            
                            self.viewrewardpoints.isHidden = false
                            
                            self.colpaymentmethods.reloadData()
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                            print("strpoints",strpoints)
                            self.lblrewardpoints.text = String(format: "You have %@ reward points available.", strpoints)
                            
                            if strpoints == "0" || strpoints == "0.0"
                            {
                                //YOU CANT APPLY REWARD POINT
                                self.txtrewardpoints.isUserInteractionEnabled = false
                                self.btnapplyrewardpoints.isUserInteractionEnabled = false
                                
                            }
                            else
                            {
                                //YOU CAN APPLY
                                self.txtrewardpoints.isUserInteractionEnabled = true
                                self.btnapplyrewardpoints.isUserInteractionEnabled = true
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                        
                        if strsuccess == true
                        {
                            let strwallet_remaining_amount = dictemp.value(forKey: "wallet_remaining_amount")as? String ?? ""
                            let strcurrency = dictemp.value(forKey: "currency")as? String ?? ""
                            self.strcurrencywallet = strcurrency
                            self.strwalletremainingbalance = strwallet_remaining_amount
                            
                            let fltamount3  = (self.strwalletremainingbalance as NSString).floatValue
                            print("fltamount3",fltamount3)
                            
                            let fltTotal  = (self.strgrandtotal as NSString).floatValue
                            print("fltTotal",fltTotal)
                            
                            if fltamount3 == 0.00
                            {
                                //Wallet balance zero, Recharge Your Wallet First
                                
                                self.txtwalletbalance.text = String(format: "%@ %0.2f",self.strcurrencywallet,fltamount3)
                                self.txtpaymentamount.text = String(format: "%@ %0.2f",self.strcurrencywallet,fltTotal)
                                
                                self.btnpaymentwallet.isUserInteractionEnabled = false
                                self.btnpaymentwallet.setTitleColor(.black, for: .normal)
                                self.btnpaymentwallet.backgroundColor = UIColor(named: "graybordercolor")!
                            }
                            else if fltamount3 < fltTotal
                            {
                                //Wallet balance low from Grand total
                                
                                self.txtwalletbalance.text = String(format: "%@ %0.2f",self.strcurrencywallet,fltamount3)
                                self.txtpaymentamount.text = String(format: "%@ %0.2f",self.strcurrencywallet,fltTotal)
                                
                                self.btnpaymentwallet.isUserInteractionEnabled = false
                                self.btnpaymentwallet.setTitleColor(.black, for: .normal)
                                self.btnpaymentwallet.backgroundColor = UIColor(named: "graybordercolor")!
                            }
                            else
                            {
                                //Wallet Balance is sufficient to place order
                                
                                self.btnpaymentwallet.isUserInteractionEnabled = true
                                self.btnpaymentwallet.setTitleColor(.white, for: .normal)
                                self.btnpaymentwallet.backgroundColor = UIColor(named: "greencolor")!
                                
                                var fltremainingbalance = 0.00
                                fltremainingbalance = Double(fltamount3) - Double(fltTotal)
                                
                                self.txtwalletbalance.text = String(format: "%@ %0.2f",self.strcurrencywallet,fltamount3)
                                self.txtpaymentamount.text = String(format: "%@ %0.2f",self.strcurrencywallet,fltTotal)
                                self.txtremainingbalance.text = String(format: "%@ %0.2f",self.strcurrencywallet,fltremainingbalance)
                            }
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
    
    //MARK: - post Apply Reward Points Order Once API method
    func postApplyRewardPointsOrderOnceAPI()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["pointsAmount": self.txtrewardpoints.text!] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod101)
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
                    let strapply = dictemp.value(forKey: "apply")as? Bool ?? false
                    
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    print("strapply",strapply)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.txtrewardpoints.backgroundColor = UIColor(named: "greenlighter")!
                            self.txtrewardpoints.isUserInteractionEnabled = false
                            
                            self.btnapplyrewardpoints.isUserInteractionEnabled = false
                            self.btnapplyrewardpoints.setTitle("Applied Successfully", for: .normal)
                            
                            self.getOrderReview()
                        }
                        else
                        {
                            self.txtrewardpoints.isUserInteractionEnabled = true
                            self.btnapplyrewardpoints.isUserInteractionEnabled = true
                            
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
    
    //MARK: - post Place Order API method
    func postPlaceOrder(strpaymentmethodcode:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["paymentMethod": strpaymentmethodcode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod42)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                            
                            let ctrl = ordersuccess(nibName: "ordersuccess", bundle: nil)
                            ctrl.strorderid = strorderIncrementId
                            self.navigationController?.pushViewController(ctrl, animated: true)
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
        
        if(status == .PaymentSuccess)
        {
            print("Success")
            
            print("CardReference >> ",CardReference)
            print("CardOutletId >>",CardOutletId)
            
            print("self.strselectedpaymentmethodID",self.strselectedpaymentmethodID)
            self.postPlaceOrder(strpaymentmethodcode: self.strselectedpaymentmethodID)
            
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
            let uiAlert = UIAlertController(title: "", message: "Payment failed" , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.navigationController?.popToRootViewController(animated: true)
            }))
        }
        else if(status == .PaymentCancelled)
        {
            let uiAlert = UIAlertController(title: "", message: "Payment cancelled" , preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
}
