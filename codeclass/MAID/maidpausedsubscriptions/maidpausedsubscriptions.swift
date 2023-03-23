//
//  maidpausedsubscriptions.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/11/22.
//

import UIKit

class maidpausedsubscriptions: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var viewoverall: UIView!

    @IBOutlet weak var tabvmysubscription: UITableView!
    var reuseIdentifier1 = "celltabvmaidsubscriptionlist"
    var msg = ""
    var arrMmysubscriptions = NSMutableArray()

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
        
        getallmysubscription()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.title = myAppDelegate.changeLanguage(key: "msg_language295")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvmysubscription.register(UINib(nibName: "celltabvmaidsubscriptionlist", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
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
        return 150
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvmaidsubscriptionlist
        
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
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        
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
        cell.lblsubscriptionname.text = String(format: "%@",strsubscription_plan)
        
        cell.lblstartdate.text = String(format: "%@: %@",myAppDelegate.changeLanguage(key: "msg_language208"),strsubscription_start_date)
        cell.lblenddate.text = String(format: "%@: %@",myAppDelegate.changeLanguage(key: "msg_language299"),strsubscription_end_date)
        
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
        
        cell.lblstatus.layer.cornerRadius = 16.0
        cell.lblstatus.layer.masksToBounds = true
        
        cell.viewcell.layer.cornerRadius = 8.0
        cell.viewcell.layer.masksToBounds = true
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dic = self.arrMmysubscriptions.object(at: indexPath.section)as! NSDictionary
        let strsubscription_id = String(format: "%@", dic.value(forKey: "subscription_id")as? String ?? "")
        
        let obj = pausesubscriptiondetails(nibName: "pausesubscriptiondetails", bundle: nil)
        obj.strsubscriptionid = strsubscription_id
        obj.dicsubscriptionlist = dic
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    //MARK: - get All My subscription API method
    func getallmysubscription()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
        print("strbearertoken",strbearertoken)
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        var strconnurl = String()
        strconnurl = String(format: "%@%@?language=%@", Constants.conn.ConnUrl, Constants.methodname.apimethod81,strLangCode)
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
                            if self.arrMmysubscriptions.count > 0{
                                self.arrMmysubscriptions.removeAllObjects()
                            }
                            
                            let arrm = json.value(forKey: "subscription_list") as? NSArray ?? []
                            
                            //SORT ASCENDING FALSE ARRAY LIST BY SUBSCRIPTION ID //
                            //let descriptor: NSSortDescriptor = NSSortDescriptor(key: "subscription_id", ascending: false)
                            //let sortedResults = arrm.sortedArray(using: [descriptor]) as NSArray
                            //let aarrm1 = NSMutableArray(array: sortedResults)
                            
                            self.arrMmysubscriptions = NSMutableArray(array: arrm)
                            print("arrMmysubscriptions --->",self.arrMmysubscriptions)
                            
                            if self.arrMmysubscriptions.count == 0{
                                self.msg = "No orders found!"
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
}
