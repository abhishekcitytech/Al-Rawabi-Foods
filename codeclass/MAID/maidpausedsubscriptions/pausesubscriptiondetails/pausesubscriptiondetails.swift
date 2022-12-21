//
//  pausesubscriptiondetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit

class pausesubscriptiondetails: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblorderno: UILabel!
    @IBOutlet weak var lblstartdate: UILabel!
    @IBOutlet weak var lblenddate: UILabel!
    @IBOutlet weak var lblrenew: UILabel!
    @IBOutlet weak var lbltype: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    

    @IBOutlet weak var btnresume: UIButton!
    
    @IBOutlet weak var viewmiddle: UIView!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblsubtotalvalue: UILabel!
    @IBOutlet weak var lblshippingamount: UILabel!
    @IBOutlet weak var lblshippingamountvalue: UILabel!
    @IBOutlet weak var lbldiscountamount: UILabel!
    @IBOutlet weak var lbldiscountamountvalue: UILabel!
    @IBOutlet weak var lblgrandtotal: UILabel!
    @IBOutlet weak var lblgrandtotalvalue: UILabel!
    
    @IBOutlet weak var tabvitems: UITableView!
    var reuseIdentifier1 = "celltabvmaiditems"
    var msg = ""
  
    var strsubscriptionid = ""
    var dicsubscriptionlist = NSDictionary()
    
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
        
        self.getallmysubscriptionDetail(strsubscriptionid: strsubscriptionid)
        
        let strsubscription_id = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_id")as? String ?? "")
        let strsubscription_increment_id = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_increment_id")as? String ?? "")
        let strsubscription_plan = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_plan")as? String ?? "")
        let strsubscription_start_date = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_start_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_end_date = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_end_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_status = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_status")as? String ?? "")
        let strsubscription_renewal_status = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_renewal_status")as? String ?? "")
        let strsubscription_status_code = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_status_code")as? String ?? "")
        let stris_renew = dicsubscriptionlist.value(forKey: "is_renew")as? Bool ?? false
        
        
        self.lblorderno.text = String(format: "# %@", strsubscription_increment_id)
        self.lblstartdate.text = String(format: "Start Date: %@", strsubscription_start_date)
        self.lblenddate.text = String(format: "End Date: %@", strsubscription_end_date)
        self.lblrenew.text = String(format: "Renew: %@", strsubscription_renewal_status)
        self.lbltype.text = String(format: "%@", strsubscription_plan)
        
        self.lblstatus.layer.cornerRadius = 14.0
        self.lblstatus.layer.masksToBounds = true
        
        self.lblstatus.text = strsubscription_status
        
        if strsubscription_status_code == "0"{
            //Pending
            lblstatus.backgroundColor =  UIColor(named: "orangecolor")!
            btnresume.isHidden = true
        }
        else if strsubscription_status_code == "1"{
            //Active
            lblstatus.backgroundColor =  UIColor(named: "themecolor")!
            btnresume.isHidden = true
        }
        else if strsubscription_status_code == "2"{
            //Paused
            lblstatus.backgroundColor =  UIColor(named: "greencolor")!
            btnresume.isHidden = false
        }
        else if strsubscription_status_code == "3"{
            //Expired
            lblstatus.backgroundColor =  UIColor(named: "lightblue")!
            btnresume.isHidden = true
        }
        else if strsubscription_status_code == "4"{
            //Cancel
            lblstatus.backgroundColor =  UIColor(named: "darkredcolor")!
            btnresume.isHidden = true
        }
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Subscription Details"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        viewtop.layer.cornerRadius = 8.0
        viewtop.layer.masksToBounds = true
        
        viewmiddle.layer.cornerRadius = 8.0
        viewmiddle.layer.masksToBounds = true
        
        btnresume.layer.cornerRadius = 8.0
        btnresume.layer.masksToBounds = true
       
        
        tabvitems.register(UINib(nibName: "celltabvmaiditems", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvitems.separatorStyle = .none
        tabvitems.backgroundView=nil
        tabvitems.backgroundColor=UIColor.clear
        tabvitems.separatorColor=UIColor.clear
        tabvitems.showsVerticalScrollIndicator = false
    
    }
    
    //MARK: - press BACK method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press RESUME  Method
    @IBAction func pressresume(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "", message: "Do you want to Resume this subscription?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            self.postPAUSERESUMEAPIMethod()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrMsubscription_order.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let dic = self.arrMsubscription_order.object(at: section)as! NSDictionary
        let arrm = dic.value(forKey: "subscription_product") as? NSArray ?? []
        return arrm.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 130
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        headerView.backgroundColor = UIColor.clear
        
        let dic = self.arrMsubscription_order.object(at: section)as! NSDictionary
        let strdate = String(format: "%@", dic.value(forKey: "subscription_order_date")as? String ?? "")
        
        let title1 = UILabel(frame: CGRect(x: 0, y: 0, width:headerView.frame.self.width, height: 44))
        title1.textAlignment = .left
        title1.textColor = UIColor(named: "themecolor")!
        title1.backgroundColor = .clear
        title1.numberOfLines = 10
        title1.font = UIFont (name: "NunitoSans-Bold", size: 14)
        title1.text = String(format: "%@", strdate)
        headerView.addSubview(title1)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvmaiditems
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        
        let dic = self.arrMsubscription_order.object(at: indexPath.section)as! NSDictionary
        let arrm = dic.value(forKey: "subscription_product") as? NSArray ?? []
        let dicitem = arrm.object(at: indexPath.row)as! NSDictionary
     
        
        let strproduct_id = String(format: "%@", dicitem.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dicitem.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dicitem.value(forKey: "sku")as? String ?? "")
        let strqty_once = String(format: "%@", dicitem.value(forKey: "qty_once")as? String ?? "")
        let strqty_all = String(format: "%@", dicitem.value(forKey: "qty_all")as? String ?? "")
        let strproduct_price = String(format: "%@", dicitem.value(forKey: "product_price")as? String ?? "")
        
        cell.lblproductname.text = strproduct_name
        cell.lblsize.text = strsku
        cell.lblprice.text = String(format: "AED %@", strproduct_price)
        cell.lbladdonce.text = String(format: "ADD ONCE: %@", strqty_once)
        cell.lbladdtoall.text = String(format: "ADD TO ALL: %@", strqty_all)
        
        cell.lbladdonce.layer.cornerRadius = 12.0
        cell.lbladdonce.layer.masksToBounds = true
        
        cell.lbladdtoall.layer.cornerRadius = 12.0
        cell.lbladdtoall.layer.masksToBounds = true
        
        cell.viewcell.layer.cornerRadius = 0.0
        cell.viewcell.layer.masksToBounds = true
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 129.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor(named: "plate7")!
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
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
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@?subscriptionid=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod82,strsubscriptionid)
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
                            let dicdetails = dictemp.value(forKey: "subscription_detail")as? NSDictionary

                            self.lblsubtotalvalue.text = String(format: "AED %@", dicdetails?.value(forKey: "subtotal")as? String ?? "")
                            self.lblshippingamountvalue.text = String(format: "AED %@", dicdetails?.value(forKey: "shipping_amount")as? String ?? "")
                            self.lbldiscountamountvalue.text = String(format: "AED %@", dicdetails?.value(forKey: "discount_amount")as? String ?? "")
                            self.lblgrandtotalvalue.text = String(format: "AED %@", dicdetails?.value(forKey: "grandtotal")as? String ?? "")
                            

                            let arrm = dicdetails!.value(forKey: "subscription_order") as? NSArray ?? []
                            self.arrMsubscription_order = NSMutableArray(array: arrm)
                            print("arrMsubscription_order --->",self.arrMsubscription_order)
                            
                            if self.arrMsubscription_order.count == 0{
                                self.msg = "No orders found!"
                            }
                            self.tabvitems.reloadData()
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
    
    //MARK: - post PAUSE / RESUME API Method
    func postPAUSERESUMEAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let strsubscription_id = String(format: "%@", dicsubscriptionlist.value(forKey: "subscription_id")as? String ?? "")
        let parameters = ["subscription_id": strsubscription_id] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod83)
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
}
