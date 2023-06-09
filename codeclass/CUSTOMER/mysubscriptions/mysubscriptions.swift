//
//  mysubscriptions.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 02/11/22.
//

import UIKit
import CoreData

class mysubscriptions: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var tabvmysubscription: UITableView!
    var reuseIdentifier1 = "celltabvmysubscription"
    var msg = ""
    var arrMmysubscriptions = NSMutableArray()
    
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
        
        self.getallmysubscription()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = myAppDelegate.changeLanguage(key: "msg_language273")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvmysubscription.register(UINib(nibName: "celltabvmysubscription", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmysubscription.separatorStyle = .none
        tabvmysubscription.backgroundView=nil
        tabvmysubscription.backgroundColor=UIColor.clear
        tabvmysubscription.separatorColor=UIColor.clear
        tabvmysubscription.showsVerticalScrollIndicator = false
      
        searchbar.delegate = self
        searchbar.placeholder = myAppDelegate.changeLanguage(key: "msg_language496")
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Search bar delegate method
    /*func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        //code
        print("searchText \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //code
        var namePredicate = NSPredicate(format: "subscription_increment_id contains[c] %@",  String(searchBar.text!));
        let filteredArray = self.arrMmysubscriptions.filter { namePredicate.evaluate(with: $0) };
        if filteredArray.count != 0
        {
            print("filteredArray",filteredArray)
        }
    }*/
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMmysubscriptions.count == 0 {
            self.tabvmysubscription.setEmptyMessage(msg)
        } else {
            self.tabvmysubscription.restore()
        }
        return arrMmysubscriptions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 190
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvmysubscription
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        /*
         '0' = 'Pending',
         '1' = 'Active',
         '2' = 'Paused',
         '3' = 'Expired',
         '4' = 'Cancel'
         */
        
        let dic = self.arrMmysubscriptions.object(at: indexPath.section)as! NSDictionary
        let strsubscription_id = String(format: "%@", dic.value(forKey: "subscription_id")as? String ?? "")
        let strsubscription_increment_id = String(format: "%@", dic.value(forKey: "subscription_increment_id")as? String ?? "")
        let strsubscription_plan = String(format: "%@", dic.value(forKey: "subscription_plan")as? String ?? "")
        let strsubscription_start_date = String(format: "%@", dic.value(forKey: "subscription_start_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_end_date = String(format: "%@", dic.value(forKey: "subscription_end_date")as? String ?? "DD/MM/YYYY")
        let strsubscription_status = String(format: "%@", dic.value(forKey: "subscription_status")as? String ?? "")
        let strsubscription_renewal_status = String(format: "%@", dic.value(forKey: "subscription_renewal_status")as? String ?? "")
        let strsubscription_status_code = String(format: "%@", dic.value(forKey: "subscription_status_code")as? String ?? "")
        
        let stris_renew = dic.value(forKey: "is_renew")as? Bool ?? false
        
        cell.lblsubscriptionno.text = String(format: "# %@", strsubscription_increment_id)
        cell.lblsubscriptionname.text = String(format: "%@: %@",myAppDelegate.changeLanguage(key: "msg_language74"),strsubscription_plan)
        
        cell.lblstartdate.text = String(format: "%@ %@",myAppDelegate.changeLanguage(key: "msg_language208"),strsubscription_start_date)
        cell.lblenddate.text = String(format: "%@: %@",myAppDelegate.changeLanguage(key: "msg_language299"),strsubscription_end_date)
        
        print("strsubscription_renewal_status",strsubscription_renewal_status)
        cell.lblautorenew.text = String(format: "%@: %@",myAppDelegate.changeLanguage(key: "msg_language300"),strsubscription_renewal_status)
        
        /*
         "msg_language484" = "Pending";
         "msg_language485" = "Active";
         "msg_language486" = "Paused";
         "msg_language487" = "Expired";
         "msg_language488" = "Canceled";
        
        if strsubscription_status.containsIgnoreCase("Pending"){
            cell.lblstatus.text = myAppDelegate.changeLanguage(key: "msg_language484")
        }
        else if strsubscription_status.containsIgnoreCase("Active"){
            cell.lblstatus.text = myAppDelegate.changeLanguage(key: "msg_language485")
        }
        else if strsubscription_status.containsIgnoreCase("Paused"){
            cell.lblstatus.text = myAppDelegate.changeLanguage(key: "msg_language486")
        }
        else if strsubscription_status.containsIgnoreCase("Expired"){
            cell.lblstatus.text = myAppDelegate.changeLanguage(key: "msg_language487")
        }
        else if strsubscription_status.containsIgnoreCase("Cancel"){
            cell.lblstatus.text = myAppDelegate.changeLanguage(key: "msg_language488")
        }*/
        
        cell.lblstatus.text = String(format: "%@",strsubscription_status)
        cell.lblstatus.textColor = .white
        
        if strsubscription_status_code == "0"{
            cell.lblstatus.backgroundColor =  UIColor(named: "orangecolor")!
        }else if strsubscription_status_code == "1"{
            cell.lblstatus.backgroundColor =  UIColor(named: "themecolor")!
        }else if strsubscription_status_code == "2"{
            cell.lblstatus.backgroundColor =  UIColor(named: "greencolor")!
        }else if strsubscription_status_code == "3"{
            cell.lblstatus.backgroundColor =  UIColor(named: "lightblue")!
        }else if strsubscription_status_code == "4"{
            cell.lblstatus.backgroundColor =  UIColor(named: "darkredcolor")!
        }
        
        cell.btnview.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language425")), for: .normal)
        cell.btnedit.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language73")), for: .normal)
        cell.btnrenew.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language426")), for: .normal)
        
        cell.btnview.tag = indexPath.section
        cell.btnview.addTarget(self, action: #selector(pressVIEW), for: .touchUpInside)
        
        cell.btnedit.tag = indexPath.section
        cell.btnedit.addTarget(self, action: #selector(pressEDIT), for: .touchUpInside)
        
        cell.btnrenew.tag = indexPath.section
        cell.btnrenew.addTarget(self, action: #selector(pressRENEW), for: .touchUpInside)
        
        if stris_renew == true{
            cell.btnrenew.isHidden = false
        }
        else{
            cell.btnrenew.isHidden = true
        }
        
        
        cell.lblstatus.layer.cornerRadius = 16.0
        cell.lblstatus.layer.masksToBounds = true
        
        cell.btnview.layer.cornerRadius = 18.0
        cell.btnview.layer.masksToBounds = true
        
        cell.btnedit.layer.cornerRadius = 18.0
        cell.btnedit.layer.masksToBounds = true
        
        cell.btnrenew.layer.cornerRadius = 18.0
        cell.btnrenew.layer.masksToBounds = true
        
        cell.viewcell.layer.cornerRadius = 8.0
        cell.viewcell.layer.masksToBounds = true
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        /*
         '0' = 'Pending',
         '1' = 'Active',
         '2' = 'Paused',
         '3' = 'Expired',
         '4' = 'Cancel'
         */
        
    }
    
    //MARK: - press VIEW method
    @objc func pressVIEW(sender:UIButton)
    {
        let dic = self.arrMmysubscriptions.object(at: sender.tag)as! NSDictionary
        let ctrl = mysubscriptionlineviewdetails(nibName: "mysubscriptionlineviewdetails", bundle: nil)
        ctrl.diclistvalue = dic
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press EDIT method
    @objc func pressEDIT(sender:UIButton)
    {
        let dic = self.arrMmysubscriptions.object(at: sender.tag)as! NSDictionary
        let ctrl = mysubscriptiondetails(nibName: "mysubscriptiondetails", bundle: nil)
        ctrl.diclistvalue = dic
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - press RENEW method
    @objc func pressRENEW(sender:UIButton)
    {
        let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language427"), preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            
            let dic = self.arrMmysubscriptions.object(at: sender.tag)as! NSDictionary
            let strsubscription_id = String(format: "%@", dic.value(forKey: "subscription_id")as? String ?? "")
            let strsubscription_plan_id = String(format: "%@", dic.value(forKey: "subscription_plan_id")as? String ?? "")
            self.getallRenewmysubscription(strid: strsubscription_id,strplanid:strsubscription_plan_id)
        }))
        refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - get All My subscription API method
    func getallmysubscription()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod44,strLangCode)
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
                            if self.arrMmysubscriptions.count > 0{
                                self.arrMmysubscriptions.removeAllObjects()
                            }
                            
                            let arrm = json.value(forKey: "subscription_list") as? NSArray ?? []
                            
                            //SORT ASCENDING FALSE ARRAY LIST BY SUBSCRIPTION ID //
                            //let descriptor: NSSortDescriptor = NSSortDescriptor(key: "subscription_increment_id", ascending: false)
                            //let sortedResults = arrm.sortedArray(using: [descriptor]) as NSArray
                            //let aarrm1 = NSMutableArray(array: sortedResults)
                            
                            self.arrMmysubscriptions = NSMutableArray(array: arrm)
                            print("arrMmysubscriptions --->",self.arrMmysubscriptions)
                            
                            if self.arrMmysubscriptions.count == 0{
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language206")
                            }
                            
                            self.tabvmysubscription.reloadData()
                            
                            
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
    
    //MARK: - get All My Renew subscription API method
    func getallRenewmysubscription(strid:String,strplanid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?subscriptionId=%@&renewStartDate=%@&language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod69,strid,"",strLangCode)
        print("strconnurl",strconnurl)
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
                            
                            let dicrenewdata = dictemp.value(forKey: "subscriptionRenewdata") as! NSDictionary
                            
                            self.insertallDataintoRenewdLocalBase(dicall: dicrenewdata)
                            
                            let ctrl = renewsubscriptiondetails(nibName: "renewsubscriptiondetails", bundle: nil)
                            ctrl.strsubscriptionplanid = strplanid
                            ctrl.strmainPreviousSubscriptionid = strid
                            self.navigationController?.pushViewController(ctrl, animated: true)
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
    
    //MARK: - INSERT ALL DATA INTO RENEW LOCAL DATABSE EMTHOD
    func insertallDataintoRenewdLocalBase(dicall:NSDictionary)
    {
        //Remove Renewmodel table data
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent1 = appDelegate1.persistentContainer.viewContext
        let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodel")
        fetchData1.predicate = NSPredicate(format: "userid == %@", strcustomerid)
        let objects1 = try! manageContent1.fetch(fetchData1)
        for obj in objects1 {
            manageContent1.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent1.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        //Remove Renewmodelproduct table data
        guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent2 = appDelegate2.persistentContainer.viewContext
        let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Renewmodelproduct")
        fetchData2.predicate = NSPredicate(format: "userid == %@", strcustomerid)
        let objects2 = try! manageContent2.fetch(fetchData2)
        for obj in objects2 {
            manageContent2.delete(obj as! NSManagedObject)
        }
        do {
            try manageContent2.save() // <- remember to put this :)
        } catch {
            // Do something... fatalerror
        }
        
        
        let strplanid = String(format: "%@", dicall.value(forKey: "plan_id")as? String ?? "")
        //1 Daily 2 Weekly 3 Monthly
        let arr1 = dicall.value(forKey: "subscription_order_details") as? NSArray ?? []
        
        for xx in 0 ..< arr1.count
        {
            let dictemp = arr1.object(at: xx)as? NSDictionary
            
            let strorder_date = String(format: "%@", dictemp?.value(forKey: "order_date")as? String ?? "")
            let strday = String(format: "%@", dictemp?.value(forKey: "day")as? String ?? "")
            let strday_name = String(format: "%@", dictemp?.value(forKey: "day_name")as? String ?? "")
            let strcurrency_code = String(format: "%@", dictemp?.value(forKey: "currency_code")as? String ?? "")
            let strorder_subtotal = String(format: "%@", dictemp?.value(forKey: "order_subtotal")as? String ?? "")
            let strshipping_amount = String(format: "%@", dictemp?.value(forKey: "shipping_amount")as? String ?? "")
            let strorder_grandtotal = String(format: "%@", dictemp?.value(forKey: "order_grandtotal")as? String ?? "")
            let strtax = String(format: "%@", dictemp?.value(forKey: "tax")as? String ?? "")
            let strpayment_status = String(format: "%@", dictemp?.value(forKey: "payment_status")as? String ?? "")
            
            let arr2 = dictemp?.value(forKey: "order_product") as? NSArray ?? []
            
            //------------------- INSERT INTO Renewmodel TABLE ---------------- //
            let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
            let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageContent = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Renewmodel", in: manageContent)!
            let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
            users.setValue(strplanid, forKeyPath: "subscriptionid")
            users.setValue(strcustomerid, forKeyPath: "userid")
            users.setValue(strorder_date, forKeyPath: "date")
            users.setValue(strday, forKeyPath: "day")
            users.setValue(strday_name, forKeyPath: "dayname")
            users.setValue("0", forKeyPath: "isrenew")
            users.setValue(strorder_subtotal, forKeyPath: "subtotal")
            users.setValue(strshipping_amount, forKeyPath: "shipping")
            do{
                try manageContent.save()
            }catch let error as NSError {
                print("could not save . \(error), \(error.userInfo)")
            }
            
            for yy in 0 ..< arr2.count
            {
                let dictemp = arr2.object(at: yy)as? NSDictionary
                
                let strproduct_id = String(format: "%@", dictemp?.value(forKey: "product_id")as? String ?? "")
                let strproduct_name = String(format: "%@", dictemp?.value(forKey: "product_name")as? String ?? "")
                let strproduct_price = String(format: "%@", dictemp?.value(forKey: "product_price")as? String ?? "")
                let strproduct_original_price = String(format: "%@", dictemp?.value(forKey: "product_original_price")as? String ?? "")
                let strqty = String(format: "%@", dictemp?.value(forKey: "qty")as? String ?? "")
                let strqty_all = String(format: "%@", dictemp?.value(forKey: "qty_all")as? String ?? "")
                let strdiscount_amount = String(format: "%@", dictemp?.value(forKey: "discount_amount")as? String ?? "")
                let strproduct_image = String(format: "%@", dictemp?.value(forKey: "product_image")as? String ?? "")
                 
                
                //------------------- INSERT INTO Renewmodelproduct TABLE ---------------- //
                guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                let manageContent1 = appDelegate1.persistentContainer.viewContext
                let userEntity1 = NSEntityDescription.entity(forEntityName: "Renewmodelproduct", in: manageContent1)!
                let users1 = NSManagedObject(entity: userEntity1, insertInto: manageContent1)
                users1.setValue(strplanid, forKeyPath: "subscriptionid")
                users1.setValue(strcustomerid, forKeyPath: "userid")
                users1.setValue(strorder_date, forKeyPath: "date")
                users1.setValue(strday, forKeyPath: "day")
                users1.setValue(strday_name, forKeyPath: "dayname")
                users1.setValue(strproduct_id, forKeyPath: "productid")
                users1.setValue(strproduct_image, forKeyPath: "productimage")
                users1.setValue(strproduct_name, forKeyPath: "productname")
                users1.setValue(strproduct_price, forKeyPath: "productprice")
                users1.setValue(strqty, forKeyPath: "qtyonce")
                users1.setValue(strqty_all, forKeyPath: "qtyall")
                do{
                    try manageContent1.save()
                }catch let error1 as NSError {
                    print("could not save . \(error1), \(error1.userInfo)")
                }
            }
            
        }
    }
}
