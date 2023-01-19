//
//  menuclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 20/06/22.
//

import UIKit

class menuclass: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var btnmenu: UIButton!
    @IBOutlet weak var imgvmenu: UIImageView!
    @IBOutlet weak var btnaccount: UIButton!
    @IBOutlet weak var imgvaccount: UIImageView!
    
    @IBOutlet weak var tabvlist: UITableView!
    var reuseIdentifier1 = "tabvcelllist"
    
    var arrMenu = NSMutableArray()
    var arrmAccount = NSMutableArray()
    
    var strSELECTED1 = ""
    var strSELECTED2 = ""
    
    //MARK: - press tab bar controller Did Select Method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        print("selectedIndex",selectedIndex as Any)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            if selectedIndex != 3
            {
                print("first tab bar was selected")
                strSELECTED1 = ""
                strSELECTED2 = ""
                
                if btnmenu.isSelected == true{
                    tabvlist.tag = 100
                    tabvlist.reloadData()
                }
                else{
                    tabvlist.tag = 200
                    tabvlist.reloadData()
                }
                
            }
            else {
                //do whatever
            }
        }
        else
        {
            if selectedIndex != 0
            {
                print("first tab bar was selected")
                strSELECTED1 = ""
                strSELECTED2 = ""
                
                if btnmenu.isSelected == true{
                    tabvlist.tag = 100
                    tabvlist.reloadData()
                }
                else{
                    tabvlist.tag = 200
                    tabvlist.reloadData()
                }
                
            }
            else {
                //do whatever
            }
        }
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        print("strSELECTED1",strSELECTED1)
        print("strSELECTED2",strSELECTED2)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        btnmenu.backgroundColor =  UIColor(named: "themecolor")!
        btnmenu.setTitleColor(.white, for: .normal)
        btnaccount.backgroundColor =  UIColor.white
        btnaccount.setTitleColor(.black, for: .normal)
        
        self.tabvlist.isHidden = true
        
        self.createMenuArraylist()
        
        self.createAccountArraylist()
        
        setupRTLLTR()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        tabBarController?.delegate = self
        
        tabvlist.register(UINib(nibName: "tabvcelllist", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvlist.separatorStyle = .none
        tabvlist.backgroundView=nil
        tabvlist.backgroundColor=UIColor.clear
        tabvlist.separatorColor=UIColor.clear
        tabvlist.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - setup RTL LTR method
    func setupRTLLTR()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        btnmenu.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language145")), for: .normal)
        btnaccount.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language146")), for: .normal)
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            imgvmenu.image = UIImage(named: "mn1")
            imgvaccount.image = UIImage(named: "acc1")
            
            self.btnmenu.frame = CGRect(x:0, y: self.btnmenu.frame.origin.y, width: self.btnmenu.frame.size.width, height: self.btnmenu.frame.size.height)
            self.btnaccount.frame = CGRect(x:self.btnmenu.frame.maxX, y: self.btnaccount.frame.origin.y, width: self.btnaccount.frame.size.width, height: self.btnaccount.frame.size.height)
        }
        else
        {
            imgvmenu.image = UIImage(named: "acc1")
            imgvaccount.image = UIImage(named: "mn1")
            
            self.btnaccount.frame = CGRect(x:0, y: self.btnaccount.frame.origin.y, width: self.btnaccount.frame.size.width, height: self.btnaccount.frame.size.height)
            self.btnmenu.frame = CGRect(x:self.btnaccount.frame.maxX, y: self.btnmenu.frame.origin.y, width: self.btnmenu.frame.size.width, height: self.btnmenu.frame.size.height)
            
        }
        
    }
    
    //MARK: - press Menu Button Method
    @IBAction func pressmenu(_ sender: Any) {
        
        btnmenu.backgroundColor =  UIColor(named: "themecolor")!
        btnmenu.setTitleColor(.white, for: .normal)
        
        btnaccount.backgroundColor =  UIColor.white
        btnaccount.setTitleColor(.black, for: .normal)
        
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            imgvmenu.image = UIImage(named: "mn1")
            imgvaccount.image = UIImage(named: "acc1")
        }
        else{
            imgvmenu.image = UIImage(named: "acc1")
            imgvaccount.image = UIImage(named: "mn1")
        }
        
        tabvlist.tag = 100
        tabvlist.reloadData()
    }
    
    //MARK: - press Account Button Method
    @IBAction func pressaccount(_ sender: Any) {
        
        btnaccount.backgroundColor =  UIColor(named: "themecolor")!
        btnaccount.setTitleColor(.white, for: .normal)
        
        btnmenu.backgroundColor =  UIColor.white
        btnmenu.setTitleColor(.black, for: .normal)
        
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            imgvaccount.image = UIImage(named: "acc2")
            imgvmenu.image = UIImage(named: "mn2")
        }
        else{
            imgvmenu.image = UIImage(named: "acc2")
            imgvaccount.image = UIImage(named: "mn2")
        }
        
        tabvlist.tag = 200
        tabvlist.reloadData()
    }
    
    //MARK: - create Menu Tab Array List Method
    @objc func createMenuArraylist()
    {
        if self.arrMenu.count > 0{
            self.arrMenu.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        if strbearertoken != ""
        {
            //Loggedin
            self.tabvlist.isHidden = false
            
            self.btnaccount.isHidden = false
            self.imgvaccount.isHidden = false
            
            //Home
            let dic1 = NSMutableDictionary()
            dic1.setValue("sl1.png", forKey: "image")
            dic1.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language136")), forKey: "value")
            dic1.setValue("", forKey: "id")
            self.arrMenu.add(dic1)
            
            //Order by Subscription
            let dic2 = NSMutableDictionary()
            dic2.setValue("sl2.png", forKey: "image")
            dic2.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language137")), forKey: "value")
            dic2.setValue("", forKey: "id")
            self.arrMenu.add(dic2)
            
            //Order Once
            let dic3 = NSMutableDictionary()
            dic3.setValue("sl3.png", forKey: "image")
            dic3.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language104")), forKey: "value")
            dic3.setValue("", forKey: "id")
            self.arrMenu.add(dic3)
            
            //Cart
            let dic4 = NSMutableDictionary()
            dic4.setValue("sl10.png", forKey: "image")
            dic4.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language143")), forKey: "value")
            dic4.setValue("", forKey: "id")
            self.arrMenu.add(dic4)
            
            //About Us
            let dic5 = NSMutableDictionary()
            dic5.setValue("aboutus.png", forKey: "image")
            dic5.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language280")), forKey: "value")
            dic5.setValue("", forKey: "id")
            self.arrMenu.add(dic5)
            
            //Contact Us
            let dic6 = NSMutableDictionary()
            dic6.setValue("sl11.png", forKey: "image")
            dic6.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language144")), forKey: "value")
            dic6.setValue("", forKey: "id")
            self.arrMenu.add(dic6)
            
            //Privacy Policy
            let dic7 = NSMutableDictionary()
            dic7.setValue("privacypolicy.png", forKey: "image")
            dic7.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language281")), forKey: "value")
            dic7.setValue("", forKey: "id")
            self.arrMenu.add(dic7)
            
            //Delivery Policy
            let dic8 = NSMutableDictionary()
            dic8.setValue("delverypolicy.png", forKey: "image")
            dic8.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language282")), forKey: "value")
            dic8.setValue("", forKey: "id")
            self.arrMenu.add(dic8)
            
            //Refund/ Return & Cancellation
            let dic9 = NSMutableDictionary()
            dic9.setValue("refundreturncancel.png", forKey: "image")
            dic9.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language283")), forKey: "value")
            dic9.setValue("", forKey: "id")
            self.arrMenu.add(dic9)
            
            //Terms & Conditions
            let dic10 = NSMutableDictionary()
            dic10.setValue("termsandconditions.png", forKey: "image")
            dic10.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language284")), forKey: "value")
            dic10.setValue("", forKey: "id")
            self.arrMenu.add(dic10)
            
            //Disclaimer
            let dic11 = NSMutableDictionary()
            dic11.setValue("disclaimer.png", forKey: "image")
            dic11.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language285")), forKey: "value")
            dic11.setValue("", forKey: "id")
            self.arrMenu.add(dic11)
            
            //Whatsapp
            let dic12 = NSMutableDictionary()
            dic12.setValue("whatsapp.png", forKey: "image")
            dic12.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language279")), forKey: "value")
            dic12.setValue("", forKey: "id")
            self.arrMenu.add(dic12)
        }
        else
        {
            //not loggedin
            self.tabvlist.isHidden = false
            
            self.btnaccount.isHidden = true
            self.imgvaccount.isHidden = true
            
            //Home
            let dic1 = NSMutableDictionary()
            dic1.setValue("sl1.png", forKey: "image")
            dic1.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language136")), forKey: "value")
            dic1.setValue("", forKey: "id")
            self.arrMenu.add(dic1)
            
            //Order by Subscription
            let dic2 = NSMutableDictionary()
            dic2.setValue("sl2.png", forKey: "image")
            dic2.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language137")), forKey: "value")
            dic2.setValue("", forKey: "id")
            self.arrMenu.add(dic2)
            
            //Order Once
            let dic3 = NSMutableDictionary()
            dic3.setValue("sl3.png", forKey: "image")
            dic3.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language104")), forKey: "value")
            dic3.setValue("", forKey: "id")
            self.arrMenu.add(dic3)
            
            //About Us
            let dic4 = NSMutableDictionary()
            dic4.setValue("aboutus.png", forKey: "image")
            dic4.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language280")), forKey: "value")
            dic4.setValue("", forKey: "id")
            self.arrMenu.add(dic4)
            
            //Contact Us
            let dic5 = NSMutableDictionary()
            dic5.setValue("sl11.png", forKey: "image")
            dic5.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language144")), forKey: "value")
            dic5.setValue("", forKey: "id")
            self.arrMenu.add(dic5)
            
            //Privacy Policy
            let dic6 = NSMutableDictionary()
            dic6.setValue("privacypolicy.png", forKey: "image")
            dic6.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language281")), forKey: "value")
            dic6.setValue("", forKey: "id")
            self.arrMenu.add(dic6)
            
            //Delivery Policy
            let dic7 = NSMutableDictionary()
            dic7.setValue("delverypolicy.png", forKey: "image")
            dic7.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language282")), forKey: "value")
            dic7.setValue("", forKey: "id")
            self.arrMenu.add(dic7)
            
            //Refund/ Return & Cancellation
            let dic8 = NSMutableDictionary()
            dic8.setValue("refundreturncancel.png", forKey: "image")
            dic8.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language283")), forKey: "value")
            dic8.setValue("", forKey: "id")
            self.arrMenu.add(dic8)
            
            //Terms & Conditions
            let dic9 = NSMutableDictionary()
            dic9.setValue("termsandconditions.png", forKey: "image")
            dic9.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language284")), forKey: "value")
            dic9.setValue("", forKey: "id")
            self.arrMenu.add(dic9)
            
            //Disclaimer
            let dic10 = NSMutableDictionary()
            dic10.setValue("disclaimer.png", forKey: "image")
            dic10.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language285")), forKey: "value")
            dic10.setValue("", forKey: "id")
            self.arrMenu.add(dic10)
            
            //Whatsapp
            let dic11 = NSMutableDictionary()
            dic11.setValue("whatsapp.png", forKey: "image")
            dic11.setValue(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language279")), forKey: "value")
            dic11.setValue("", forKey: "id")
            self.arrMenu.add(dic11)
            
        }
        
        self.tabvlist.tag = 100
        self.tabvlist.reloadData()
        
        //print("self.arrMenu",self.arrMenu)
    }
    
    //MARK: - create Account Tab Array List Method
    @objc func createAccountArraylist()
    {
        if self.arrmAccount.count > 0{
            self.arrmAccount.removeAllObjects()
        }
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var arr1 = NSMutableArray()
        var arr2 = NSMutableArray()
        
        arr1 = [myAppDelegate.changeLanguage(key: "msg_language122"),myAppDelegate.changeLanguage(key: "msg_language123")
                ,myAppDelegate.changeLanguage(key: "msg_language273"),myAppDelegate.changeLanguage(key: "msg_language274"),myAppDelegate.changeLanguage(key: "msg_language128")
                ,myAppDelegate.changeLanguage(key: "msg_language129"),myAppDelegate.changeLanguage(key: "msg_language131"),myAppDelegate.changeLanguage(key: "msg_language133")
                ,myAppDelegate.changeLanguage(key: "msg_language134"),myAppDelegate.changeLanguage(key: "msg_language275"),myAppDelegate.changeLanguage(key: "msg_language276")]
        
        arr2 = ["acc01.png","fav1.png","acc4.png","acc5.png","acc6.png","acc7.png","acc9.png","acc11.png","acc12.png","acc13.png","logout"]
        
        for x in 0 ..< arr1.count
        {
            let dic1 = NSMutableDictionary()
            let str1 = String(format: "%@", arr1.object(at: x)as? String ?? "")
            dic1.setValue("", forKey: "id")
            dic1.setValue(str1, forKey: "value")
            
            let str2 = String(format: "%@", arr2.object(at: x)as? String ?? "")
            dic1.setValue(str2, forKey: "image")
            
            self.arrmAccount.add(dic1)
        }
        //print("self.arrmAccount",self.arrmAccount)
    }
    
    
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tabvlist.tag == 100{
            return arrMenu.count
        }
        return arrmAccount.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tabvlist.tag == 200{
            return 1
        }
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tabvlist.tag == 200{
            
            let headerView = UIView()
            headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
            headerView.backgroundColor = UIColor.white
            return headerView
        }
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
        print("strSELECTED1",strSELECTED1)
        print("strSELECTED2",strSELECTED2)
        
        if tabvlist.tag == 100
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! tabvcelllist
            
            cell.selectionStyle=UITableViewCell.SelectionStyle.gray
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.backgroundColor = .clear
            //cell.clearsContextBeforeDrawing = true
            //cell.contentView.clearsContextBeforeDrawing = true
            
            let dic = arrMenu.object(at: indexPath.row) as! NSDictionary
            let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
            let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
            
            let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                cell.lblname.textAlignment = .left
                cell.imgvicon.frame = CGRect(x: 20, y: cell.imgvicon.frame.origin.y, width: cell.imgvicon.frame.size.width, height: cell.imgvicon.frame.size.height)
            }
            else{
                cell.lblname.textAlignment = .right
                cell.imgvicon.frame = CGRect(x: tabvlist.frame.size.width - cell.imgvicon.frame.size.width - 10, y: cell.imgvicon.frame.origin.y, width: cell.imgvicon.frame.size.width, height: cell.imgvicon.frame.size.height)
            }
            
            
            cell.lblname.text = strplanname
            
            if strplanimage.contains("https")
            {
                cell.imgvicon.contentMode = .scaleAspectFit
                cell.imgvicon.imageFromURL(urlString: strplanimage)
            }
            else{
                cell.imgvicon.contentMode = .scaleAspectFit
                cell.imgvicon.image = UIImage(named: strplanimage)
            }
            
            if strSELECTED1 == String(format: "%d", indexPath.row){
                cell.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
            }
            else{
                cell.viewcell.backgroundColor = .white
            }
            
            let lblSeparator = UILabel(frame: CGRect(x: 0, y: 53.5, width: tableView.frame.size.width, height: 0.5))
            lblSeparator.backgroundColor = UIColor.lightGray
            cell.contentView.addSubview(lblSeparator)
            
            return cell;
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! tabvcelllist
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.gray
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        //cell.clearsContextBeforeDrawing = true
        //cell.contentView.clearsContextBeforeDrawing = true
        
        let dic = arrmAccount.object(at: indexPath.row) as! NSDictionary
        let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
        let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
        
        
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
        if (strLangCode == "en")
        {
            cell.lblname.textAlignment = .left
            cell.imgvicon.frame = CGRect(x: 20, y: cell.imgvicon.frame.origin.y, width: cell.imgvicon.frame.size.width, height: cell.imgvicon.frame.size.height)
        }
        else{
            cell.lblname.textAlignment = .right
            cell.imgvicon.frame = CGRect(x: tabvlist.frame.size.width - cell.imgvicon.frame.size.width - 10, y: cell.imgvicon.frame.origin.y, width: cell.imgvicon.frame.size.width, height: cell.imgvicon.frame.size.height)
        }
        
        cell.lblname.text = strplanname
        cell.imgvicon.image = UIImage(named: strplanimage)
        
        if strSELECTED2 == String(format: "%d", indexPath.row){
            cell.viewcell.backgroundColor = UIColor(named: "lightgreencolor")!
        }
        else{
            cell.viewcell.backgroundColor = .white
        }
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 53.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if tabvlist.tag == 100
        {
            let dic = arrMenu.object(at: indexPath.row) as! NSDictionary
            print("dic",dic)
            let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
            let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
            print("strplanimage",strplanimage)
            
            self.strSELECTED1 = String(format: "%d", indexPath.row)
            self.strSELECTED2 = ""
            
            if strplanname == myAppDelegate.changeLanguage(key: "msg_language136")
            {
                //Home
                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                if (strLangCode == "en")
                {
                    self.tabBarController?.selectedIndex = 0
                }else{
                    self.tabBarController?.selectedIndex = 3
                }
                
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language137")
            {
                //Order By Subscription
                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                if (strLangCode == "en")
                {
                    self.tabBarController?.selectedIndex = 1
                }else{
                    self.tabBarController?.selectedIndex = 3
                }
                
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language104")
            {
                //Order Once
                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                if (strLangCode == "en")
                {
                    self.tabBarController?.selectedIndex = 2
                }else{
                    self.tabBarController?.selectedIndex = 2
                }
                
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language143")
            {
                //Cart
                let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
                if (strLangCode == "en")
                {
                    self.tabBarController?.selectedIndex = 3
                }else{
                    self.tabBarController?.selectedIndex = 1
                }
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language144")
            {
                //Contact Us
                let ctrl = contactus(nibName: "contactus", bundle: nil)
                ctrl.strPagename = strplanname
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language280")
            {
                //About Us
                let ctrl = cmspage(nibName: "cmspage", bundle: nil)
                ctrl.strPagename = strplanname
                ctrl.strcmsidentifier = "1001"
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language281")
            {
                //Privacy Policy
                let ctrl = cmspage(nibName: "cmspage", bundle: nil)
                ctrl.strPagename = strplanname
                ctrl.strcmsidentifier = "1002"
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language282")
            {
                //Delivery Policy
                let ctrl = cmspage(nibName: "cmspage", bundle: nil)
                ctrl.strPagename = strplanname
                ctrl.strcmsidentifier = "1003"
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language283")
            {
                //Refund/ Return & Cancellation
                let ctrl = cmspage(nibName: "cmspage", bundle: nil)
                ctrl.strPagename = strplanname
                ctrl.strcmsidentifier = "1004"
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language284")
            {
                //Terms & Conditions
                let ctrl = cmspage(nibName: "cmspage", bundle: nil)
                ctrl.strPagename = strplanname
                ctrl.strcmsidentifier = "1005"
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language285")
            {
                //Disclaimer
                let ctrl = cmspage(nibName: "cmspage", bundle: nil)
                ctrl.strPagename = strplanname
                ctrl.strcmsidentifier = "1006"
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language279")
            {
                var str = String(format: "%@ %@","Best shopping experience at Al Rawabi.","https://alrawabidairy.com/")
                str=str.addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.urlQueryAllowed))!
                //let whatsappURL = URL(string: "whatsapp://send?text=\(str)")
                //let whatsappURL = URL(string: "https://wa.me/+97333581335")
                let whatsappURL = URL(string: String(format: "%@%@", "https://wa.me/",strplanname))
                
                if UIApplication.shared.canOpenURL(whatsappURL!) {
                    UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
                } else {
                    
                    let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage")! as! CVarArg)
                    if (strLangCode == "ar"){
                        let uiAlert = UIAlertController(title: "", message: "لم يتم تثبيت Whatsapp على هذا الجهاز. يرجى تثبيت Whatsapp وإعادة المحاولة." , preferredStyle: UIAlertController.Style.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "حسنا", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                    }
                    else if (strLangCode == "en"){
                        let uiAlert = UIAlertController(title: "", message: "Whatsapp is not installed on this device. Please install Whatsapp and try again." , preferredStyle: UIAlertController.Style.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                        }))
                    }
                    
                    
                }
            }
        }
        else
        {
            
            let dic = arrmAccount.object(at: indexPath.row) as! NSDictionary
            let strplanname = String(format: "%@", dic.value(forKey: "value")as? String ?? "")
            let strplanimage = String(format: "%@", dic.value(forKey: "image")as? String ?? "")
            print("strplanimage",strplanimage)
            
            self.strSELECTED2 = String(format: "%d", indexPath.row)
            self.strSELECTED1 = ""
            
            if strplanname == myAppDelegate.changeLanguage(key: "msg_language122")
            {
                let ctrl = myprofile(nibName: "myprofile", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language123")
            {
                let ctrl = mywishlist(nibName: "mywishlist", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            /*else if strplanname == myAppDelegate.changeLanguage(key: "msg_language124")
             {
             let ctrl = myorderhistory(nibName: "myorderhistory", bundle: nil)
             self.navigationController?.pushViewController(ctrl, animated: true)
             }*/
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language273")
            {
                let ctrl = mysubscriptions(nibName: "mysubscriptions", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language274")
            {
                let ctrl = maidaccounts(nibName: "maidaccounts", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language128")
            {
                let ctrl = mywallet(nibName: "mywallet", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language129")
            {
                let ctrl = reordermyorderoncelist(nibName: "reordermyorderoncelist", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language131")
            {
                let ctrl = loyaltypointbalance(nibName: "loyaltypointbalance", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language133")
            {
                let ctrl = returnrefundslisting(nibName: "returnrefundslisting", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language134")
            {
                let ctrl = myaddresslist(nibName: "myaddresslist", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language275")
            {
                /*let ctrl = changepassword(nibName: "changepassword", bundle: nil)
                self.navigationController?.pushViewController(ctrl, animated: true)*/
                
                let obj = passwordupdatemobile(nibName: "passwordupdatemobile", bundle: nil)
                obj.strpageidentifier = "200"
                self.navigationController?.pushViewController(obj, animated: true)
            }
            else if strplanname == myAppDelegate.changeLanguage(key: "msg_language276")
            {
                let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language277"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language50"), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Delete Logic here")
                    
                    UserDefaults.standard.removeObject(forKey: "bearertoken")
                    UserDefaults.standard.synchronize()
                    
                    let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
                    print("strbearertoken",strbearertoken)
                    
                    self.dismiss(animated: true, completion: nil)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.tabSetting(type: "login")
                    // self.navigationController?.popToRootViewController(animated: true)
                    
                }))
                refreshAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language77"), style: .destructive, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
        }
    }
}
