//
//  renewaddresstimeslot.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 25/11/22.
//

import UIKit

class renewaddresstimeslot: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate
{
    
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var tabvmyaddress: UITableView!
    var reuseIdentifier1 = "cellSelectShippingAddress"
    var msg = ""
    
    @IBOutlet weak var lbldeliveryslotpopupHeader: UILabel!
    @IBOutlet weak var coltimeslots: UICollectionView!
    var reuseIdentifier3 = "celltimeslots"
     
    @IBOutlet weak var btnaddnewaddress: UIButton!
    @IBOutlet weak var btnpaycheckout: UIButton!
    
   
    var arrMmyaddresslist = NSMutableArray()
    var strSelectedaddressID = ""
    
    var arrMAvailbleTimeSlots = NSMutableArray()
    var strselectedslotid = ""
    
    var strSubscriptionID = ""
    var strplanid = ""
    var strpaymentype = ""
    var strsubtotalamount = ""
    var strshippingchargesamount = ""
    var strgrandtotalamount = ""
    var strdiscountamount = ""
    var strcouponcode = ""
    var strautorenew = ""
    var dicDetails = NSDictionary()
    
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
        
        self.getAvailbleTimeSlotsAPIMethod()
        self.getcustomeraddresslist()
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = myAppDelegate.changeLanguage(key: "msg_language95")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        btnpaycheckout.layer.cornerRadius = 16.0
        btnpaycheckout.layer.masksToBounds = true
     
        tabvmyaddress.register(UINib(nibName: "cellSelectShippingAddress", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyaddress.separatorStyle = .none
        tabvmyaddress.backgroundView=nil
        tabvmyaddress.backgroundColor=UIColor.clear
        tabvmyaddress.separatorColor=UIColor.clear
        tabvmyaddress.showsVerticalScrollIndicator = false
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: coltimeslots.frame.size.width / 3.1, height: 100)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        coltimeslots.collectionViewLayout = layout
        coltimeslots.register(UINib(nibName: "celltimeslots", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier3)
        coltimeslots.showsHorizontalScrollIndicator = false
        coltimeslots.showsVerticalScrollIndicator=false
        coltimeslots.backgroundColor = .clear
        
        setupRTLLTR()
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        lbldeliveryslotpopupHeader.text = myAppDelegate.changeLanguage(key: "msg_language444")
        btnaddnewaddress.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language236")), for: .normal)
        btnpaycheckout.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language441")), for: .normal)
        
         let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
         if (strLangCode == "en")
         {
        
         }
         else
         {

         }
    }
    
    
    //MARK: - press Pay&Checkout method
    @IBAction func presspaycheckout(_ sender: Any)
    {
        if strselectedslotid.count == 0
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language317"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if strSelectedaddressID.count == 0
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language445"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else
        {
            let ctrl = renewpaymentmethodlist(nibName: "renewpaymentmethodlist", bundle: nil)
            ctrl.strSubscriptionID = strSubscriptionID
            ctrl.strpaymentype = strpaymentype
            ctrl.strautorenew = strautorenew
            ctrl.strsubtotalamount = strsubtotalamount
            ctrl.strshippingchargesamount = strshippingchargesamount
            ctrl.strgrandtotalamount = strgrandtotalamount
            ctrl.strdiscountamount = strdiscountamount
            ctrl.strcouponcode = strcouponcode
            ctrl.strplanid = strplanid
            ctrl.dicDetails = dicDetails
            ctrl.strselectedslotid = strselectedslotid
            ctrl.strSelectedaddressID = strSelectedaddressID
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
  
    //MARK: - press Add New Address Method
    @IBAction func pressAddnewaddress(_ sender: Any)
    {
        let ctrl = addnewaddress(nibName: "addnewaddress", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellSelectShippingAddress
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMmyaddresslist.object(at: indexPath.section)as! NSDictionary
        
        let straddress_id = String(format: "%@", dic.value(forKey: "address_id")as! CVarArg)
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
        
        print("strSelectedaddressID",strSelectedaddressID)
        //Check Address Selection
        if strSelectedaddressID == straddress_id
        {
            cell.imgvSelection.image = UIImage(named: "checkRadio")
        }
        else{
            cell.imgvSelection.image = UIImage(named: "uncheckRadio")
        }
        
        
        cell.switchSetdefault.tag = indexPath.section
        cell.switchSetdefault.addTarget(self, action: #selector(pressswitchSetdefault), for: .touchUpInside)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
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
    
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrMAvailbleTimeSlots.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! celltimeslots
        cellA.contentView.backgroundColor = .white
        cellA.contentView.layer.borderWidth = 1.0
        cellA.contentView.layer.cornerRadius = 0.0
        cellA.contentView.layer.borderColor = UIColor.clear.cgColor
        cellA.contentView.layer.masksToBounds = true
        
        let dict = self.arrMAvailbleTimeSlots.object(at: indexPath.row) as! NSDictionary
        let strslotid = String(format: "%@", dict.value(forKey: "interval_id")as! CVarArg)
        let strname = String(format: "%@", dict.value(forKey: "label")as? String ?? "")
        let strstart_time = String(format: "%@", dict.value(forKey: "from")as? String ?? "")
        let strend_time = String(format: "%@", dict.value(forKey: "to")as? String ?? "")
        
        
        if self.strselectedslotid == strslotid
        {
            cellA.imgvradio.image = UIImage(named: "checkRadio")
            
            cellA.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 4.0
            cellA.viewcell.layer.borderColor = UIColor(named: "greencolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        else
        {
            cellA.imgvradio.image = UIImage(named: "uncheckRadio")
            
            cellA.viewcell.backgroundColor = .white
            cellA.viewcell.layer.cornerRadius = 4.0
            cellA.viewcell.layer.borderWidth = 1.0
            cellA.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
            cellA.viewcell.layer.masksToBounds = true
        }
        
        
        if strname.containsIgnoreCase("Morning"){
            cellA.lblslotname.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language99"))
        }
        else if strname.containsIgnoreCase("Afternoon"){
            cellA.lblslotname.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language100"))
        }
        else if strname.containsIgnoreCase("Evening"){
            cellA.lblslotname.text = String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language101"))
        }
        
        //cellA.lblslotname.text = strname
        cellA.lblslottime.text = String(format: "%@ - %@", strstart_time,strend_time)
        
        cellA.viewcell.layer.cornerRadius = 6.0
        cellA.viewcell.layer.masksToBounds = true
        
        // Set up cell
        return cellA
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: coltimeslots.frame.size.width / 3.1 , height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dict = self.arrMAvailbleTimeSlots.object(at: indexPath.row) as! NSDictionary
        let strslotid = String(format: "%@", dict.value(forKey: "interval_id")as! CVarArg)
        //let strname = String(format: "%@", dict.value(forKey: "label")as? String ?? "")
        //let strstart_time = String(format: "%@", dict.value(forKey: "from")as? String ?? "")
        //let strend_time = String(format: "%@", dict.value(forKey: "to")as? String ?? "")
        
        self.strselectedslotid = strslotid
        self.coltimeslots.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
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
                            let arrm2 = NSMutableArray()
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
                                self.msg = myAppDelegate.changeLanguage(key: "msg_language446")
                            }
                            
                            if self.arrMmyaddresslist.count > 0{
                                
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
    
    //MARK: - get Availble Time Slots API method
    func getAvailbleTimeSlotsAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod72)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        //let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        //print("json string = \(jsonString)")
        //request.httpBody = jsonData as Data
        
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
                            if self.arrMAvailbleTimeSlots.count > 0{
                                self.arrMAvailbleTimeSlots.removeAllObjects()
                            }
                            let arrmproducts = json.value(forKey: "timeslot") as? NSArray ?? []
                            self.arrMAvailbleTimeSlots = NSMutableArray(array: arrmproducts)
                            //print("arrMAvailbleTimeSlots --->",self.arrMAvailbleTimeSlots)
                            
                        }
                        else{
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language270") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                       
                        self.coltimeslots.reloadData()
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
