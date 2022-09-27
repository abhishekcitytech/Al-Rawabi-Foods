//
//  myaddresslist.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class myaddresslist: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvmyaddress: UITableView!
    var reuseIdentifier1 = "cellmyaddress"
    var msg = ""
    
    @IBOutlet weak var btnaddnewaddress: UIButton!
    
    var arrMmyaddresslist = NSMutableArray()
    

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
        self.title = "My Addresses"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnaddnewaddress.layer.cornerRadius = 16.0
        btnaddnewaddress.layer.masksToBounds = true
        
        tabvmyaddress.register(UINib(nibName: "cellmyaddress", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyaddress.separatorStyle = .none
        tabvmyaddress.backgroundView=nil
        tabvmyaddress.backgroundColor=UIColor.clear
        tabvmyaddress.separatorColor=UIColor.clear
        tabvmyaddress.showsVerticalScrollIndicator = false
        
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellmyaddress
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
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.arrMmyaddresslist.object(at: indexPath.section)as! NSDictionary
        let ctrl = updatemyaddress(nibName: "updatemyaddress", bundle: nil)
        ctrl.dicAddressDetails = dic
        self.navigationController?.pushViewController(ctrl, animated: true)
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
                     //print("strstatus",strstatus)
                     //print("strsuccess",strsuccess)
                     //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strstatus == 200
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
                                self.msg = "No orders found!"
                            }
                            
                            self.tabvmyaddress.reloadData()
                            
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_servererror") , preferredStyle: UIAlertController.Style.alert)
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
