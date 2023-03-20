//
//  myorderhistorydetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 05/09/22.
//

import UIKit

class myorderhistorydetails: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var viewoverall: UIView!
    
    
    @IBOutlet weak var lbltotalorderitems: UILabel!
    @IBOutlet weak var tabvitemlist: UITableView!
    var reuseIdentifier1 = "cellorderhistoryitems"
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblorderno: UILabel!
    @IBOutlet weak var lblorderstatus: UILabel!
    @IBOutlet weak var lblordergrandtotal: UILabel!
    @IBOutlet weak var lblorderpaymentmethod: UILabel!
    @IBOutlet weak var viewcustomer: UIView!
    @IBOutlet weak var lblcustomername: UILabel!
    @IBOutlet weak var lblcustomeremail: UILabel!
    
    var strorder_id = ""
    
    var dicMOrderDetails = NSMutableDictionary()
    var strciurrency = ""
    
    var arrmitemlist = NSMutableArray()
    var msg = ""
    
    var strfromaid = ""
    
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
        
        self.getAllOrdersDetailsAPIMethod()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language212")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvitemlist.register(UINib(nibName: "cellorderhistoryitems", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvitemlist.separatorStyle = .none
        tabvitemlist.backgroundView=nil
        tabvitemlist.backgroundColor=UIColor.clear
        tabvitemlist.separatorColor=UIColor.clear
        tabvitemlist.showsVerticalScrollIndicator = false
        
        self.viewtop.isHidden = true
        self.lbltotalorderitems.isHidden = true
        
        lbltotalorderitems.text = myAppDelegate.changeLanguage(key: "msg_language211")
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if arrmitemlist.count == 0 {
            self.tabvitemlist.setEmptyMessage(msg)
        } else {
            self.tabvitemlist.restore()
        }
        return arrmitemlist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellorderhistoryitems
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrmitemlist.object(at: indexPath.row)as! NSDictionary
        
        let strname = String(format: "%@", dic.value(forKey: "name")as? String ?? "")
        let strqty = String(format: "%@", dic.value(forKey: "ordered_qty")as? String ?? "")
        let strprice = String(format: "%@", dic.value(forKey: "price")as! CVarArg)
        let fltprice = Float(strprice)
        let fltqty = Float(strqty)
        
        cell.lblname.text = String(format: "%@", strname)
        cell.lblprice.text = String(format: "%@ %@ %0.2f", myAppDelegate.changeLanguage(key: "msg_language213"),self.strciurrency,fltprice!)
        cell.lblqty.text = String(format: "%@ %0.0f", myAppDelegate.changeLanguage(key: "msg_language214"),fltqty!)
       
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 89.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    //MARK: - get order details API method
    func getAllOrdersDetailsAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        var strbearertoken = ""
        if strfromaid == "123"
        {
            //MAID
            strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
            print("strbearertoken",strbearertoken)
        }
        else
        {
            //CUSTOMER
            strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
            print("strbearertoken",strbearertoken)
        }
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        let parameters = ["orderid": strorder_id,"language": strLangCode] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod21)
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
                            self.viewtop.isHidden = false
                            self.lbltotalorderitems.isHidden = false
                            
                            let dic = dictemp.value(forKey: "details")as! NSDictionary
                            self.dicMOrderDetails = dic.mutableCopy() as! NSMutableDictionary
                            print("dicMOrderDetails --->",self.dicMOrderDetails)
                            //order_increment_id //order_id
                            let strorderno = String(format: "%@ #%@", myAppDelegate.changeLanguage(key: "msg_language308"),self.dicMOrderDetails.value(forKey: "order_increment_id")as? String ?? "")
                            self.lblorderno.text = strorderno
                            
                            let strorderstatus = String(format: "%@", self.dicMOrderDetails.value(forKey: "status")as? String ?? "")
                            self.lblorderstatus.text = strorderstatus
                            self.lblorderstatus.layer.cornerRadius = 4.0
                            self.lblorderstatus.layer.borderWidth = 1.0
                            self.lblorderstatus.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
                            self.lblorderstatus.layer.masksToBounds = true
                            
                            
                            if strorderstatus == "ngenius_authorised" || strorderstatus == "processing"
                            {
                                self.lblorderstatus.textColor = UIColor(named: "greencolor")!
                            }
                            else if strorderstatus == "complete"
                            {
                                self.lblorderstatus.textColor = UIColor(named: "greencolor")!
                            }
                            else if strorderstatus == "pending"
                            {
                                self.lblorderstatus.textColor = UIColor(named: "orangecolor")!
                            }
                            else if strorderstatus == "canceled"
                            {
                                self.lblorderstatus.textColor = UIColor(named: "darkredcolor")!
                            }
                            else{
                                self.lblorderstatus.textColor = UIColor.darkGray
                            }
                            
                            self.viewcustomer.layer.cornerRadius = 8.0
                            self.viewcustomer.layer.masksToBounds = true
                            
                            
                            let strgrandtotal = String(format: "%@", self.dicMOrderDetails.value(forKey: "grand_total")as? String ?? "")
                            let floatgrandtotal = Float(strgrandtotal)
                            let strgrandtotalcurrency = String(format: "%@", self.dicMOrderDetails.value(forKey: "currence_code")as? String ?? "")
                            self.lblordergrandtotal.text = String(format: "%@: %@ %0.2f ", myAppDelegate.changeLanguage(key: "msg_language86"),strgrandtotalcurrency,floatgrandtotal!)
                            self.strciurrency = strgrandtotalcurrency
                            
                            let strpaymentmethod = String(format: "%@: %@", myAppDelegate.changeLanguage(key: "msg_language402"),self.dicMOrderDetails.value(forKey: "payment_method")as? String ?? "")
                            self.lblorderpaymentmethod.text = strpaymentmethod
                            
                            let strcustomername = String(format: "%@ %@", self.dicMOrderDetails.value(forKey: "customer_firstname")as? String ?? "",self.dicMOrderDetails.value(forKey: "customer_lastname")as? String ?? "")
                            self.lblcustomername.text = strcustomername
                            
                            let strcustomeremail = String(format: "%@: %@", myAppDelegate.changeLanguage(key: "msg_language30"),self.dicMOrderDetails.value(forKey: "customer_email")as? String ?? "")
                            self.lblcustomeremail.text = strcustomeremail
                            
                            let arritem = self.dicMOrderDetails.value(forKey: "products")as? NSArray ?? []
                            self.arrmitemlist = NSMutableArray(array: arritem)
                            if self.arrmitemlist.count == 0 {
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language150")
                            }
                            self.tabvitemlist.reloadData()
                        }
                        else
                        {
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
