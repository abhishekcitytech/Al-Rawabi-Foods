//
//  addnewaddress.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class addnewaddress: UIViewController,UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource
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
    @IBOutlet weak var lblsetasdefault: UILabel!
    
    @IBOutlet weak var switchformaid: UISwitch!
    
    @IBOutlet weak var btnsaveaddresspopup: UIButton!
    
    var strstreetaddressfrommap = ""
    var strstreetaddressfrommapLocation = ""
    var strstreetaddressfrommapCity = ""
    
    var strSelectedLATITUDE = ""
    var strSelectedLONGITUDE = ""
    
    var strSELECTEDPOLYGONDETAILS = ""
    
    var strisdefaultaddress = "0"
    var strisformaid = "0"
    
    
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
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.title = myAppDelegate.changeLanguage(key: "msg_language236")
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        self.scrolloverall.backgroundColor = .clear
        self.scrolloverall.showsVerticalScrollIndicator = false
        self.scrolloverall.contentSize=CGSize(width: self.viewoverall.frame.size.width, height: self.viewoverall.frame.size.height)
        
        btnsaveaddresspopup.layer.cornerRadius = 18.0
        btnsaveaddresspopup.layer.masksToBounds = true
        
        btncurrentlocation.layer.cornerRadius = 6.0
        btncurrentlocation.layer.masksToBounds = true
        
        self.txtcountry.isUserInteractionEnabled = false
        self.txtcountry.text = "United Arab Emirates"
        
        strisdefaultaddress = "0"
        switchmakedefault.isOn = false
        strisformaid = "0"
        switchformaid.isOn = false
        
        self.getAvailbleEMIRATESLISTAPIMethod()
        
        createbordersetup()
        
        setupRTLLTR()
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
         let myAppDelegate = UIApplication.shared.delegate as! AppDelegate

        
        lblpreciselocationdetails.text = myAppDelegate.changeLanguage(key: "msg_language387")
        btncurrentlocation.setTitle(String(format: "   %@", myAppDelegate.changeLanguage(key: "msg_language388")), for: .normal)
        
        txtfirstname.placeholder = myAppDelegate.changeLanguage(key: "msg_language28")
        txtlastname.placeholder = myAppDelegate.changeLanguage(key: "msg_language29")
        txtmobileno.placeholder = myAppDelegate.changeLanguage(key: "msg_language31")
        txtlocation.placeholder = myAppDelegate.changeLanguage(key: "msg_language389")
        txtcountry.placeholder = myAppDelegate.changeLanguage(key: "msg_language248")
        txtcity.placeholder = myAppDelegate.changeLanguage(key: "msg_language247")
        
        lblsetasdefault.text = myAppDelegate.changeLanguage(key: "msg_language120")
        
        btnsaveaddresspopup.setTitle(String(format: "   %@", myAppDelegate.changeLanguage(key: "msg_language250")), for: .normal)
        

         let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
         if (strLangCode == "en")
         {
        
         }
         else
         {

         }
    }
    
    //MARK: - create curve border setup method
    @objc func createbordersetup()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
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
        
        txtstreetaddress.isUserInteractionEnabled = false
        txtstreetaddress.text = myAppDelegate.changeLanguage(key: "msg_language237")
        txtstreetaddress.textColor = UIColor.lightGray
        txtstreetaddress.centerVertically()
      
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
    
    //MARK: - press add new address method
    @IBAction func pressaddnewaddress(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtfirstname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language6"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlastname.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language239"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtmobileno.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language9"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtstreetaddress.text == "" || txtstreetaddress.text == myAppDelegate.changeLanguage(key: "msg_language237")
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language241"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtlocation.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language393"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtcity.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language243"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else if txtcountry.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language244"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            self.postAddNewAddressAPIMethod()
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
            let maxLength = 9 //FIXMESANDIPAN
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
    func textViewDidEndEditing(_ textVi5ew: UITextView)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        if txtstreetaddress.text.isEmpty {
            txtstreetaddress.text = myAppDelegate.changeLanguage(key: "msg_language237")
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
        //let strcountry_id = String(format: "%@", dictemp.value(forKey: "country_id")as? String ?? "")
        //let strregion_id = String(format: "%@", dictemp.value(forKey: "region_id")as? String ?? "")
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
        //let strcountry_id = String(format: "%@", dictemp.value(forKey: "country_id")as? String ?? "")
        //let strregion_id = String(format: "%@", dictemp.value(forKey: "region_id")as? String ?? "")
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
        ctrl.strFrompageMap = "addnewaddress"
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
        print("strconnurl",strconnurl)
        
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
    
    //MARK: - post add new address API Method
    func postAddNewAddressAPIMethod()
    {
        print("strSelectedLATITUDE",self.strSelectedLATITUDE)
        print("strSelectedLONGITUDE",self.strSelectedLONGITUDE)
        print("strSelectedLONGITUDE",self.strSELECTEDPOLYGONDETAILS)
        
        let result = self.strSELECTEDPOLYGONDETAILS.split(separator: "+")
        let strpolygonid = String(format: "%@", result[0]as CVarArg)
        let strpolygonname = String(format: "%@", result[1]as CVarArg)
        let strpolygonemirates = String(format: "%@", result[2]as CVarArg)
        print("strpolygonid",strpolygonid)
        print("strpolygonname",strpolygonname)
        print("strpolygonemirates",strpolygonemirates)
        
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
       
        let parameters = ["firstname": self.txtfirstname.text!,
                          "lastname": self.txtlastname.text!,
                          "telephone": self.txtmobileno.text!,
                          "street": self.txtstreetaddress.text!,
                          "region": self.txtlocation.text!,
                          "city": self.txtcity.text!,
                          "countryid": "AE",
                          "latitude": self.strSelectedLATITUDE,
                          "longitude": self.strSelectedLONGITUDE,
                          "isdefaultaddress": strisdefaultaddress,
                          "setasmaid": "",
                          "locationId": strpolygonid
                          ] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod25)
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
                    print("strstatus",strstatus)
                    print("strsuccess",strsuccess)
                    print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language394") , preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                                self.navigationController?.popViewController(animated: true)
                            }))

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
    

}
extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
