//
//  maidpaymentmethod.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 12/12/22.
//

import UIKit

class maidpaymentmethod: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
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
    
    @IBOutlet weak var lblwallet1: UILabel!
    @IBOutlet weak var lblwallet2: UILabel!
    @IBOutlet weak var lblwallet3: UILabel!
    
    
    
    var arrMpaymentmethodlist = NSMutableArray()
    var strselectedpaymentmethodID = ""
    
    var strsubtotal = ""
    var strshipping = ""
    var strgrandtotal = ""
    var strcurrency = ""
    
    var strcurrencywallet = ""
    var strwalletremainingbalance = ""
   
    
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language185")
        
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        lblCardPaymentOrderAmount.text = myAppDelegate.changeLanguage(key: "msg_language312")
        txtCardPaymentOrderAmount.placeholder = myAppDelegate.changeLanguage(key: "msg_language313")
        btnpayment.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        
        lblwallet1.text = myAppDelegate.changeLanguage(key: "msg_language314")
        lblwallet2.text = myAppDelegate.changeLanguage(key: "msg_language312")
        lblwallet3.text = myAppDelegate.changeLanguage(key: "msg_language315")
        
        txtwalletbalance.placeholder = myAppDelegate.changeLanguage(key: "msg_language314")
        txtpaymentamount.placeholder = myAppDelegate.changeLanguage(key: "msg_language312")
        txtremainingbalance.placeholder = myAppDelegate.changeLanguage(key: "msg_language315")
        btnpaymentwallet.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        
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
        
        self.viewbottom.isHidden = true
        self.viewbottom1.isHidden = true
        
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
    
    //MARK: - press payment method
    @IBAction func presspayment(_ sender: Any)
    {
        if btnpayment.tag == 100 {
            //CARD
            
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
        layout.itemSize = CGSize(width: colpaymentmethods.frame.size.width / 3 - 10, height: 115)
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
            cellA.imgvicon.image = UIImage(named: "wallet")
        }
        else if strcode.containsIgnoreCase("cashondelivery")
        {
            cellA.imgvicon.image = UIImage(named: "cash")
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
                    
                    self.strselectedpaymentmethodID = strcode
                    self.colpaymentmethods.reloadData()
                    strpreviouslyselectedcode = ""
                    
                    if strcode.containsIgnoreCase("ngeniusonline")
                    {
                        //self.viewbottom.isHidden = false
                        //self.viewbottom1.isHidden = true
                        
                        //let fltTotal  = (self.strgrandtotal as NSString).floatValue
                        //self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
                        
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
                    
                }))
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                    
                    self.strselectedpaymentmethodID = strpreviouslyselectedcode
                    self.colpaymentmethods.reloadData()
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
        }
        else
        {
            //ALREADY NO PRE SELECTED PAYMENT METHOD
            
            if strcode.containsIgnoreCase("ngeniusonline")
            {
                //self.viewbottom.isHidden = false
                //self.viewbottom1.isHidden = true
                
                //let fltTotal  = (self.strgrandtotal as NSString).floatValue
                //self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
                
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
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod41,strLangCode)
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
                            let cartid = String(format: "%@", dictemp.value(forKey: "cart_id")as? String ?? "")
                            let arrcartitem = dictemp.value(forKey: "cart_items")as? NSArray ?? []
                            
                            print("cartid",cartid)
                            print("arrcartitem",arrcartitem)
                            
                            if arrcartitem.count == 0
                            {
                                //CART ALREADY EMPTY - BACK TO ORDER ONCE CART PAGE
                                
                                let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language448") , preferredStyle: UIAlertController.Style.alert)
                                self.present(uiAlert, animated: true, completion: nil)
                                uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                    print("Click of default button")
                                    self.poptoBackPageforCartEmpty()
                                }))
                            }
                            else
                            {
                                //CART NOT EMPTY
                                
                                
                                
                                let strsubtotal1 = String(format: "%@", dictemp.value(forKey: "subtotal")as? String ?? "0.00")
                                let strshippingAmount = String(format: "%@", dictemp.value(forKey: "shippingAmount")as? String ?? "0.00")
                                let strgrandtotal = String(format: "%@", dictemp.value(forKey: "grandtotal")as? String ?? "0.00")
                                var strcurrency_code = String(format: "%@", dictemp.value(forKey: "currency_code")as? String ?? "")
                                
                                let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                                strcurrency_code = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
                                
                                self.strsubtotal = strsubtotal1
                                self.strshipping = strshippingAmount
                                self.strgrandtotal = strgrandtotal
                                self.strcurrency = strcurrency_code
                                print("self.strsubtotal",self.strsubtotal)
                                print("self.strshipping",self.strshipping)
                                print("self.strgrandtotal",self.strgrandtotal)
                                print("self.strcurrency",self.strcurrency)
                            }
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                self.poptoBackPageforCartEmpty()
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
                    self.poptoBackPageforCartEmpty()
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
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["ordertype": "other"] as [String : Any]
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
                            if self.arrMpaymentmethodlist.count > 0{
                                self.arrMpaymentmethodlist.removeAllObjects()
                            }
                            
                            let arrmaddress = dictemp.value(forKey: "payment_methods") as? NSArray ?? []
                            let aarrm1 = NSMutableArray(array: arrmaddress)
                            print("aarrm1",aarrm1.count)
                            
                            self.arrMpaymentmethodlist = NSMutableArray(array: aarrm1)
                            print("arrMpaymentmethodlist --->",self.arrMpaymentmethodlist)
                            
                            if self.arrMpaymentmethodlist.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language320")
                            }
                            
                            let dictemp = self.arrMpaymentmethodlist.object(at: 0)as? NSDictionary
                            let strcode = String(format: "%@", dictemp?.value(forKey: "code")as! CVarArg)
                            let strtitle = String(format: "%@", dictemp?.value(forKey: "title")as? String ?? "")
                            self.strselectedpaymentmethodID = strcode
                            
                            if strcode.containsIgnoreCase("ngeniusonline")
                            {
                                //self.viewbottom.isHidden = false
                                //self.viewbottom1.isHidden = true
                                
                                //let fltTotal  = (self.strgrandtotal as NSString).floatValue
                                //self.txtCardPaymentOrderAmount.text = String(format: "%@ %0.2f",self.strcurrency,fltTotal)
                                
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
                            
                            self.colpaymentmethods.reloadData()
                            
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

    
    //MARK: - get wallet remaning balance API method
    func getwalletremainingbalancelist()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
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
                            let strwallet_remaining_amount = dictemp.value(forKey: "wallet_remaining_amount")as? String ?? ""
                            let strcurrency = dictemp.value(forKey: "currency")as? String ?? ""
                            
                            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            self.strcurrencywallet = myAppDelegate.changeLanguage(key: "msg_language481")
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
    
    //MARK: - post Place Order API method
    func postPlaceOrder(strpaymentmethodcode:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["paymentMethod": strpaymentmethodcode] as [String : Any]
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        let strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod86,strLangCode)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "PUT"
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
                            let strorderIncrementId = String(format: "%@", dictemp.value(forKey: "orderIncrementId")as! CVarArg)
                            
                            let ctrl = maidordersuccess(nibName: "maidordersuccess", bundle: nil)
                            ctrl.strorderid = strorderIncrementId
                            self.navigationController?.pushViewController(ctrl, animated: true)
                        }
                        else{
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
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    //MARK: - POP to BACK PAGE fro CART EMPTY SCENARIO
    func poptoBackPageforCartEmpty()
    {
        guard let vc = self.navigationController?.viewControllers else { return }
        for controller in vc {
            if controller.isKind(of: maidhomeclass.self) {
                let tabVC = controller as! maidhomeclass
                self.navigationController?.popToViewController(tabVC, animated: true)
            }
            else if controller.isKind(of: maidproductdetails.self) {
                let tabVC = controller as! maidproductdetails
                self.navigationController?.popToViewController(tabVC, animated: true)
            }
            /*else if controller.isKind(of: maidcartlist.self) {
                let tabVC = controller as! maidcartlist
                self.navigationController?.popToViewController(tabVC, animated: true)
            }
            else if controller.isKind(of: maidmenuclass.self) {
                let tabVC = controller as! maidmenuclass
                self.navigationController?.popToViewController(tabVC, animated: true)
            }
            else if controller.isKind(of: maidsearchproductlist.self) {
                let tabVC = controller as! maidsearchproductlist
                self.navigationController?.popToViewController(tabVC, animated: true)
            }*/
        }
    }

}
