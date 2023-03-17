//
//  maidaccounts.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class maidaccounts: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvmaidlist: UITableView!
    var reuseIdentifier1 = "celltabvmaidlist"
    var msg = ""
    
    @IBOutlet weak var btncreatemaid: UIButton!
    
    @IBOutlet var viewtransferpopup: UIView!
    @IBOutlet weak var lbltransfermaidname: UILabel!
    @IBOutlet weak var viewtrsnaferamount: UIView!
    @IBOutlet weak var viewamounticon: UIView!
    @IBOutlet weak var imgvamounticon: UIImageView!
    @IBOutlet weak var txttransferamount: UITextField!
    @IBOutlet weak var btncrosstransferpopup: UIButton!
    @IBOutlet weak var btnsubmittransferpopup: UIButton!
    var viewPopupAddNewExistingBG1 = UIView()
    
    
    
    var arrMmaidlist = NSMutableArray()
    var strcurrency = ""
    
    
    var myAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
        
        self.fecthmaidaccountlistingAPIMethod()
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language405")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvmaidlist.register(UINib(nibName: "celltabvmaidlist", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmaidlist.separatorStyle = .none
        tabvmaidlist.backgroundView=nil
        tabvmaidlist.backgroundColor=UIColor.clear
        tabvmaidlist.separatorColor=UIColor.clear
        tabvmaidlist.showsVerticalScrollIndicator = false
        
        btncreatemaid.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language462")), for: .normal)
        
        btncreatemaid.layer.cornerRadius = 16.0
        btncreatemaid.layer.masksToBounds = true
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Create New Maid account method
    @IBAction func pressCreateNewMaid(_ sender: Any)
    {
        let ctrl = createmaidaccount(nibName: "createmaidaccount", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMmaidlist.count == 0 {
            self.tabvmaidlist.setEmptyMessage(msg)
        } else {
            self.tabvmaidlist.restore()
        }
        return arrMmaidlist.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 184
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvmaidlist
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        
        let dic = self.arrMmaidlist.object(at: indexPath.section)as! NSDictionary
        let strrow_id = String(format: "%@", dic.value(forKey: "row_id")as? String ?? "")
        let strmaid_id = String(format: "%@", dic.value(forKey: "maid_id")as? String ?? "")
        let strname = String(format: "%@", dic.value(forKey: "name")as? String ?? "")
        let stremail = String(format: "%@", dic.value(forKey: "email")as? String ?? "")
        let strstatus = String(format: "%@", dic.value(forKey: "status")as? String ?? "")
        let strmax_order_amount = String(format: "%@", dic.value(forKey: "max_order_amount")as? String ?? "")
        let strwalletbalance = String(format: "%@", dic.value(forKey: "wallet_amount")as! CVarArg)
        
        let fltamountwallet = (strwalletbalance as NSString).floatValue
        let fltamountmaxwallet = (strmax_order_amount as NSString).floatValue
        
        cell.lblname.text = String(format: "%@", strname)
        cell.lblemail.text = String(format: "%@",stremail)
        cell.lblmaxamountlimit.text = String(format: "%@: %@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language406"),myAppDelegate.changeLanguage(key: "msg_language481"),fltamountmaxwallet)
        cell.lblwalletbalance.text = String(format: "%@: %@ %0.2f",myAppDelegate.changeLanguage(key: "msg_language217"),myAppDelegate.changeLanguage(key: "msg_language481"),fltamountwallet)
        
        cell.lblstatus.text = strstatus
        
        if strstatus == "Active"
        {
            //ACTIVE
            cell.lblstatus.textColor = .white
            cell.lblstatus.backgroundColor = UIColor(named: "greencolor")!
        }
        else{
            //INACTIVE
            cell.lblstatus.textColor = .black
            cell.lblstatus.backgroundColor = UIColor(named: "darkredcolor")!
        }
        
        cell.lblstatus.layer.cornerRadius = 14.0
        cell.lblstatus.layer.masksToBounds = true
        
        cell.viewwallettransfer.layer.borderWidth = 1.0
        cell.viewwallettransfer.layer.borderColor = UIColor(named: "darkgreencolor")!.cgColor
        cell.viewwallettransfer.layer.cornerRadius = 18.0
        cell.viewwallettransfer.layer.masksToBounds = true
        
        cell.btnedit.tag = indexPath.section
        cell.btnedit.addTarget(self, action: #selector(pressEdit), for: .touchUpInside)
        
        cell.btnwallettransfer.setTitle(String(format:"%@",myAppDelegate.changeLanguage(key: "msg_language407")), for: .normal)
        cell.btnwallettransfer.tag = indexPath.section
        cell.btnwallettransfer.addTarget(self, action: #selector(pressWalletTransfer), for: .touchUpInside)
        
        cell.viewcell.layer.cornerRadius = 8.0
        cell.viewcell.layer.masksToBounds = true
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    //MARK: - press Edit Function Method
    @objc func pressEdit(sender:UIButton)
    {
        print("section",sender.tag)
        let dic = self.arrMmaidlist.object(at: sender.tag)as! NSDictionary
        let strrow_id = String(format: "%@", dic.value(forKey: "row_id")as? String ?? "")
        let strmaid_id = String(format: "%@", dic.value(forKey: "maid_id")as? String ?? "")
        let strname = String(format: "%@", dic.value(forKey: "name")as? String ?? "")
        let stremail = String(format: "%@", dic.value(forKey: "email")as? String ?? "")
        let strstatus = String(format: "%@", dic.value(forKey: "status")as? String ?? "")
        let strmax_order_amount = String(format: "%@", dic.value(forKey: "max_order_amount")as? String ?? "")
        let strwalletbalance = String(format: "%@", dic.value(forKey: "wallet_amount")as! CVarArg)
        
        let ctrl = maidaccountsdetails(nibName: "maidaccountsdetails", bundle: nil)
        ctrl.dicdetails = dic
        ctrl.strcurrency = self.strcurrency
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Wallet Transfer Function Method
    @objc func pressWalletTransfer(sender:UIButton)
    {
        print("section",sender.tag)
        let dic = self.arrMmaidlist.object(at: sender.tag)as! NSDictionary
        let strrow_id = String(format: "%@", dic.value(forKey: "row_id")as? String ?? "")
        let strmaid_id = String(format: "%@", dic.value(forKey: "maid_id")as? String ?? "")
        let strname = String(format: "%@", dic.value(forKey: "name")as? String ?? "")
        let stremail = String(format: "%@", dic.value(forKey: "email")as? String ?? "")
        let strstatus = String(format: "%@", dic.value(forKey: "status")as? String ?? "")
        let strmax_order_amount = String(format: "%@", dic.value(forKey: "max_order_amount")as? String ?? "")
        let strwalletbalance = String(format: "%@", dic.value(forKey: "wallet_amount")as! CVarArg)
        
        self.createTransferAmountPopup(strname: strname, strrowid: strrow_id, strmaidid: strmaid_id)
    }
    
    
    //MARK: - create popup Transfer Amount Method
    func createTransferAmountPopup(strname:String,strrowid:String,strmaidid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if self.viewtransferpopup != nil{
            self.viewtransferpopup.removeFromSuperview()
            viewPopupAddNewExistingBG1.removeFromSuperview()
        }
        
        let height1 = Float(UIApplication.shared.statusBarFrame.height) as Float
        let height2 = Float((self.navigationController?.navigationBar.frame.size.height)!) as Float
        let myFloat1 = height1 + height2
        print(myFloat1)
        
        self.viewtransferpopup.layer.cornerRadius = 6.0
        self.viewtransferpopup.layer.masksToBounds = true
        
        self.txttransferamount.setLeftPaddingPoints(10)
        
        self.lbltransfermaidname.text = strname
        
        self.txttransferamount.placeholder = myAppDelegate.changeLanguage(key: "msg_language408")
        self.btnsubmittransferpopup.setTitle(String(format:"%@",myAppDelegate.changeLanguage(key: "msg_language178")), for: .normal)
        
        self.btnsubmittransferpopup.tag = Int(strmaidid)!
        self.btnsubmittransferpopup.layer.cornerRadius = 10.0
        self.btnsubmittransferpopup.layer.masksToBounds = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxttransferamount))
        toolbarDone.items = [barBtnDone]
        self.txttransferamount.inputAccessoryView = toolbarDone
        
        viewPopupAddNewExistingBG1 = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        viewPopupAddNewExistingBG1.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        let frameSize: CGPoint = CGPoint(x:viewPopupAddNewExistingBG1.bounds.size.width*0.5,y: (viewPopupAddNewExistingBG1.bounds.size.height*0.5) - 20)
        viewPopupAddNewExistingBG1.addSubview(self.viewtransferpopup)
        self.viewtransferpopup.center = frameSize
        self.view.addSubview(viewPopupAddNewExistingBG1)
    }
    @IBAction func presscrosstransferamount(_ sender: Any) {
        
        self.viewtransferpopup.removeFromSuperview()
        viewPopupAddNewExistingBG1.removeFromSuperview()
    }
    @IBAction func presssubmittransferamount(_ sender: UIButton)
    {
        let fltpurchaselimit = Float(self.txttransferamount.text!)
        
        if self.txttransferamount.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language409"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if fltpurchaselimit! > 200.00 || fltpurchaselimit! <= 0.00
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language410"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            print("update successfull")
            
            let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language411"), preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                print("Handle Continue Logic here")
                self.viewtransferpopup.removeFromSuperview()
                self.viewPopupAddNewExistingBG1.removeFromSuperview()
                
                self.posttransfermaidaccountamountAPIMethod(stramount: self.txttransferamount.text!, strmaidid: String(format: "%d", sender.tag))
            }))
            refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                  print("Handle Cancel Logic here")
                self.viewtransferpopup.removeFromSuperview()
                self.viewPopupAddNewExistingBG1.removeFromSuperview()
            }))
            self.present(refreshAlert, animated: true, completion: nil)
 
        }
    }
    @objc func pressDonetxttransferamount(sender: UIButton)
    {
        self.txttransferamount.resignFirstResponder()
    }
    
    
    //MARK: - fetch maid account list API Method
    func fecthmaidaccountlistingAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let parameters = ["name": "",
                          "email": "",
                          "status": "","language":""] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod66)
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
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.strcurrency = String(format: "%@", dictemp.value(forKey: "currency")as? String ?? "")
                            
                            if self.arrMmaidlist.count > 0{
                                self.arrMmaidlist.removeAllObjects()
                            }
                            
                            let arrm = dictemp.value(forKey: "list") as? NSArray ?? []
                            self.arrMmaidlist = NSMutableArray(array: arrm)
                            //print("arrMmaidlist --->",self.arrMmaidlist)
                            
                            if self.arrMmaidlist.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language412")
                            }
                            
                            self.tabvmaidlist.reloadData()
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
    
    //MARK: - transfer maid account amount API Method
    func posttransfermaidaccountamountAPIMethod(stramount:String,strmaidid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)

        let parameters = ["subaccountid": strmaidid,
                          "mainaccountid": strcustomerid,
                          "amount": stramount,
                          "note": ""] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod71)
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
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            self.fecthmaidaccountlistingAPIMethod()
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
