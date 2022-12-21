//
//  maidaccountsdetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class maidaccountsdetails: UIViewController,UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var scrolloverall: UIScrollView!
    
    @IBOutlet weak var viewfirstname: UIView!
    @IBOutlet weak var txtfirstname: UITextField!
    
    @IBOutlet weak var viewlastname: UIView!
    @IBOutlet weak var txtlastname: UITextField!
    
    @IBOutlet weak var viewemail: UIView!
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var viewmobileno: UIView!
    @IBOutlet weak var lblcountrycode: UILabel!
    @IBOutlet weak var txtmobileno: UITextField!
    
    @IBOutlet weak var viewpurchaseamountlimit: UIView!
    @IBOutlet weak var txtpurchaseamountlimit: UITextField!
    
    @IBOutlet weak var lblallowedaddress: UILabel!
    @IBOutlet weak var tabvallowedaddress: UITableView!
    var reuseIdentifier1 = "cellallowedaddress"
    var msg = ""
    
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var segmentstatus: UISegmentedControl!
    
    @IBOutlet weak var btnupdatesave: UIButton!
    @IBOutlet weak var btnremoveaccount: UIButton!
    
    
    var dicdetails = NSDictionary()
    var strcurrency = ""
    
    var strstatus = ""
    
    var arrMmyaddresslist = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        
        self.getcustomeraddresslist()
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        let strrow_id = String(format: "%@", self.dicdetails.value(forKey: "row_id")as? String ?? "")
        let strmaid_id = String(format: "%@", self.dicdetails.value(forKey: "maid_id")as? String ?? "")
        let strname = String(format: "%@", self.dicdetails.value(forKey: "name")as? String ?? "")
        let stremail = String(format: "%@", self.dicdetails.value(forKey: "email")as? String ?? "")
        let strstatus = String(format: "%@", self.dicdetails.value(forKey: "status")as? String ?? "")
        let strmax_order_amount = String(format: "%@", self.dicdetails.value(forKey: "max_order_amount")as? String ?? "")
        
        let strphone_number = String(format: "%@", self.dicdetails.value(forKey: "phone_number")as? String ?? "")
        
        let strallowed_addresses = String(format: "%@", self.dicdetails.value(forKey: "allowed_addresses")as? String ?? "")
        let itemsaddress = strallowed_addresses.components(separatedBy: ",")
        print("itemsaddress",itemsaddress)
        
        let items = strname.components(separatedBy: " ")
        let str1 = items[0]
        let str2 = items[1]
        
        txtfirstname.text = str1
        txtlastname.text = str2
        txtemail.text = stremail
        txtmobileno.text = strphone_number
        txtpurchaseamountlimit.text = String(format: "%@",strmax_order_amount)
        
        if strstatus == "Active"
        {
            //ACTIVE
            segmentstatus.selectedSegmentIndex = 0
            self.strstatus = "1"
        }
        else{
            //INACTIVE
            segmentstatus.selectedSegmentIndex = 1
            self.strstatus = "0"
        }
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Account Details"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .white
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.scrolloverall.frame.size.width, height: self.viewoverall.frame.size.height - 235)
        
        txtfirstname.setLeftPaddingPoints(10)
        txtlastname.setLeftPaddingPoints(10)
        txtemail.setLeftPaddingPoints(10)
        txtpurchaseamountlimit.setLeftPaddingPoints(10)
        
        btnupdatesave.layer.cornerRadius = 16.0
        btnupdatesave.layer.masksToBounds = true
        btnremoveaccount.layer.cornerRadius = 16.0
        btnremoveaccount.layer.masksToBounds = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxtpurchaseamountlimit))
        toolbarDone.items = [barBtnDone]
        txtpurchaseamountlimit.inputAccessoryView = toolbarDone
        
        tabvallowedaddress.register(UINib(nibName: "cellallowedaddress", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvallowedaddress.separatorStyle = .none
        tabvallowedaddress.backgroundView=nil
        tabvallowedaddress.backgroundColor=UIColor.clear
        tabvallowedaddress.separatorColor=UIColor.clear
        tabvallowedaddress.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press segment for ACTIVE or NOACTIVE Method
    @IBAction func pressSegmentstatus(_ sender: Any)
    {
        if segmentstatus.selectedSegmentIndex == 0{
            self.strstatus = "1"
        }
        else{
            self.strstatus = "0"
        }
    }
    
    //MARK: - press Remove account method
    @IBAction func pressRemoveAccount(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "", message: "Do you want to remove this account?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            let strrow_id = String(format: "%@", self.dicdetails.value(forKey: "row_id")as? String ?? "")
            self.removemaidaccountAPIMethod(rowid: strrow_id)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - press Update Save Method
    @IBAction func pressUpdateSave(_ sender: Any)
    {
        
        var straddresslist = ""
        for jj in 0 ..< arrMmyaddresslist.count
        {
            let dictemp = arrMmyaddresslist.object(at: jj)as? NSMutableDictionary
            let strid = String(format: "%@", dictemp!.value(forKey: "id")as! CVarArg)
            let straddress = String(format: "%@", dictemp!.value(forKey: "address")as? String ?? "")
            let strselected = String(format: "%@", dictemp!.value(forKey: "selected")as? String ?? "")
            
            if straddresslist.count == 0
            {
                if strselected == "1"{
                    straddresslist = strid
                }
            }
            else{
                if strselected == "1"{
                    straddresslist = String(format: "%@,%@", straddresslist,strid)
                }
            }
        }
        print("straddresslist",straddresslist)
        
        let fltpurchaselimit = Float(txtpurchaseamountlimit.text!)
        
        if txtfirstname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your first name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlastname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your last name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtpurchaseamountlimit.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter minimum wallet amount limit.", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if fltpurchaselimit! > 200.00 || fltpurchaselimit! <= 0.00
        {
            let uiAlert = UIAlertController(title: "", message: "Maid purchase limit should be above AED 1 & upto AED 200", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if straddresslist.count == 0
        {
            let uiAlert = UIAlertController(title: "", message: "please allow one / multiple addresses for your maid", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            print("update successfull")
            let strrow_id = String(format: "%@", self.dicdetails.value(forKey: "row_id")as? String ?? "")
            self.updatemaidaccountAPIMethod(rowid: strrow_id, status: self.strstatus,straddresslist: straddresslist)
        }
    }
    
    // MARK: - Done Purchase Amount Limit method
    @objc func pressDonetxtpurchaseamountlimit(sender: UIButton)
    {
        txtpurchaseamountlimit.resignFirstResponder()
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
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMmyaddresslist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellallowedaddress
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMmyaddresslist.object(at: indexPath.row)as! NSMutableDictionary
        
        let strid = String(format: "%@", dic.value(forKey: "id")as! CVarArg)
        let straddress = String(format: "%@", dic.value(forKey: "address")as? String ?? "")
        let strselected = String(format: "%@", dic.value(forKey: "selected")as? String ?? "")
        
        if strselected == "1"
        {
            //Selected
            cell.imgvselection.image = UIImage(named: "checkbox")
        }
        else{
            //De-Selected
            cell.imgvselection.image = UIImage(named: "uncheckbox")
        }
        
        cell.lbladdress.text = straddress
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.arrMmyaddresslist.object(at: indexPath.row)as! NSMutableDictionary
        let strid = String(format: "%@", dic.value(forKey: "id")as! CVarArg)
        let straddress = String(format: "%@", dic.value(forKey: "address")as? String ?? "")
        let strselected = String(format: "%@", dic.value(forKey: "selected")as? String ?? "")
        
        if strselected == "1"
        {
            //Selected
            dic.setValue("0", forKey: "selected")
        }
        else{
            //De-Selected
            dic.setValue("1", forKey: "selected")
        }
        self.tabvallowedaddress.reloadData()
    }
    
    
    //MARK: - Update maid account API Method
    func updatemaidaccountAPIMethod(rowid:String,status:String,straddresslist:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["rowid": rowid,
                          "firstname": txtfirstname.text!,
                          "lastname": txtlastname.text!,
                          "email": txtemail.text!,
                          "status": status,
                          "maxorderamount": txtpurchaseamountlimit.text!,
                          "mobilenumber":txtmobileno.text!,
                          "allowedaddress":straddresslist] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod67)
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: "Your maid account has been updated succsefully.", preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                                self.navigationController?.popViewController(animated: true)
                            }))
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - Removew maid account API Method
    func removemaidaccountAPIMethod(rowid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["rowid": rowid] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod70)
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language271") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: "Your maid account has been removed succsefully.", preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                                self.navigationController?.popViewController(animated: true)
                            }))
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
                    
                    let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                    self.present(uiAlert, animated: true, completion: nil)
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        print("Click of default button")
                    }))
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - get Customer address list API method
    func getcustomeraddresslist()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod24)
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
                     print("strstatus",strstatus)
                     print("strsuccess",strsuccess)
                     print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            if self.arrMmyaddresslist.count > 0{
                                self.arrMmyaddresslist.removeAllObjects()
                            }
                            
                            let dicadetails = dictemp.value(forKey: "customerDetails")as! NSDictionary
                            let arrmaddress = dicadetails.value(forKey: "address") as? NSArray ?? []
                            let aarrm1 = NSMutableArray(array: arrmaddress)
                            
                            
                            let strallowed_addresses = String(format: "%@", self.dicdetails.value(forKey: "allowed_addresses")as? String ?? "")
                            let itemsaddress = strallowed_addresses.components(separatedBy: ",")
                            print("itemsaddress",itemsaddress)
                           
                            for jj in 0 ..< aarrm1.count
                            {
                                let dictemp = aarrm1.object(at: jj)as? NSDictionary
                                
                                let strid = String(format: "%@", dictemp!.value(forKey: "address_id")as! CVarArg)
                                let strcity = String(format: "%@", dictemp!.value(forKey: "city")as? String ?? "")
                                let dicregion = dictemp!.value(forKey: "region")as! NSDictionary
                                let strregionname = String(format: "%@", dicregion.value(forKey: "region")as? String ?? "")
                                let strcountry_id = String(format: "%@", dictemp!.value(forKey: "country_id")as? String ?? "")
                                let arrstreet = (dictemp!.value(forKey: "street")as! NSArray)
                                var strfullstreet = ""
                                for x in 0 ..< arrstreet.count
                                {
                                    let tsr1 = String(format: "%@ ", arrstreet.object(at: x) as? String ?? "")
                                    strfullstreet = strfullstreet.appending(tsr1)
                                }
                                let strFinalAddress = String(format: "%@,%@,%@", strfullstreet,strregionname,strcountry_id)
                                
                                
                                let dictemp1 = NSMutableDictionary()
                                dictemp1.setValue(strid, forKey: "id")
                                dictemp1.setValue(strFinalAddress, forKey: "address")
                                dictemp1.setValue("0", forKey: "selected")
                                
                                self.arrMmyaddresslist.add(dictemp1)
                            }
                            
                            for gg in 0 ..< itemsaddress.count
                            {
                                let strvalue = itemsaddress[gg]
                                
                                let dictemp = self.arrMmyaddresslist.object(at: gg)as? NSMutableDictionary
                                let strid = String(format: "%@", dictemp!.value(forKey: "id")as! CVarArg)
                                if strid == strvalue
                                {
                                    dictemp!.setValue("1", forKey: "selected")
                                }
                                else{
                                    dictemp!.setValue("0", forKey: "selected")
                                }
                            }
                            
                            print("self.arrMmyaddresslist",self.arrMmyaddresslist)
                            
                            if self.arrMmyaddresslist.count == 0{
                                self.msg = "No addresses found!"
                            }
                            
                            self.tabvallowedaddress.reloadData()
                            
                            
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
}
