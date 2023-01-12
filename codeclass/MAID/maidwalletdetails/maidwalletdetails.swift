//
//  maidwalletdetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 29/11/22.
//

import UIKit

class maidwalletdetails: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblwalletbalance: UILabel!
    @IBOutlet weak var lblwalletbalancevalue: UILabel!
    
    @IBOutlet weak var lblrecentpayments: UILabel!
    @IBOutlet weak var tabvmyrecharges: UITableView!
    var reuseIdentifier1 = "cellwallettransaction"
    var msg = ""
    
    
    @IBOutlet var viewtransactiondetails: UIView!
    @IBOutlet weak var lbltransactiondetailsheader: UILabel!
    @IBOutlet weak var btncrosstransactiondetails: UIButton!
    @IBOutlet weak var lblTDamount: UILabel!
    @IBOutlet weak var lblTDamountvalue: UILabel!
    @IBOutlet weak var lblTDaction: UILabel!
    @IBOutlet weak var lblTDactionvalue: UILabel!
    @IBOutlet weak var lblTDtype: UILabel!
    @IBOutlet weak var lblTDtypevalue: UILabel!
    @IBOutlet weak var lblTDrefrence: UILabel!
    @IBOutlet weak var lblTDrefrencevalue: UILabel!
    @IBOutlet weak var lblTDtransactionat: UILabel!
    @IBOutlet weak var lblTDtransactionatvalue: UILabel!
    @IBOutlet weak var lblTDtransactionnote: UILabel!
    @IBOutlet weak var lblTDtransactionnotevalue: UILabel!
    @IBOutlet weak var lblTDtransactionstatus: UILabel!
    @IBOutlet weak var lblTDtransactionstatusvalue: UILabel!
    var viewPopupAddNewExistingBG1 = UIView()
    
    var arrMalltransactions = NSMutableArray()
    
    var strRemaningAmount = ""
    var strRemaningAmountCurrency = ""

    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
       
        getwallettransactionlist()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language215")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvmyrecharges.register(UINib(nibName: "cellwallettransaction", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyrecharges.separatorStyle = .none
        tabvmyrecharges.backgroundView=nil
        tabvmyrecharges.backgroundColor=UIColor.clear
        tabvmyrecharges.separatorColor=UIColor.clear
        tabvmyrecharges.showsVerticalScrollIndicator = false
      
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrMalltransactions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellwallettransaction
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let dict = arrMalltransactions.object(at: indexPath.section)as? NSDictionary
        let strorder_id = String(format: "%@", dict?.value(forKey: "order_id")as! CVarArg)
        let strtransaction_at = String(format: "%@", dict?.value(forKey: "transaction_at")as? String ?? "")
        
        let strcurrent_amount = String(format: "%@", dict?.value(forKey: "current_amount")as? String ?? "")
        let strcurrence_code = String(format: "%@", dict?.value(forKey: "currence_code")as? String ?? "")
        
        let straction = String(format: "%@", dict?.value(forKey: "action")as? String ?? "")
        
        let fltamount1  = (strcurrent_amount as NSString).floatValue
        
        let str = convertDateFormatter(date: strtransaction_at)
        //print("str", str)
        
        cell.lblorderno.text = String(format: "%@ #%@", myAppDelegate.changeLanguage(key: "msg_language308"),strorder_id)
        cell.lblorderplacedon.text = String(format: "%@ %@", myAppDelegate.changeLanguage(key: "msg_language309"),str)
        cell.lblorderamount.text = String(format: "%@ %0.2f", strcurrence_code,fltamount1)
        cell.lblorderstatus.text = String(format: "%@", straction)
        
        if straction.containsIgnoreCase("debit"){
            cell.lblorderstatus.textColor = UIColor(named: "darkgreencolor")!
        }else{
            cell.lblorderstatus.textColor = UIColor(named: "darkmostredcolor")!
        }
        
        
        cell.viewcell.backgroundColor = UIColor.white
        cell.viewcell.layer.masksToBounds = false
        cell.viewcell.layer.cornerRadius = 6.0
        cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.borderWidth = 1.0
        cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.viewcell.layer.shadowOpacity = 1.0
        cell.viewcell.layer.shadowRadius = 6.0
        
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dict = arrMalltransactions.object(at: indexPath.section)as? NSDictionary
        let strentity_id = String(format: "%@", dict?.value(forKey: "entity_id")as! CVarArg)
        
        self.getwallettransactiondetails(strentity_id: strentity_id)
    }
    
    //MARK: - create popup Transaction Details Method
    func createTransactionDetailsPopup(strlblTDamountvalue:String,strlblTDactionvalue:String,strlblTDtypevalue:String,
                                       strlblTDrefrencevalue:String,strlblTDtransactionatvalue:String,strlblTDtransactionnotevalue:String,strlblTDtransactionstatusvalue:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if self.viewtransactiondetails != nil{
            self.viewtransactiondetails.removeFromSuperview()
            viewPopupAddNewExistingBG1.removeFromSuperview()
        }
        
        
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewtransactiondetails.layer.cornerRadius = 6.0
        self.viewtransactiondetails.layer.masksToBounds = true
        
        lblTDamountvalue.text = strlblTDamountvalue
        lblTDactionvalue.text = strlblTDactionvalue
        lblTDtypevalue.text = strlblTDtypevalue
        lblTDrefrencevalue.text = strlblTDrefrencevalue
        lblTDtransactionatvalue.text = strlblTDtransactionatvalue
        lblTDtransactionnotevalue.text = strlblTDtransactionnotevalue
        lblTDtransactionstatusvalue.text = strlblTDtransactionstatusvalue
    
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            self.btncrosstransactiondetails.frame = CGRect(x: self.viewtransactiondetails.frame.size.width - self.btncrosstransactiondetails.frame.size.width - 10, y: self.btncrosstransactiondetails.frame.origin.y, width: self.btncrosstransactiondetails.frame.size.width, height: self.btncrosstransactiondetails.frame.size.height)
        }
        else
        {
            self.btncrosstransactiondetails.frame = CGRect(x: 15, y: self.btncrosstransactiondetails.frame.origin.y, width: self.btncrosstransactiondetails.frame.size.width, height: self.btncrosstransactiondetails.frame.size.height)
        }
        
        viewPopupAddNewExistingBG1 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG1.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG1.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG1.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG1.addSubview(self.viewtransactiondetails)
        self.viewtransactiondetails.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG1)
    }
    @IBAction func pressCrosstransactiondetails(_ sender: Any)
    {
        self.viewtransactiondetails.removeFromSuperview()
        viewPopupAddNewExistingBG1.removeFromSuperview()
    }
    
    //MARK: - get wallet transaction list API method
    func getwallettransactionlist()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod37)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        print("strconnurl",strconnurl)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
                    self.getwalletremainingbalancelist()
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
                            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
                            
                            if self.arrMalltransactions.count > 0{
                                self.arrMalltransactions.removeAllObjects()
                            }
                            
                            let arrm = dictemp.value(forKey: "wallet_detail") as? NSArray ?? []
                            self.arrMalltransactions = NSMutableArray(array: arrm)
                            //print("arrMalltransactions --->",self.arrMalltransactions)
                            
                            if self.arrMalltransactions.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language216")
                            }
                            
                            self.tabvmyrecharges.reloadData()
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getwalletremainingbalancelist()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    
                    self.getwalletremainingbalancelist()
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
                        
                        if strstatus == 200
                        {
                            let strwallet_remaining_amount = dictemp.value(forKey: "wallet_remaining_amount")as? String ?? ""
                            let strcurrency = dictemp.value(forKey: "currency")as? String ?? ""
                            
                            let fltamount1  = (strwallet_remaining_amount as NSString).floatValue
                            
                            self.lblwalletbalancevalue.text = String(format: "%@ %0.2f", strcurrency,fltamount1)
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
    
    
    //MARK: - get wallet transaction detail API method
    func getwallettransactiondetails(strentity_id:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?entity_id=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod88,strentity_id)
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
                            let dicdetails = dictemp.value(forKey: "transaction_detail")as? NSDictionary
                            let stramount = dicdetails!.value(forKey: "amount")as? String ?? ""
                            let straction = dicdetails!.value(forKey: "action")as? String ?? ""
                            let strtype = dicdetails!.value(forKey: "type")as? String ?? ""
                            let strtransactio_at = dicdetails!.value(forKey: "transactio_at")as? String ?? ""
                            let strtransaction_note = dicdetails!.value(forKey: "transaction_note")as? String ?? ""
                            let strreference = dicdetails!.value(forKey: "reference")as? String ?? ""
                            let strtransaction_status = dicdetails!.value(forKey: "transaction_status")as? String ?? ""
                            
                            self.createTransactionDetailsPopup(strlblTDamountvalue: stramount, strlblTDactionvalue: straction, strlblTDtypevalue: strtype, strlblTDrefrencevalue: strreference, strlblTDtransactionatvalue: strtransactio_at, strlblTDtransactionnotevalue: strtransaction_note, strlblTDtransactionstatusvalue: strtransaction_status)
                            
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

    //MARK: - date formatter method
    public func convertDateFormatter(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        print(timeStamp)
        return timeStamp
    }
}
