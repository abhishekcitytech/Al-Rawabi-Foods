//
//  reordermyorderoncelist.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class reordermyorderoncelist: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvmyorders: UITableView!
    var reuseIdentifier1 = "cellmyorderReorder"
    var msg = ""

    var arrMmyorders = NSMutableArray()
    

    
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
        
        self.getAllOrdersAPIMethod(stratstus: "")
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language204")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        
        tabvmyorders.register(UINib(nibName: "cellmyorderReorder", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyorders.separatorStyle = .none
        tabvmyorders.backgroundView=nil
        tabvmyorders.backgroundColor=UIColor.clear
        tabvmyorders.separatorColor=UIColor.clear
        tabvmyorders.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMmyorders.count == 0 {
            self.tabvmyorders.setEmptyMessage(msg)
        } else {
            self.tabvmyorders.restore()
        }
        return arrMmyorders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 162
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellmyorderReorder
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMmyorders.object(at: indexPath.section)as! NSDictionary
        
        let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        let strorder_increment_id = String(format: "%@", dic.value(forKey: "order_increment_id")as! CVarArg)
        
        let strstatus = String(format: "%@", dic.value(forKey: "orderStatus")as? String ?? "")
        let strtotal_amount = String(format: "%@", dic.value(forKey: "total_amount")as? String ?? "")
        
        var strcurrency_code = String(format: "%@", dic.value(forKey: "currency_code")as? String ?? "")
        strcurrency_code = myAppDelegate.changeLanguage(key: "msg_language481") //FIXMECURRENCY
        
        let strcreated_at = String(format: "%@", dic.value(forKey: "created_at")as? String ?? "")
        let strordered_qty = String(format: "%@", dic.value(forKey: "ordered_qty")as? String ?? "")
        
        cell.lblordernovalue.text = String(format: "# %@", strorder_increment_id)
        cell.lbldeliverydatevalue.text = strcreated_at
        
        
        let flttotalprice1 = Float(strordered_qty)
        cell.lblquantityvalue.text = String(format: "%0.0f",flttotalprice1!)
        
        let flttotalprice = Float(strtotal_amount)
        cell.lbltotalamountvalue.text = String(format: "%@ %0.2f",strcurrency_code, flttotalprice!)
        
       
        cell.btndetails.layer.borderWidth = 1.0
        cell.btndetails.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cell.btndetails.layer.cornerRadius = 16.0
        cell.btndetails.layer.masksToBounds = true
  
        cell.btnreorder.layer.cornerRadius = 16.0
        cell.btnreorder.layer.masksToBounds = true
        
        cell.viewcell.backgroundColor = UIColor.white
        cell.viewcell.layer.masksToBounds = false
        cell.viewcell.layer.cornerRadius = 6.0
        cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.borderWidth = 1.0
        cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.viewcell.layer.shadowOpacity = 1.0
        cell.viewcell.layer.shadowRadius = 6.0
        
        cell.lblorderno.text = myAppDelegate.changeLanguage(key: "msg_language207")
        cell.lbldeliverydate.text = myAppDelegate.changeLanguage(key: "msg_language208")
        cell.lblquantity.text = myAppDelegate.changeLanguage(key: "msg_language209")
        cell.lbltotalamount.text = myAppDelegate.changeLanguage(key: "msg_language210")
        
        cell.btndetails.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language91")), for: .normal)
        cell.btnreorder.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language399")), for: .normal)
        
        cell.btndetails.tag = indexPath.section
        cell.btndetails.addTarget(self, action: #selector(pressDetails), for: .touchUpInside)
        
        cell.btnreorder.tag = indexPath.section
        cell.btnreorder.addTarget(self, action: #selector(pressReorder), for: .touchUpInside)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    //MARK: - press Order Details method
    @objc func pressDetails(sender:UIButton)
    {
        let dic = self.arrMmyorders.object(at: sender.tag)as! NSDictionary
        //let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        
        let ctrl = myorderhistorydetails(nibName: "myorderhistorydetails", bundle: nil)
        ctrl.strorder_id = strorder_id
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press Re-Order Method
    @objc func pressReorder(sender:UIButton)
    {
        let dic = self.arrMmyorders.object(at: sender.tag)as! NSDictionary
        print("dic",dic)
        let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        self.postReOrder(strorderincreamentalID: strorder_id)
    }

    //MARK: - get All Orders API method
    func getAllOrdersAPIMethod(stratstus:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?status=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod20,stratstus,strLangCode)
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
                            if self.arrMmyorders.count > 0{
                                self.arrMmyorders.removeAllObjects()
                            }
                            
                            let arrmorder = json.value(forKey: "orderdetail") as? NSArray ?? []
                            
                            //SORT ASCENDING FALSE ARRAY LIST BY SUBSCRIPTION ID //
                            //let descriptor: NSSortDescriptor = NSSortDescriptor(key: "order_id", ascending: false)
                            //let sortedResults = arrmorder.sortedArray(using: [descriptor]) as NSArray
                            //let aarrm1 = NSMutableArray(array: sortedResults)
                            
                            self.arrMmyorders = NSMutableArray(array: arrmorder)
                            print("arrMmyorders --->",self.arrMmyorders)
                            
                            if self.arrMmyorders.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language206")
                            }
                            
                            self.tabvmyorders.reloadData()
                            
                            
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
    
    //MARK: - post Re-Order API method
    func postReOrder(strorderincreamentalID:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        //let parameters = ["orderincrementid": strorderincreamentalID] as [String : Any]
        
        let parameters = ["orderId": strorderincreamentalID] as [String : Any]
        
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod53)
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
                            /*let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language401"), preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                
                                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                                if (strLangCode == "en")
                                {
                                    self.tabBarController?.selectedIndex = 3
                                }else{
                                    self.tabBarController?.selectedIndex = 1
                                }
                            }))*/
                            
                            let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                            if (strLangCode == "en")
                            {
                                self.tabBarController?.selectedIndex = 3
                            }else{
                                self.tabBarController?.selectedIndex = 1
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
    
}
