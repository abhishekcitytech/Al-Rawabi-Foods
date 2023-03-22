//
//  SubscriptionShippingAddress.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 28/10/22.
//

import UIKit

class SubscriptionShippingAddress: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var tabvmyaddress: UITableView!
    var reuseIdentifier1 = "cellSelectShippingAddress"
    var msg = ""
    
    @IBOutlet weak var btnaddnewaddress: UIButton!
    @IBOutlet weak var btnpaycheckout: UIButton!
    
    var arrMmyaddresslist = NSMutableArray()
    var strSelectedaddress = ""
    
    var strSelectedaddressID = ""
    
    var strpageidentifier = ""
    var strpageidentifierplanname = ""
    
    var strselectedslotname = ""
    var strselectedslotid = ""
    var strpaymentype = ""
    
    var strsubtotalamount = ""
    var strshippingchargesamount = ""
    
    var arrmShippingchargeslist = NSMutableArray()
    
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
        
        self.getcustomeraddresslist()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language95")
        
        btnaddnewaddress.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language93")), for: .normal)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            //btnaddnewaddress.frame = CGRect(x: tabvmyaddress.frame.maxX - btnaddnewaddress.frame.size.width - 10, y: btnaddnewaddress.frame.origin.y, width: btnaddnewaddress.frame.size.width, height: btnaddnewaddress.frame.size.height)
        }
        else
        {
           // btnaddnewaddress.frame = CGRect(x: 10, y: btnaddnewaddress.frame.origin.y, width: btnaddnewaddress.frame.size.width, height: btnaddnewaddress.frame.size.height)
        }
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnpaycheckout.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language94")), for: .normal)
        btnpaycheckout.layer.cornerRadius = 16.0
        btnpaycheckout.layer.masksToBounds = true
        
        tabvmyaddress.register(UINib(nibName: "cellSelectShippingAddress", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyaddress.separatorStyle = .none
        tabvmyaddress.backgroundView=nil
        tabvmyaddress.backgroundColor=UIColor.clear
        tabvmyaddress.separatorColor=UIColor.clear
        tabvmyaddress.showsVerticalScrollIndicator = false
        
        if strpageidentifier == "100"
        {
            //DAILY
        }
        else if strpageidentifier == "200"
        {
            //WEEKLY
        }
        else if strpageidentifier == "300"
        {
            //MONTHLY
        }
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Pay&Checkout method
    @IBAction func presspaycheckout(_ sender: Any)
    {
        print("self.arrmShippingchargeslist",self.arrmShippingchargeslist)
        
        UserDefaults.standard.set("2", forKey: "payfromOrderonce")
        UserDefaults.standard.synchronize()
        
        let ctrl = Subscriptionpaymentmethod(nibName: "Subscriptionpaymentmethod", bundle: nil)
        ctrl.strpageidentifier = strpageidentifier
        ctrl.strpageidentifierplanname = strpageidentifierplanname
        ctrl.strsubtotalamount = strsubtotalamount
        ctrl.strshippingchargesamount = strshippingchargesamount
        ctrl.strselectedslotid = strselectedslotid
        ctrl.strselectedslotname = strselectedslotname
        ctrl.strpaymentype = strpaymentype
        ctrl.strselectedaddressid = strSelectedaddressID
        ctrl.arrmShippingchargeslist1 = self.arrmShippingchargeslist
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    //MARK: - press Add New Address Method
    @IBAction func pressAddnewaddress(_ sender: Any)
    {
        let ctrl = addnewaddress(nibName: "addnewaddress", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrMmyaddresslist.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 180
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellSelectShippingAddress
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMmyaddresslist.object(at: indexPath.section)as! NSDictionary
        
        let strfirstname = String(format: "%@", dic.value(forKey: "address_firstname")as? String ?? "")
        let strlastname = String(format: "%@", dic.value(forKey: "address_lastname")as? String ?? "")
        let strmobileno = String(format: "%@", dic.value(forKey: "telephone")as? String ?? "")
        let strcity = String(format: "%@", dic.value(forKey: "city")as? String ?? "")
        let strdefault_shipping = String(format: "%@", dic.value(forKey: "default_shipping")as! CVarArg)
        
        let dicregion = dic.value(forKey: "region")as! NSDictionary
        let strregionname = String(format: "%@", dicregion.value(forKey: "region")as? String ?? "")
        
        let strcountry_id = String(format: "%@", dic.value(forKey: "country_id")as? String ?? "")
        
        let arrstreet = (dic.value(forKey: "street")as! NSArray)
        var strfullstreet = ""
        for x in 0 ..< arrstreet.count
        {
            let tsr1 = String(format: "%@ ", arrstreet.object(at: x) as? String ?? "")
            strfullstreet = strfullstreet.appending(tsr1)
        }
        print("strfullstreet",strfullstreet)
        
        let strFinalAddress = String(format: "%@,%@,%@", strfullstreet,strregionname,strcountry_id)
        
        cell.lblname.text = String(format: "%@ %@", strfirstname,strlastname)
        cell.lblmobileno.text = String(format: "%@", strmobileno)
        cell.lblcity.text = strcity
        cell.txtvaddress.text = strFinalAddress
        
        if strdefault_shipping == "1"{
            
            cell.lblSetAsDefault.isHidden = true
            cell.switchSetdefault.isOn = true
            cell.switchSetdefault.isUserInteractionEnabled = false
            
            cell.lbldefault.isHidden = false
            
            cell.viewcell.backgroundColor = UIColor.white
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 0.0
            cell.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cell.viewcell.layer.borderWidth = 1.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0
        }
        else{
            
            cell.lblSetAsDefault.isHidden = false
            cell.switchSetdefault.isOn = false
            cell.switchSetdefault.isUserInteractionEnabled = true
            
            cell.lbldefault.isHidden = true
            
            cell.viewcell.backgroundColor = UIColor.white
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 0.0
            cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cell.viewcell.layer.borderWidth = 1.0
            cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
            cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.viewcell.layer.shadowOpacity = 1.0
            cell.viewcell.layer.shadowRadius = 6.0
        }
        
        cell.btndetailsarrow.tag = indexPath.section
        cell.btndetailsarrow.addTarget(self, action: #selector(pressdetailsarrow), for: .touchUpInside)
        
        //Check Address Selection
        if strSelectedaddress == String(format: "%d", indexPath.section)
        {
            cell.imgvSelection.image = UIImage(named: "checkRadio")
        }
        else{
            cell.imgvSelection.image = UIImage(named: "uncheckRadio")
        }
        
        cell.lbldefault.text = myAppDelegate.changeLanguage(key: "msg_language121")
        cell.lblSetAsDefault.text = myAppDelegate.changeLanguage(key: "msg_language120")
        
        cell.switchSetdefault.tag = indexPath.section
        cell.switchSetdefault.addTarget(self, action: #selector(pressswitchSetdefault), for: .touchUpInside)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        strSelectedaddress = String(format: "%d", indexPath.section)
        let dic = self.arrMmyaddresslist.object(at: indexPath.section)as! NSDictionary
        let straddress_id = String(format: "%@", dic.value(forKey: "address_id")as! CVarArg)
        strSelectedaddressID = straddress_id
    }
    
    //MARK: - press Detail Address Method
    @objc func pressdetailsarrow(sender:UIButton)
    {
        let dic = self.arrMmyaddresslist.object(at: sender.tag)as! NSDictionary
        let ctrl = updatemyaddress(nibName: "updatemyaddress", bundle: nil)
        ctrl.dicAddressDetails = dic
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Switch Set As Default Method
    @objc func pressswitchSetdefault(sender:UISwitch)
    {
        print("sender tag",sender.tag)
        let dic = self.arrMmyaddresslist.object(at: sender.tag)as! NSDictionary
        let straddress_id = String(format: "%@", dic.value(forKey: "address_id")as! CVarArg)
        
        self.postSetAsDefaultAPIMethod(strselectedaddressid: straddress_id)
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
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod24,"")
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
                            print("aarrm1",aarrm1.count)
                            
                            var selectedindex = -1
                            var arrm2 = NSMutableArray()
                            for x in 0 ..< aarrm1.count
                            {
                                let dictemp = aarrm1.object(at: x)as? NSDictionary
                                let sortdefaultshipping = String(format: "%@", dictemp?.value(forKey: "default_shipping")as! CVarArg)
                                print("sortdefaultshipping",sortdefaultshipping)
                                if sortdefaultshipping == "1"{
                                    arrm2.add(dictemp as Any)
                                    selectedindex = x
                                }
                            }
                            
                            if selectedindex != -1{
                                let dictt = aarrm1.object(at: selectedindex)as! NSDictionary
                                aarrm1.remove(dictt as Any)
                            }
                            
                            print("arrm2",arrm2.count)
                            print("aarrm1",aarrm1.count)
                            
                            arrm2.addObjects(from: aarrm1 as [AnyObject])
                            
                            print("arrm2",arrm2.count)
                            
                            self.arrMmyaddresslist = NSMutableArray(array: arrm2)
                            print("arrMmyaddresslist --->",self.arrMmyaddresslist)
                            
                            if self.arrMmyaddresslist.count == 0{
                                self.msg = "No address found!"
                            }
                            
                            if self.arrMmyaddresslist.count > 0
                            {
                                self.strSelectedaddress = String(format: "%d", 0)
                                let dic = self.arrMmyaddresslist.object(at: 0)as! NSDictionary
                                let straddress_id = String(format: "%@", dic.value(forKey: "address_id")as! CVarArg)
                                self.strSelectedaddressID = straddress_id
                                
                            }
                            
                            self.tabvmyaddress.reloadData()
                            
                            
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
    
    //MARK: - post Set As Default Address API method
    func postSetAsDefaultAPIMethod(strselectedaddressid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["addressId": strselectedaddressid] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod35)
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
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.getcustomeraddresslist()
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
    
}
