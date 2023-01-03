//
//  updatemyaddress.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 12/09/22.
//

import UIKit

class updatemyaddress: UIViewController,UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet var viewoverall: UIView!
    @IBOutlet var scrolloverall: UIScrollView!
    
    @IBOutlet var viewfirstname: UIView!
    @IBOutlet var txtfirstname: UITextField!
    @IBOutlet var viewlastname: UIView!
    @IBOutlet var txtlastname: UITextField!
    @IBOutlet var viewmobileno: UIView!
    @IBOutlet var txtmobileno: UITextField!
    @IBOutlet var viewlocation: UIView!
    @IBOutlet var txtlocation: UITextField!
    @IBOutlet var viewcountry: UIView!
    @IBOutlet var txtcountry: UITextField!
    @IBOutlet var viewcity: UIView!
    @IBOutlet var txtcity: UITextField!
    @IBOutlet var viewstreetaddress: UIView!
    @IBOutlet var txtstreetaddress: UITextView!
    
    @IBOutlet weak var lblpreciselocationdetails: UILabel!
    @IBOutlet weak var btncurrentlocation: UIButton!
    
    @IBOutlet weak var switchmakedefault: UISwitch!
    @IBOutlet weak var switchformaid: UISwitch!
    
    @IBOutlet weak var btnupdateaddresspopup: UIButton!
    
    @IBOutlet weak var btnremoveaddress: UIButton!
    
    var strstreetaddressfrommap = ""
    var strstreetaddressfrommapLocation = ""
    var strstreetaddressfrommapCity = ""
    
    var strSelectedLATITUDE = ""
    var strSelectedLONGITUDE = ""
    
    var strisdefaultaddress = "0"
    var strisformaid = "0"
    
    var dicAddressDetails = NSDictionary()
    
    
    var isBoolDropdown = Bool()
    let cellReuseIdentifier = "cell"
    var tblViewDropdownList: UITableView? = UITableView()
    var arrMGlobalDropdownFeed = NSMutableArray()
    
    var arrMEMIRATESLIST = NSMutableArray()
    
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
        
        print("strSelectedLATITUDE",strSelectedLATITUDE)
        print("strSelectedLONGITUDE",strSelectedLONGITUDE)
        
        if strstreetaddressfrommap != ""{
            //Fetch from MAP ADDRESS
            self.txtstreetaddress.text = strstreetaddressfrommap
            self.txtcity.text = strstreetaddressfrommapCity
            self.txtlocation.text = strstreetaddressfrommapLocation
            
        }
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Update Address Details"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .clear
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.viewoverall.frame.size.width, height: self.viewoverall.frame.size.height)
        
        btnupdateaddresspopup.layer.cornerRadius = 18.0
        btnupdateaddresspopup.layer.masksToBounds = true
        
        btnremoveaddress.layer.cornerRadius = 18.0
        btnremoveaddress.layer.masksToBounds = true
        
        btncurrentlocation.layer.cornerRadius = 6.0
        btncurrentlocation.layer.masksToBounds = true
        
        txtstreetaddress.isUserInteractionEnabled = false
        txtstreetaddress.text = "Street Address"
        txtstreetaddress.textColor = UIColor.lightGray
        txtstreetaddress.centerVertically()
        
        self.txtcountry.isUserInteractionEnabled = false
        
        self.getAvailbleEMIRATESLISTAPIMethod()
        
        strisformaid = "0"
        switchformaid.isOn = false
        
        createbordersetup()
    }
    
    //MARK: - create curve border setup method
    @objc func createbordersetup()
    {
        viewfirstname.layer.borderWidth = 1.0
        viewfirstname.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewfirstname.layer.cornerRadius = 6.0
        viewfirstname.layer.masksToBounds = true
        
        viewlastname.layer.borderWidth = 1.0
        viewlastname.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewlastname.layer.cornerRadius = 6.0
        viewlastname.layer.masksToBounds = true
        
        
        viewmobileno.layer.borderWidth = 1.0
        viewmobileno.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewmobileno.layer.cornerRadius = 6.0
        viewmobileno.layer.masksToBounds = true
        
        viewlocation.layer.borderWidth = 1.0
        viewlocation.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewlocation.layer.cornerRadius = 6.0
        viewlocation.layer.masksToBounds = true
        
        viewcountry.layer.borderWidth = 1.0
        viewcountry.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcountry.layer.cornerRadius = 6.0
        viewcountry.layer.masksToBounds = true
        
        viewcity.layer.borderWidth = 1.0
        viewcity.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewcity.layer.cornerRadius = 6.0
        viewcity.layer.masksToBounds = true
        
        viewstreetaddress.layer.borderWidth = 1.0
        viewstreetaddress.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewstreetaddress.layer.cornerRadius = 6.0
        viewstreetaddress.layer.masksToBounds = true
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,target: self, action: #selector(pressDonetxtMobilenumber))
        toolbarDone.items = [barBtnDone]
        txtmobileno.inputAccessoryView = toolbarDone
        
        
        //SET UP ADDRESS DETAILS DATA FROM  SELECTED ADDRESS
        let strfirstname = String(format: "%@", self.dicAddressDetails.value(forKey: "address_firstname")as? String ?? "")
        let strlastname = String(format: "%@", self.dicAddressDetails.value(forKey: "address_lastname")as? String ?? "")
        let strmobileno = String(format: "%@", self.dicAddressDetails.value(forKey: "telephone")as? String ?? "")
        let strcity = String(format: "%@", self.dicAddressDetails.value(forKey: "city")as? String ?? "")
        let strdefault_shipping = String(format: "%@", self.dicAddressDetails.value(forKey: "default_shipping")as! CVarArg)
        
        let dicregion = self.dicAddressDetails.value(forKey: "region")as! NSDictionary
        let strregionname = String(format: "%@", dicregion.value(forKey: "region")as? String ?? "")
        
        let strcountry_id = String(format: "%@", self.dicAddressDetails.value(forKey: "country_id")as? String ?? "")
        
        let arrstreet = (self.dicAddressDetails.value(forKey: "street")as! NSArray)
        var strfullstreet = ""
        for x in 0 ..< arrstreet.count
        {
            let tsr1 = String(format: "%@ ", arrstreet.object(at: x) as? String ?? "")
            strfullstreet = strfullstreet.appending(tsr1)
        }
        print("strfullstreet",strfullstreet)
        let strFinalAddress = String(format: "%@,%@,%@", strfullstreet,strregionname,strcountry_id)
        
        self.txtfirstname.text = strfirstname
        self.txtlastname.text = strlastname
        self.txtmobileno.text = strmobileno
        
        
        
        let strcustomattributes = (self.dicAddressDetails.value(forKey: "custom_attributes")as? NSArray ?? [])
        for ww in 0 ..< strcustomattributes.count
        {
            let dic = strcustomattributes.object(at: ww) as! NSDictionary
            let str1 = String(format: "%@ ",dic.value(forKey: "attribute_code") as? String ?? "")
            let str2 = String(format: "%@ ",dic.value(forKey: "value") as? String ?? "")
            if str1.containsIgnoreCase("latitude"){
                self.strSelectedLATITUDE = str2
            }
            
            if str1.containsIgnoreCase("longitude"){
                self.strSelectedLATITUDE = str2
            }
        }
        
        
        self.txtstreetaddress.text = strFinalAddress
        if strFinalAddress != ""{
            txtstreetaddress.textColor = UIColor.black
        }
        
        self.txtlocation.text = strregionname
        self.txtcity.text = strcity
        self.txtcountry.text = "United Arab Emirates"
        
        if strdefault_shipping == "1"{
            strisdefaultaddress = "1"
            switchmakedefault.isOn = true
        }else{
            strisdefaultaddress = "0"
            switchmakedefault.isOn = false
        }
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Done Mobile Number method
    @objc func pressDonetxtMobilenumber(sender: UIButton)
    {
        txtmobileno.resignFirstResponder()
    }
    
    //MARK: - press Remove new address method
    @IBAction func pressRemoveAddress(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "", message: "Do you want to delete this address from your address book?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [self] (action: UIAlertAction!) in
            print("Handle Continue Logic here")
            self.postDeleteAddressAPIMethod()
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - press add new address method
    @IBAction func pressupdateaddress(_ sender: Any)
    {
        if txtfirstname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your first name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlastname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your last name", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtmobileno.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your mobile number", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtstreetaddress.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your Street address", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlocation.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your location", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtcity.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your city", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtcountry.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: "Please enter your country", preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            self.postUpdateAddressAPIMethod()
        }
    }
    
    //MARK: - press make default method
    @IBAction func pressmakedefault(_ sender: Any)
    {
        if switchmakedefault.isOn == true
        {
            strisdefaultaddress = "1"
        }
        else{
            strisdefaultaddress = "0"
        }
    }
    
    //MARK: - press for maid method
    @IBAction func pressformaid(_ sender: Any)
    {
        if switchformaid.isOn == true
        {
            strisformaid = "1"
        }
        else{
            strisformaid = "0"
        }
    }
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.isEqual(txtlocation){
            txtlocation.resignFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField.isEqual(txtlocation)
        {
            self.view.endEditing(true)
            if isBoolDropdown == true {
                handleTap1()
            }else{
                //self.popupDropdown(arrFeed: arrMEMIRATESLIST, txtfld: txtlocation, tagTable: 100)
            }
            return false
        }
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
        if textField.isEqual(txtmobileno) {
            let maxLength = 10
            let currentString: NSString = txtmobileno.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    @objc private func textFieldDidChange(_ textField: UITextField)
    {
    }
    
    
    // MARK: - TextView Delegate Method
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtstreetaddress.textColor == UIColor.lightGray {
            txtstreetaddress.text = nil
            txtstreetaddress.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if txtstreetaddress.text.isEmpty {
            txtstreetaddress.text = "Street Address"
            txtstreetaddress.textColor = UIColor.lightGray
            }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - Emirates List dropdown Method
    func popupDropdown(arrFeed:NSMutableArray,txtfld:UITextField, tagTable:Int)
    {
        let point = (txtfld.superview?.convert(txtfld.frame.origin, to: self.view))! as CGPoint
        print(point.y)
        
        isBoolDropdown = true
        tblViewDropdownList = UITableView(frame: CGRect(x: self.viewlocation.frame.origin.x, y: point.y + self.viewlocation.frame.size.height, width: self.viewlocation.frame.size.width, height: 0))
        tblViewDropdownList?.delegate = self
        tblViewDropdownList?.dataSource = self
        tblViewDropdownList?.tag = tagTable
        tblViewDropdownList?.backgroundView = nil
        tblViewDropdownList?.backgroundColor = UIColor(named: "plate7")!
        tblViewDropdownList?.separatorColor = UIColor.clear
        tblViewDropdownList?.layer.borderWidth = 1.0
        tblViewDropdownList?.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        tblViewDropdownList?.layer.cornerRadius = 0.0
        tblViewDropdownList?.layer.masksToBounds = true
        tblViewDropdownList?.sectionHeaderHeight = 0
        tblViewDropdownList?.sectionFooterHeight = 0
        
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
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMEMIRATESLIST.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
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
        let strcountry_id = String(format: "%@", dictemp.value(forKey: "country_id")as? String ?? "")
        let strregion_id = String(format: "%@", dictemp.value(forKey: "region_id")as? String ?? "")
        let strregion_name = String(format: "%@", dictemp.value(forKey: "region_name")as? String ?? "")
       
        title1.text = strregion_name
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 39, width: tableView.frame.size.width, height: 1))
        lblSeparator.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        cell.contentView.addSubview(lblSeparator)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
        let strcountry_id = String(format: "%@", dictemp.value(forKey: "country_id")as? String ?? "")
        let strregion_id = String(format: "%@", dictemp.value(forKey: "region_id")as? String ?? "")
        let strregion_name = String(format: "%@", dictemp.value(forKey: "region_name")as? String ?? "")
        
        self.txtlocation.text = strregion_name
        
        handleTap1()
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
       
    }
    
    //MARK: - press Current Location Method
    @IBAction func pressCurrentlocationmethod(_ sender: Any)
    {
        let ctrl = mapaddress(nibName: "mapaddress", bundle: nil)
        ctrl.strFrompageMap = "updatemyaddress"
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    //MARK: - get Availble EMIRATES LIST API method
    func getAvailbleEMIRATESLISTAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod89)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                            if self.arrMEMIRATESLIST.count > 0{
                                self.arrMEMIRATESLIST.removeAllObjects()
                            }
                            let arrm = json.value(forKey: "detail") as? NSArray ?? []
                            self.arrMEMIRATESLIST = NSMutableArray(array: arrm)
                            print("arrMEMIRATESLIST --->",self.arrMEMIRATESLIST)
                            
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
    
    //MARK: - post Update address API Method
    func postUpdateAddressAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let straddressid = String(format: "%@", self.dicAddressDetails.value(forKey: "address_id")as! CVarArg)
        let parameters = ["addressId": straddressid,
                          "firstname": self.txtfirstname.text!,
                          "lastname": self.txtlastname.text!,
                          "telephone": self.txtmobileno.text!,
                          "street": self.txtstreetaddress.text!,
                          "region": self.txtlocation.text!,
                          "city": self.txtcity.text!,
                          "countryid": "AE",
                          "latitude": self.strSelectedLATITUDE,
                          "longitude": self.strSelectedLONGITUDE,
                          "isdefaultaddress": strisdefaultaddress,
                          "setasmaid": ""
        ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod28)
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: "Your address has been updated succesfully." , preferredStyle: UIAlertController.Style.alert)
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
    
    //MARK: - post Delete address API Method
    func postDeleteAddressAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        let straddressid = String(format: "%@", self.dicAddressDetails.value(forKey: "address_id")as! CVarArg)
        let parameters = ["addressid": straddressid] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod30)
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: "Your address has been deleted succesfully from your address book." , preferredStyle: UIAlertController.Style.alert)
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
