//
//  loyaltypointbalance.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/11/22.
//

import UIKit

class loyaltypointbalance: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblcurrentbalance: UILabel!
    @IBOutlet weak var lblcurrentbalancevalue: UILabel!
    @IBOutlet weak var imgvwalleticon: UIImageView!
    
    @IBOutlet weak var viewmiddle: UIView!
    @IBOutlet weak var lblmsg1: UILabel!
    @IBOutlet weak var txtvmsg1: UITextView!
    @IBOutlet weak var lblmsg2: UILabel!
    @IBOutlet weak var txtvmsg2: UITextView!
    
    @IBOutlet weak var lbltransactionlist: UILabel!
    @IBOutlet weak var tabvtransactionlist: UITableView!
    var reuseIdentifier1 = "cellloyaltyhistory"
    var msg = ""
    
    var arrMalltransactions = NSMutableArray()

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
        
        self.getLoyaltyPointAPIMethod()
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language131")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
         
        tabvtransactionlist.register(UINib(nibName: "cellloyaltyhistory", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvtransactionlist.separatorStyle = .none
        tabvtransactionlist.backgroundView=nil
        tabvtransactionlist.backgroundColor=UIColor.clear
        tabvtransactionlist.separatorColor=UIColor.clear
        tabvtransactionlist.showsVerticalScrollIndicator = false
        
        viewtop.isHidden = true
        viewmiddle.isHidden = true
        lbltransactionlist.isHidden = true
        tabvtransactionlist.isHidden = true
        
        lblcurrentbalance.text = myAppDelegate.changeLanguage(key: "msg_language458")
        lblmsg1.text = myAppDelegate.changeLanguage(key: "msg_language459")
        lblmsg2.text = myAppDelegate.changeLanguage(key: "msg_language460")
        lbltransactionlist.text = myAppDelegate.changeLanguage(key: "msg_language461")
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMalltransactions.count == 0 {
            self.tabvtransactionlist.setEmptyMessage(msg)
        } else {
            self.tabvtransactionlist.restore()
        }
        return arrMalltransactions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellloyaltyhistory
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dict = arrMalltransactions.object(at: indexPath.section)as? NSDictionary
        let strid = String(format: "%@", dict?.value(forKey: "id")as! CVarArg)
        let strcomment = String(format: "%@", dict?.value(forKey: "comment")as? String ?? "")
        let strpoints = String(format: "%@", dict?.value(forKey: "points")as? String ?? "")
        let strcreated = String(format: "%@", dict?.value(forKey: "created")as? String ?? "")
        let strstatus = String(format: "%@", dict?.value(forKey: "status")as? String ?? "")
        let strstatus_description = String(format: "%@", dict?.value(forKey: "status_description")as? String ?? "")
        
        if strpoints.containsIgnoreCase("-")
        {
            //Red Color
            cell.lblpoint.text = String(format: "%@", strpoints)
            cell.lblpoint.textColor = UIColor(named: "darkmostredcolor")!
        }
        else{
            //Gren Color
            cell.lblpoint.text = String(format: "+ %@", strpoints)
            cell.lblpoint.textColor = UIColor(named: "darkgreencolor")!
        }

        cell.lblcomments.text = strcomment
        cell.lblpointdesc.text = strstatus_description
       
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
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod90,strLangCode)
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
                    self.getAllTransactionsListAPIMethod()
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
                            self.viewtop.isHidden = false
                            self.viewmiddle.isHidden = false
                            
                            
                            let strpoints = dictemp.value(forKey: "points")as? String ?? ""
                            print("strpoints",strpoints)
                            self.lblcurrentbalancevalue.text = strpoints
                            
                            let arrearn_rules = dictemp.value(forKey: "earn_rules") as? NSArray ?? []
                            let arrspend_rules = dictemp.value(forKey: "spend_rules") as? NSArray ?? []
                            print("arrearn_rules",arrearn_rules)
                            print("arrspend_rules",arrspend_rules)
                            
                            self.txtvmsg1.text = String(format: "%@", arrearn_rules.object(at: 0)as? String ?? "")
                            self.txtvmsg2.text = String(format: "%@", arrspend_rules.object(at: 0)as? String ?? "")
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                        
                        self.getAllTransactionsListAPIMethod()
                    }
                }
            }
            catch {
                //check for internal server data error
                DispatchQueue.main.async {
                    self.getAllTransactionsListAPIMethod()
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - get All Reard Transactions List API method
    func getAllTransactionsListAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod91,strLangCode)
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
                            self.lbltransactionlist.isHidden = false
                            self.tabvtransactionlist.isHidden = false
                            
                            if self.arrMalltransactions.count > 0{
                                self.arrMalltransactions.removeAllObjects()
                            }
                            
                            let arrtransaction_list = json.value(forKey: "transaction_list") as? NSArray ?? []
                            self.arrMalltransactions = NSMutableArray(array: arrtransaction_list)
                            print("arrMalltransactions --->",self.arrMalltransactions)
                            
                            if self.arrMalltransactions.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language403")
                            }
                            self.tabvtransactionlist.reloadData()
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
