//
//  mysubscriptionlineviewproductdetails.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 15/11/22.
//

import UIKit

class mysubscriptionlineviewproductdetails: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var txttimeslot: UITextField!
    @IBOutlet weak var imgvdropdowntimeslot: UIImageView!
    
    @IBOutlet weak var tabvproductitems: UITableView!
    var reuseIdentifier1 = "celltabvproductlines"
    var msg = ""
    
    @IBOutlet weak var btnaddproduct: UIButton!
    
    
    var isBoolDropdown = Bool()
    let cellReuseIdentifier = "cell"
    var tblViewDropdownList: UITableView? = UITableView()
    var arrMGlobalDropdownFeed = NSMutableArray()
    
    var strsubscription_id = ""
    var diclistvalue = NSDictionary()
    var arrMsubscription_orderitems = NSMutableArray()
    
    var arrMAvailbleTimeSlots = NSMutableArray()
    
    var strfetchedtimeslotID = ""

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
        
        print("diclistvalue",diclistvalue)
        
        let strsubscription_order_id = String(format: "%@", diclistvalue.value(forKey: "subscription_order_id")as? String ?? "")
        let strsubscription_order_date = String(format: "%@", diclistvalue.value(forKey: "subscription_order_date")as? String ?? "")
        let strorder_status = String(format: "%@", diclistvalue.value(forKey: "order_status")as? String ?? "")
        let strsubtotal = String(format: "%@", diclistvalue.value(forKey: "subtotal")as? String ?? "")
        let strshipping_amount = String(format: "%@", diclistvalue.value(forKey: "shipping_amount")as? String ?? "")
        let strgrand_total = String(format: "%@", diclistvalue.value(forKey: "grand_total")as! CVarArg)
        let strcurrency = String(format: "%@", diclistvalue.value(forKey: "currency")as? String ?? "")
        
        strfetchedtimeslotID = String(format: "%@", diclistvalue.value(forKey: "timeslot_id")as? String ?? "")
        print("strfetchedtimeslotID",strfetchedtimeslotID)
        
        lbldate.text = String(format: "Date: %@", strsubscription_order_date)
        lblstatus.text = String(format: "%@", strorder_status)
        
        self.getAvailbleTimeSlotsAPIMethod()
        
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
        
       
        tabvproductitems.register(UINib(nibName: "celltabvproductlines", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvproductitems.separatorStyle = .none
        tabvproductitems.backgroundView=nil
        tabvproductitems.backgroundColor=UIColor.clear
        tabvproductitems.separatorColor=UIColor.clear
        tabvproductitems.showsVerticalScrollIndicator = false
        
        txttimeslot.layer.borderWidth  = 1.0
        txttimeslot.layer.borderColor  = UIColor(named: "graycustom")!.cgColor
        txttimeslot.layer.cornerRadius = 14.0
        txttimeslot.layer.masksToBounds = true
      
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Add product method
    @IBAction func pressAddProducts(_ sender: Any)
    {
        let strsubscription_order_id = String(format: "%@", diclistvalue.value(forKey: "subscription_order_id")as? String ?? "")
        let ctrl = mysubscriptionlineviewproductlist(nibName: "mysubscriptionlineviewproductlist", bundle: nil)
        ctrl.strsubscription_order_id = strsubscription_order_id
        ctrl.strsubscription_id = strsubscription_id
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == tblViewDropdownList
        {
            return 1
        }
        if arrMsubscription_orderitems.count == 0 {
            self.tabvproductitems.setEmptyMessage(msg)
        } else {
            self.tabvproductitems.restore()
        }
        return arrMsubscription_orderitems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tblViewDropdownList{
            return arrMGlobalDropdownFeed.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tblViewDropdownList{
            return 40.0
        }
        return 96
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == tblViewDropdownList{
            return 1
        }
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == tblViewDropdownList{
            return 1
        }
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == tblViewDropdownList{
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if tableView == tblViewDropdownList{
            let footerView = UIView()
            footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            footerView.backgroundColor = UIColor.clear
            return footerView
        }
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 5)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tblViewDropdownList
        {
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier:cellReuseIdentifier)
            
            cell.selectionStyle=UITableViewCell.SelectionStyle.none
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor=UIColor.white
            cell.clearsContextBeforeDrawing = true
            cell.contentView.clearsContextBeforeDrawing = true
            
            let title1 = UILabel(frame: CGRect(x: 15, y: 0, width:  (tblViewDropdownList?.frame.size.width)! - 15, height: 40))
            title1.textAlignment = .left
            title1.textColor = UIColor.black
            title1.backgroundColor = UIColor.clear
            title1.font = UIFont.systemFont(ofSize: 14)
            cell.contentView.addSubview(title1)
          
            let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
            
            let strslotid = String(format: "%@", dictemp.value(forKey: "interval_id")as! CVarArg)
            let strname = String(format: "%@", dictemp.value(forKey: "label")as? String ?? "")
            let strstart_time = String(format: "%@", dictemp.value(forKey: "from")as? String ?? "")
            let strend_time = String(format: "%@", dictemp.value(forKey: "to")as? String ?? "")
            
            title1.text = String(format: "%@ (%@ - %@)",strname,strstart_time,strend_time) as String
            
            let lblSeparator = UILabel(frame: CGRect(x: 0, y: 39, width: tableView.frame.size.width, height: 1))
            lblSeparator.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
            cell.contentView.addSubview(lblSeparator)
            
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltabvproductlines
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = self.arrMsubscription_orderitems.object(at: indexPath.section)as! NSDictionary
        
        let strproduct_id = String(format: "%@", dic.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dic.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dic.value(forKey: "sku")as? String ?? "")
        
        let strqty_once = String(format: "%@", dic.value(forKey: "qty_once")as? String ?? "")
        let strqty_all = String(format: "%@", dic.value(forKey: "qty_all")as? String ?? "")
        
        let strproduct_price = String(format: "%@", dic.value(forKey: "product_price")as? String ?? "")
        

        let int1 = Float(strqty_once)! as Float
        let int2 = Float(strqty_all)! as Float
        let intTotal = Double(int1 + int2)
        print("intTotal",intTotal)
        
        let fltprice = Float(strproduct_price)! as Float
        
        cell.lblproductname.text = String(format: "%@", strproduct_name)
        cell.lblsku.text = String(format: "SKU: %@",strsku)
        cell.lblrpice.text = String(format: "AED %0.2f",fltprice)
        
        cell.txtplusminus.text = String(format: "%0.0f", intTotal)
        
        cell.viewplusminus.backgroundColor = .white
        cell.viewplusminus.layer.cornerRadius = 14.0
        cell.viewplusminus.layer.borderWidth = 1.0
        cell.viewplusminus.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cell.viewplusminus.layer.masksToBounds = true
        
        cell.btnremove.tag = indexPath.section
        cell.btnremove.addTarget(self, action: #selector(pressRemove), for: .touchUpInside)
        
        cell.btnplus.tag = indexPath.section
        cell.btnplus.addTarget(self, action: #selector(pressPlus), for: .touchUpInside)
        
        cell.btnminus.tag = indexPath.section
        cell.btnminus.addTarget(self, action: #selector(pressMinus), for: .touchUpInside)
        
        
       
        cell.viewcell.layer.borderWidth  = 1.0
        cell.viewcell.layer.borderColor  = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.cornerRadius = 8.0
        cell.viewcell.layer.masksToBounds = true
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tblViewDropdownList
        {
            let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
            let strslotid = String(format: "%@", dictemp.value(forKey: "interval_id")as! CVarArg)
            let strname = String(format: "%@", dictemp.value(forKey: "label")as? String ?? "")
            let strstart_time = String(format: "%@", dictemp.value(forKey: "from")as? String ?? "")
            let strend_time = String(format: "%@", dictemp.value(forKey: "to")as? String ?? "")
            
            self.txttimeslot.text = String(format: "%@ (%@ - %@)", strname,strstart_time,strend_time)
            
            self.strfetchedtimeslotID = strslotid
            
            let strsubscription_order_id = String(format: "%@", diclistvalue.value(forKey: "subscription_order_id")as? String ?? "")
            
            print("strsubscription_id",strsubscription_id)
            print("strsubscription_order_id",strsubscription_order_id)
            print("self.strfetchedtimeslotID",self.strfetchedtimeslotID)
            handleTap1()

            self.postUpdateTimeSlotApiMethod(strslotid: strslotid, strsubscription_order_id: strsubscription_order_id)
        }
    }
    
    //MARK: - press Remove method
    @objc func pressRemove(sender:UIButton)
    {
        let dic = self.arrMsubscription_orderitems.object(at: sender.tag)as! NSDictionary
        let strproduct_id = String(format: "%@", dic.value(forKey: "product_id")as? String ?? "")
        
        
        let refreshAlert = UIAlertController(title: "", message: "Do you want to remove this product?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            
            let strsubscription_order_id = String(format: "%@", diclistvalue.value(forKey: "subscription_order_id")as? String ?? "")
            self.postRemoveProductApiMethod(strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - press Plus - Minus method
    @objc func pressPlus(sender:UIButton)
    {
        let dic = self.arrMsubscription_orderitems.object(at: sender.tag)as! NSDictionary
        let strproduct_id = String(format: "%@", dic.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dic.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dic.value(forKey: "sku")as? String ?? "")
        
        let strqty_once = String(format: "%@", dic.value(forKey: "qty_once")as? String ?? "")
        let strqty_all = String(format: "%@", dic.value(forKey: "qty_all")as? String ?? "")
        
        let strproduct_price = String(format: "%@", dic.value(forKey: "product_price")as? String ?? "")
        

        let int1 = Float(strqty_once)! as Float
        let int2 = Float(strqty_all)! as Float
        var intTotal = Double(int1 + int2)
        print("intTotal",intTotal)
        
        let fltprice = Float(strproduct_price)! as Float
        intTotal = intTotal + 1
        print("final qty",intTotal)
        
        let strsubscription_order_id = String(format: "%@", diclistvalue.value(forKey: "subscription_order_id")as? String ?? "")
        self.postUpdateQTYApiMethod(strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqty: String(format: "%.0f", intTotal))
    }
    @objc func pressMinus(sender:UIButton)
    {
        let dic = self.arrMsubscription_orderitems.object(at: sender.tag)as! NSDictionary
        let strproduct_id = String(format: "%@", dic.value(forKey: "product_id")as? String ?? "")
        let strproduct_name = String(format: "%@", dic.value(forKey: "product_name")as? String ?? "")
        let strsku = String(format: "%@", dic.value(forKey: "sku")as? String ?? "")
        
        let strqty_once = String(format: "%@", dic.value(forKey: "qty_once")as? String ?? "")
        let strqty_all = String(format: "%@", dic.value(forKey: "qty_all")as? String ?? "")
        
        let strproduct_price = String(format: "%@", dic.value(forKey: "product_price")as? String ?? "")
        

        let int1 = Float(strqty_once)! as Float
        let int2 = Float(strqty_all)! as Float
        var intTotal = Double(int1 + int2)
        print("intTotal",intTotal)
        
        let fltprice = Float(strproduct_price)! as Float
        
        if intTotal > 1
        {
            intTotal = intTotal - 1
            
            print("final qty",intTotal)
            
            let strsubscription_order_id = String(format: "%@", diclistvalue.value(forKey: "subscription_order_id")as? String ?? "")
            self.postUpdateQTYApiMethod(strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id, strqty: String(format: "%.0f", intTotal))
        }
        else{
            //Remove api call
            
            let strsubscription_order_id = String(format: "%@", diclistvalue.value(forKey: "subscription_order_id")as? String ?? "")
            self.postRemoveProductApiMethod(strsubscription_order_id: strsubscription_order_id, strproductid: strproduct_id)
        }
    }
    
    
    // MARK: - Time Slot List dropdown Method
    func popupDropdown(arrFeed:NSMutableArray,txtfld:UITextField, tagTable:Int)
    {
        let point = (txtfld.superview?.convert(txtfld.frame.origin, to: self.view))! as CGPoint
        print(point.y)
        
        isBoolDropdown = true
        tblViewDropdownList = UITableView(frame: CGRect(x: self.txttimeslot.frame.origin.x, y: point.y + self.txttimeslot.frame.size.height + 4, width: self.txttimeslot.frame.size.width, height: 0))
        tblViewDropdownList?.delegate = self
        tblViewDropdownList?.dataSource = self
        tblViewDropdownList?.tag = tagTable
        tblViewDropdownList?.backgroundView = nil
        tblViewDropdownList?.backgroundColor = .white
        tblViewDropdownList?.separatorColor = UIColor.clear
        tblViewDropdownList?.layer.borderWidth = 1.0
        tblViewDropdownList?.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        tblViewDropdownList?.layer.cornerRadius = 4.0
        tblViewDropdownList?.layer.masksToBounds = true
        
        self.view.addSubview(tblViewDropdownList!)
        
        arrMGlobalDropdownFeed = arrFeed
        
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewDropdownList?.frame)!
            frame.size.height =  140//UIScreen.main.bounds.size.height/2.0-64
            self.tblViewDropdownList?.frame = frame
            //print(self.tblViewDropdownList?.frame as Any)
        }, completion: nil)
    }
    func handleTap1()
    {
        isBoolDropdown = false
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewDropdownList?.frame)!
            frame.size.height = 0
            self.tblViewDropdownList?.frame = frame
        }, completion: { (nil) in
            self.tblViewDropdownList?.removeFromSuperview()
            self.tblViewDropdownList = nil
        })
    }
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField){
        if textField.isEqual(txttimeslot)
        {
            txttimeslot.resignFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField){
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField.isEqual(txttimeslot)
        {
            self.view.endEditing(true)
            if isBoolDropdown == true {
                handleTap1()
            }else{
                self.popupDropdown(arrFeed: arrMAvailbleTimeSlots, txtfld: txttimeslot, tagTable: 100)
            }
            return false
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: - get All My subscription Detail API method
    func getallmysubscriptionDetail(strsubscriptionid:String)
    {
        if arrMsubscription_orderitems.count > 0{
            arrMsubscription_orderitems.removeAllObjects()
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
                            
                            let strsubscription_order_date = String(format: "%@", self.diclistvalue.value(forKey: "subscription_order_date")as? String ?? "")
                            print("strsubscription_order_date",strsubscription_order_date)
                            
                            let dic = dictemp.value(forKey: "subscription_detail") as? NSDictionary
                            let arrm = dic!.value(forKey: "subscription_order") as? NSArray ?? []
                            for x in 0 ..< arrm.count
                            {
                                let dic = arrm.object(at: x)as? NSDictionary
                                let strdate = String(format: "%@", dic!.value(forKey: "subscription_order_date")as? String ?? "")
                                if strdate == strsubscription_order_date
                                {
                                    self.diclistvalue = dic?.mutableCopy() as! NSMutableDictionary
                                    
                                    
                                    let arrm1 = dic!.value(forKey: "subscription_product") as? NSArray ?? []
                                    self.arrMsubscription_orderitems = NSMutableArray(array: arrm1)
                                }
                            }
                            
                            if self.arrMsubscription_orderitems.count == 0{
                                self.msg = "No orders found!"
                            }
                            
                            print("diclistvalue --->",self.diclistvalue)
                            print("arrMsubscription_orderitems --->",self.arrMsubscription_orderitems)
                            
                            self.tabvproductitems.reloadData()
                            
                            
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
                            if self.arrMAvailbleTimeSlots.count > 0{
                                self.arrMAvailbleTimeSlots.removeAllObjects()
                            }
                            let arrmproducts = json.value(forKey: "timeslot") as? NSArray ?? []
                            self.arrMAvailbleTimeSlots = NSMutableArray(array: arrmproducts)
                            print("arrMAvailbleTimeSlots --->",self.arrMAvailbleTimeSlots)
                            
                            for x in 0 ..< self.arrMAvailbleTimeSlots.count
                            {
                                let dictemp = self.arrMAvailbleTimeSlots.object(at: x)as? NSDictionary
                                let strslotid = String(format: "%@", dictemp!.value(forKey: "interval_id")as! CVarArg)
                                let strname = String(format: "%@", dictemp!.value(forKey: "label")as? String ?? "")
                                let strstart_time = String(format: "%@", dictemp!.value(forKey: "from")as? String ?? "")
                                let strend_time = String(format: "%@", dictemp!.value(forKey: "to")as? String ?? "")
                            
                                if strslotid == self.strfetchedtimeslotID
                                {
                                    self.txttimeslot.text = String(format: "%@ (%@ - %@)", strname,strstart_time,strend_time)
                                }
                            }
                            
                            print("self.strfetchedtimeslotID",self.strfetchedtimeslotID)
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

    //MARK: - post Update TimeSlot API Method
    func postUpdateTimeSlotApiMethod(strslotid:String,strsubscription_order_id:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        

        let parameters = ["subscriptionId": strsubscription_id,
                          "subscriptionOrderId": strsubscription_order_id,
                          "slotId": strslotid
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod56)
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
                            let uiAlert = UIAlertController(title: "", message: "Time slot has been updated successfully.", preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
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
    
    //MARK: - post Update QTY API Method
    func postUpdateQTYApiMethod(strsubscription_order_id:String,strproductid:String,strqty:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        

        let parameters = ["subscriptionId": strsubscription_id,
                          "subscriptionOrderId": strsubscription_order_id,
                          "productId": strproductid,
                          "qty": strqty
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod57)
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
                            //Reload Over all Page
                            self.getallmysubscriptionDetail(strsubscriptionid: self.strsubscription_id)
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
    
    //MARK: - post Remove Product API Method
    func postRemoveProductApiMethod(strsubscription_order_id:String,strproductid:String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strcustomerid = UserDefaults.standard.value(forKey: "customerid")as? String ?? ""
        print("strcustomerid",strcustomerid)
        
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        

        let parameters = ["subscriptionId": strsubscription_id,
                          "subscriptionOrderId": strsubscription_order_id,
                          "productId": strproductid
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod58)
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
                            //Reload Over all Page
                            self.getallmysubscriptionDetail(strsubscriptionid: self.strsubscription_id)
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
