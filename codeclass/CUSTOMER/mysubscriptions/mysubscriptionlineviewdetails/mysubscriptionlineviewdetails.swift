//
//  mysubscriptionlineviewdetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 15/11/22.
//

import UIKit

class mysubscriptionlineviewdetails: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblsubscriptionid: UILabel!
    @IBOutlet weak var lblstartdate: UILabel!
    @IBOutlet weak var lblenddate: UILabel!
    @IBOutlet weak var lblgrandtotal: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    
    @IBOutlet weak var btnpause: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    
    @IBOutlet weak var tabvmysubscription: UITableView!
    var reuseIdentifier1 = "celltabvlinedate"
    var msg = ""
    

    var diclistvalue = NSDictionary()
    var dicMSubscriptionDetails =  NSMutableDictionary()
    var arrMsubscription_order = NSMutableArray()
    
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
        
        /*
         '0' = 'Pending',
         '1' = 'Active',
         '2' = 'Paused',
         '3' = 'Expired',
         '4' = 'Cancel'
         */
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        let strsubscription_increment_id = String(format: "%@", diclistvalue.value(forKey: "subscription_increment_id")as? String ?? "")
        //let strsubscription_plan = String(format: "%@", diclistvalue.value(forKey: "subscription_plan")as? String ?? "")
        let strsubscription_start_date = String(format: "%@", diclistvalue.value(forKey: "subscription_start_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_end_date = String(format: "%@", diclistvalue.value(forKey: "subscription_end_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_status = String(format: "%@", diclistvalue.value(forKey: "subscription_status")as? String ?? "")
        let strsubscription_status_code = String(format: "%@", diclistvalue.value(forKey: "subscription_status_code")as? String ?? "")
        //let strsubscription_renewal_status = String(format: "%@", diclistvalue.value(forKey: "subscription_renewal_status")as? String ?? "")
        
        self.lblsubscriptionid.text = String(format: "# %@", strsubscription_increment_id)
        self.lblstartdate.text = String(format: "Start Date: %@", strsubscription_start_date)
        self.lblenddate.text = String(format: "End Date: %@", strsubscription_end_date)
        
        self.lblstatus.text = strsubscription_status
        self.lblstatus.textColor = .white
        self.lblstatus.layer.cornerRadius = 14.0
        self.lblstatus.layer.masksToBounds = true
        
        print("strsubscription_status_code",strsubscription_status_code)
        if strsubscription_status_code == "0"{
            //Pending
            btnpause.isHidden = true
            btncancel.isHidden = true
            self.lblstatus.backgroundColor =  UIColor(named: "orangecolor")!
        }
        else if strsubscription_status_code == "1"{
            //Active
            btnpause.isHidden = false
            btncancel.isHidden = false
            self.lblstatus.backgroundColor =  UIColor(named: "themecolor")!
            
            btnpause.backgroundColor = UIColor(named: "greencolor")!
            btnpause.tag = 200
            btnpause.setTitle("PAUSE", for: .normal)
        }
        else if strsubscription_status_code == "2"{
            //Paused
            btnpause.isHidden = false
            btncancel.isHidden = false
            self.lblstatus.backgroundColor =  UIColor(named: "greencolor")!
            
            btnpause.backgroundColor = .blue
            btnpause.tag = 100
            btnpause.setTitle("RESUME", for: .normal)
        }
        else if strsubscription_status_code == "3"{
            //Expired
            btnpause.isHidden = false
            btncancel.isHidden = true
            self.lblstatus.backgroundColor =  UIColor(named: "lightblue")!
            
            btnpause.backgroundColor = .red
            btnpause.tag = 300
            btnpause.setTitle("RENEW", for: .normal)
        }
        else if strsubscription_status_code == "4"{
            //Canceled
            btnpause.isHidden = true
            btncancel.isHidden = true
            self.lblstatus.backgroundColor =  UIColor(named: "darkredcolor")!
        }
        
        self.getallmysubscriptionDetail(strsubscriptionid: strsubscription_id)
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "My Subscription Detail"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnpause.layer.cornerRadius = 16.0
        btnpause.layer.masksToBounds = true
        btncancel.layer.cornerRadius = 16.0
        btncancel.layer.masksToBounds = true
        
        self.btnpause.isHidden = true
        self.btncancel.isHidden = true
        
        tabvmysubscription.register(UINib(nibName: "celltabvlinedate", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmysubscription.separatorStyle = .none
        tabvmysubscription.backgroundView=nil
        tabvmysubscription.backgroundColor=UIColor.clear
        tabvmysubscription.separatorColor=UIColor.clear
        tabvmysubscription.showsVerticalScrollIndicator = false
      
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press PAUSE/RESUME method
    @IBAction func pressPAUSERESUME(_ sender: UIButton)
    {
        if sender.tag == 100{
            //RESUME
            
            let refreshAlert = UIAlertController(title: "", message: "Do you want to Resume this subscription?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
                self.postPAUSERESUMEAPIMethod()
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        else if sender.tag == 200
        {
            //PAUSE
            let refreshAlert = UIAlertController(title: "", message: "Do you want to Pause this subscription?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
                self.postPAUSERESUMEAPIMethod()
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        else if sender.tag == 300
        {
            let refreshAlert = UIAlertController(title: "", message: "Do you want to Renew this subscription?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in

            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
            }))
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    //MARK: - press CANCEL method
    @IBAction func pressCANCEL(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "", message: "Do you want to Cancel this subscription?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
            self.postCANCELAPIMethod()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
        
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMsubscription_order.count == 0 {
            self.tabvmysubscription.setEmptyMessage(msg)
        } else {
            self.tabvmysubscription.restore()
        }
        return arrMsubscription_order.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130
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

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvlinedate
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMsubscription_order.object(at: indexPath.section)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strsubtotal = String(format: "%@", dic.value(forKey: "subtotal")as? String ?? "")
        let strshipping_amount = String(format: "%@", dic.value(forKey: "shipping_amount")as? String ?? "")
        let strgrand_total = String(format: "%@", dic.value(forKey: "grand_total")as! CVarArg)
        let strcurrency = String(format: "%@", dic.value(forKey: "currency")as? String ?? "")
        
        let strisedit = dic.value(forKey: "is_edit")as? Bool ?? false
        
        cell.lblorderdateday.text = String(format: "Order Date: %@", strsubscription_order_date)
        cell.lblstatus.text = String(format: "Status: %@",strorder_status)
        cell.lblsubtotal.text = String(format: "SubTotal: %@ %@",strcurrency,strsubtotal)
        
        if strshipping_amount == "0" || strshipping_amount == "0.00"
        {
            cell.lblshipping.text = "Shipping Free"
        }
        else{
            cell.lblshipping.text = String(format: "Shipping: %@ %@",strcurrency,strshipping_amount)
        }
        
        cell.btnedit.tag = indexPath.section
        cell.btnedit.addTarget(self, action: #selector(pressEdit), for: .touchUpInside)
        
        print("strisedit",strisedit)
        
        if strisedit == true{
            cell.btnedit.isHidden = false
        }
        else{
            cell.btnedit.isHidden = true
        }
        
        cell.btnedit.layer.cornerRadius = 14.0
        cell.btnedit.layer.masksToBounds = true
       
        
        if strisedit == true
        {
            cell.viewcell.backgroundColor = UIColor(named: "greenlighter")!
            cell.viewcell.layer.borderWidth  = 1.0
            cell.viewcell.layer.borderColor  = UIColor(named: "graybordercolor")!.cgColor
            cell.viewcell.layer.cornerRadius = 8.0
            cell.viewcell.layer.masksToBounds = true
        }
        else{
            cell.viewcell.backgroundColor = UIColor(named: "lightred")!
            cell.viewcell.layer.borderWidth  = 1.0
            cell.viewcell.layer.borderColor  = UIColor(named: "graybordercolor")!.cgColor
            cell.viewcell.layer.cornerRadius = 8.0
            cell.viewcell.layer.masksToBounds = true
        }
        
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    //MARK: - press Detail method
    @objc func pressEdit(sender:UIButton)
    {
        let dic = self.arrMsubscription_order.object(at: sender.tag)as! NSDictionary
        let strsubscription_order_id = String(format: "%@", dic.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", dic.value(forKey: "order_status")as? String ?? "")
        let strsubtotal = String(format: "%@", dic.value(forKey: "subtotal")as? String ?? "")
        let strshipping_amount = String(format: "%@", dic.value(forKey: "shipping_amount")as? String ?? "")
        let strgrand_total = String(format: "%@", dic.value(forKey: "grand_total")as! CVarArg)
        let strcurrency = String(format: "%@", dic.value(forKey: "currency")as? String ?? "")
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        
        let ctrl = mysubscriptionlineviewproductdetails(nibName: "mysubscriptionlineviewproductdetails", bundle: nil)
        ctrl.diclistvalue = dic
        ctrl.strsubscription_id = strsubscription_id
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    
    
    
    //MARK: - post PAUSE / RESUME API Method
    func postPAUSERESUMEAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        let parameters = ["subscription_id": strsubscription_id] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod47)
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
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
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
    
    //MARK: - post CANCEL API Method
    func postCANCELAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let strsubscription_id = String(format: "%@", diclistvalue.value(forKey: "subscription_id")as? String ?? "")
        let parameters = ["subscriptionid": strsubscription_id] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod48)
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
                            let uiAlert = UIAlertController(title: "", message: strmessage , preferredStyle: UIAlertController.Style.alert)
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
    
    
    //MARK: - get All My subscription Detail API method
    func getallmysubscriptionDetail(strsubscriptionid:String)
    {
        if arrMsubscription_order.count > 0{
            arrMsubscription_order.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?subscriptionid=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod49,strsubscriptionid)
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
                            
                            let dic = dictemp.value(forKey: "subscription_detail") as? NSDictionary
                            self.dicMSubscriptionDetails = dic?.mutableCopy() as! NSMutableDictionary
                            print("dicMSubscriptionDetails --->",self.dicMSubscriptionDetails)
                            
                            let strGrandTotalValue = String(format: "%@", self.dicMSubscriptionDetails.value(forKey: "grandtotal")as? String ?? "")
                            let fltTotal  = (strGrandTotalValue as NSString).floatValue
                            self.lblgrandtotal.text = String(format: "%@: AED %0.2f", myAppDelegate.changeLanguage(key: "msg_language86"),fltTotal)
                            
                            let arrm = dic!.value(forKey: "subscription_order") as? NSArray ?? []
                            self.arrMsubscription_order = NSMutableArray(array: arrm)
                            print("arrMsubscription_order --->",self.arrMsubscription_order)
                            if self.arrMsubscription_order.count == 0{
                                self.msg = "No orders found!"
                            }
                            self.tabvmysubscription.reloadData()
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
