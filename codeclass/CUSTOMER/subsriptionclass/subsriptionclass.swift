//
//  subsriptionclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 20/06/22.
//

import UIKit
import CoreData

class subsriptionclass: BaseViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewdeliveryaddress: UIView!
    @IBOutlet weak var txtdeliveryaddress: UITextField!
    @IBOutlet weak var imgvlocation: UIImageView!
    
    @IBOutlet weak var lblhowto: UILabel!
    
    @IBOutlet weak var viewplan: UIView!
    @IBOutlet weak var tabvplan: UITableView!
    var reuseIdentifier1 = "tabvcellplan"
    
    @IBOutlet weak var lblor: UILabel!
    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var btnbuynow: UIButton!
    
    var arrMplan = NSMutableArray()
    
    var strpreSelectedplanfromHome = ""
    
    var strfromContinuehsopping = ""
    
    
    var strstreetaddressfrommapSUBSCRIPTION = ""
    var strstreetaddressfrommapLocationSUBSCRIPTION = ""
    var strstreetaddressfrommapCitySUBSCRIPTION = ""
    
    
    var strSelectedplanCurrently = ""
    
    
    var isBoolDropdown = Bool()
    let cellReuseIdentifier = "cell"
    var tblViewDropdownList: UITableView? = UITableView()
    var arrMGlobalDropdownFeed = NSMutableArray()
    
    var arrMALLLOCATIONS = NSMutableArray()
    
    
    
    lazy var titleStackView: UIStackView = {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "themecolor")
        titleLabel.font = UIFont(name: "NunitoSans-Bold", size: 17)
        titleLabel.text = myAppDelegate.changeLanguage(key: "msg_language74")
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        return stackView
    }()
    
    
    /*var shortStringSubscription = ""
     override func awakeFromNib() {
     
     self.tabBarController?.tabBarItem.title = shortStringSubscription
     }
     
     //MARK: - press tab bar controller Did Select Method
     func tabBarController(_ tabBarController: UITabBarController,shouldSelect viewController: UIViewController) -> Bool
     {
     let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
     print("selectedIndex",selectedIndex as Any)
     return true
     }
     func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
     {
     let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
     print("selectedIndex",selectedIndex as Any)
     
     let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
     if (strLangCode == "en")
     {
     if selectedIndex == 1{
     let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
     let trimToCharacter = 6
     shortStringSubscription = String(myAppDelegate.changeLanguage(key: "msg_language74").prefix(trimToCharacter))
     
     }
     }
     else{
     if selectedIndex == 3{
     let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
     let trimToCharacter = 6
     shortStringSubscription = String(myAppDelegate.changeLanguage(key: "msg_language74").prefix(trimToCharacter))
     
     }
     }
     }*/
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        
        if strstreetaddressfrommapSUBSCRIPTION != ""{
            self.txtdeliveryaddress.text = strstreetaddressfrommapSUBSCRIPTION
        }
        
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.getAvailbleLOCATIONSLISTAPIMethod()
        
        fetchDataDAILYSubscriptionmodelTable()
        fetchDataWEEKLYSubscriptionmodelTable()
        fetchDataMONTHLYSubscriptionmodelTable()
        
        print("strpreSelectedplanfromHome",strpreSelectedplanfromHome)
        if strpreSelectedplanfromHome.count > 0
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // your code here
                if self.strpreSelectedplanfromHome == "Daily"
                {
                    self.strpreSelectedplanfromHome = ""
                    
                    self.strSelectedplanCurrently = "1"
                    self.insertSubscriptionmodelTable(strplanname: "Daily", strplanid: "1")
                    
                    let ctrl = subscriptionmodel(nibName: "subscriptionmodel", bundle: nil)
                    ctrl.strplanname = "Daily"
                    self.navigationController?.pushViewController(ctrl, animated: true)
                    
                }
                else if self.strpreSelectedplanfromHome == "Weekly"
                {
                    self.strpreSelectedplanfromHome = ""
                    
                    self.strSelectedplanCurrently = "2"
                    self.insertSubscriptionmodelTable(strplanname: "Weekly", strplanid: "2")
                    
                    let ctrl = subscriptionmodelweekly(nibName: "subscriptionmodelweekly", bundle: nil)
                    ctrl.strplanname = "Weekly"
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                else if self.strpreSelectedplanfromHome == "Monthly"
                {
                    self.strpreSelectedplanfromHome = ""
                    
                    self.strSelectedplanCurrently = "3"
                    self.insertSubscriptionmodelTable(strplanname: "Monthly", strplanid: "3")
                    
                    let ctrl = subscriptionmodelmonthly(nibName: "subscriptionmodelmonthly", bundle: nil)
                    ctrl.strplanname = "Monthly"
                    self.navigationController?.pushViewController(ctrl, animated: true)
                    
                }
            }
        }
        
        
        if strfromContinuehsopping == "1"{
            strfromContinuehsopping = ""
            self.tabvplan.reloadData()
            self.tabBarController?.selectedIndex = 0
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if view.traitCollection.horizontalSizeClass == .compact {
            titleStackView.axis = .vertical
            titleStackView.spacing = UIStackView.spacingUseDefault
        } else {
            titleStackView.axis = .horizontal
            titleStackView.spacing = 20.0
        }
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        //self.title = myAppDelegate.changeLanguage(key: "msg_language478")
        
        navigationItem.titleView = titleStackView
        
        
        //tabBarController?.delegate = self
        
        //let searchicon = UIImage(named: "search")
        //let search = UIBarButtonItem(image: searchicon, style: .plain, target: self, action: #selector(pressSearch))
        //search.tintColor = UIColor.black
        //self.navigationItem.leftBarButtonItem = search
        
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cartbag"), for: .normal)
        button.addTarget(self, action: #selector(presscartbag), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        //self.navigationItem.rightBarButtonItem = barButton
        
        viewdeliveryaddress.layer.cornerRadius = 4.0
        viewdeliveryaddress.layer.borderWidth = 1.0
        viewdeliveryaddress.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        viewdeliveryaddress.layer.masksToBounds = true
        
        btnbuynow.layer.cornerRadius = 20.0
        btnbuynow.layer.borderWidth = 2.0
        btnbuynow.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        btnbuynow.layer.masksToBounds = true
        
        //FIXME
        arrMplan = ["Daily","Weekly","Monthly"]
        
        tabvplan.register(UINib(nibName: "tabvcellplan", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvplan.separatorStyle = .none
        tabvplan.backgroundView=nil
        tabvplan.backgroundColor=UIColor.clear
        tabvplan.separatorColor=UIColor.clear
        tabvplan.showsVerticalScrollIndicator = false
        
        lblhowto.text = String(format: "%@\n%@", myAppDelegate.changeLanguage(key: "msg_language54"),myAppDelegate.changeLanguage(key: "msg_language55"))
        lblor.text = myAppDelegate.changeLanguage(key: "msg_language19")
        btnbuynow.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language44")), for: .normal)
        
    }
    
    //MARK: - press Search method
    /*@objc func pressSearch()
     {
     let ctrl = searchproductlist(nibName: "searchproductlist", bundle: nil)
     self.navigationController?.pushViewController(ctrl, animated: true)
     }*/
    
    //MARK: - press Cartbag method
    @objc func presscartbag()
    {
        let ctrl = subscriptionorderreview(nibName: "subscriptionorderreview", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.isEqual(txtdeliveryaddress){
            txtdeliveryaddress.resignFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField.isEqual(txtdeliveryaddress)
        {
            /*self.view.endEditing(true)
             let ctrl = mapaddress(nibName: "mapaddress", bundle: nil)
             ctrl.strFrompageMap = "subsriptionclass"
             self.navigationController?.pushViewController(ctrl, animated: true)
             
             let ctrl = mapaddressgoogle(nibName: "mapaddressgoogle", bundle: nil)
             ctrl.strFrompageMap = "subsriptionclass"
             self.navigationController?.pushViewController(ctrl, animated: true)
             
             return false*/
            
            self.view.endEditing(true)
            if isBoolDropdown == true {
                handleTap1()
            }else{
                self.popupDropdown(arrFeed: arrMALLLOCATIONS, txtfld: txtdeliveryaddress, tagTable: 100)
            }
            return false
        }
        return true
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
    
    // MARK: - Location List dropdown Method
    func popupDropdown(arrFeed:NSMutableArray,txtfld:UITextField, tagTable:Int)
    {
        let point = (txtfld.superview?.convert(txtfld.frame.origin, to: self.view))! as CGPoint
        print(point.y)
        
        isBoolDropdown = true
        tblViewDropdownList = UITableView(frame: CGRect(x: self.viewdeliveryaddress.frame.origin.x, y: point.y + self.viewdeliveryaddress.frame.size.height, width: self.viewdeliveryaddress.frame.size.width, height: 0))
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
        if tableView == tblViewDropdownList{
            return 1
        }
        return arrMplan.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == tblViewDropdownList{
            return arrMALLLOCATIONS.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblViewDropdownList{
            return 40
        }
        return 122
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblViewDropdownList{
            return 1
        }
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == tblViewDropdownList{
            return 1
        }
        return 10
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
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
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
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
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
            let strvalue = String(format: "%@", dictemp.value(forKey: "value")as! CVarArg)
            let strlabel = String(format: "%@", dictemp.value(forKey: "label")as? String ?? "")
            
            title1.text = strlabel
            
            let lblSeparator = UILabel(frame: CGRect(x: 0, y: 39, width: tableView.frame.size.width, height: 1))
            lblSeparator.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
            cell.contentView.addSubview(lblSeparator)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! tabvcellplan
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let strplanname = arrMplan.object(at: indexPath.section) as? String ?? ""
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if strplanname == "Daily"{
            cell.lbl1.text = myAppDelegate.changeLanguage(key: "msg_language37")
            cell.lbl2.text = myAppDelegate.changeLanguage(key: "msg_language40")
        }
        else if strplanname == "Weekly"{
            cell.lbl1.text = myAppDelegate.changeLanguage(key: "msg_language38")
            cell.lbl2.text = myAppDelegate.changeLanguage(key: "msg_language41")
        }
        else if strplanname == "Monthly"{
            cell.lbl1.text = myAppDelegate.changeLanguage(key: "msg_language39")
            cell.lbl2.text = myAppDelegate.changeLanguage(key: "msg_language384")
        }
        
        cell.lbl1.textColor = .black
        cell.lbl2.textColor = .black
        cell.lblselect.textColor = UIColor(named: "themecolor")!
        
        cell.lblselect.layer.cornerRadius = 14.0
        cell.lblselect.layer.borderWidth = 1.0
        cell.lblselect.layer.borderColor = UIColor(named: "themecolor")!.cgColor
        cell.lblselect.layer.masksToBounds = true
        
        print("self.strSelectedplanCurrently",self.strSelectedplanCurrently)
        
        if self.strSelectedplanCurrently == "1"{
            //Daily Selected
            if strplanname == "Daily"
            {
                cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language57")
                cell.viewcell.backgroundColor = UIColor(named: "greencolor")!
                cell.lbl1.textColor = .white
                cell.lbl2.textColor = .white
                cell.lblselect.textColor = .white
                cell.lblselect.layer.cornerRadius = 14.0
                cell.lblselect.layer.borderWidth = 1.0
                cell.lblselect.layer.borderColor = UIColor.white.cgColor
                cell.lblselect.layer.masksToBounds = true
            }
            else
            {
                cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language56")
                cell.viewcell.backgroundColor = UIColor.white
                cell.viewcell.layer.masksToBounds = false
                cell.viewcell.layer.cornerRadius = 0.0
                cell.viewcell.layer.borderColor = UIColor.white.cgColor
                cell.viewcell.layer.borderWidth = 1.0
                cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
                cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                cell.viewcell.layer.shadowOpacity = 1.0
                cell.viewcell.layer.shadowRadius = 6.0
            }
        }
        else if self.strSelectedplanCurrently == "2"{
            //Weekly Selected
            if strplanname == "Weekly"
            {
                cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language57")
                cell.viewcell.backgroundColor = UIColor(named: "greencolor")!
                cell.lbl1.textColor = .white
                cell.lbl2.textColor = .white
                cell.lblselect.textColor = .white
                cell.lblselect.layer.cornerRadius = 14.0
                cell.lblselect.layer.borderWidth = 1.0
                cell.lblselect.layer.borderColor = UIColor.white.cgColor
                cell.lblselect.layer.masksToBounds = true
            }
            else
            {
                cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language56")
                cell.viewcell.backgroundColor = UIColor.white
                cell.viewcell.layer.masksToBounds = false
                cell.viewcell.layer.cornerRadius = 0.0
                cell.viewcell.layer.borderColor = UIColor.white.cgColor
                cell.viewcell.layer.borderWidth = 1.0
                cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
                cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                cell.viewcell.layer.shadowOpacity = 1.0
                cell.viewcell.layer.shadowRadius = 6.0
            }
        }
        else if self.strSelectedplanCurrently == "3"{
            //Monthly Selected
            if strplanname == "Monthly"
            {
                cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language57")
                cell.viewcell.backgroundColor = UIColor(named: "greencolor")!
                cell.lbl1.textColor = .white
                cell.lbl2.textColor = .white
                cell.lblselect.textColor = .white
                cell.lblselect.layer.cornerRadius = 14.0
                cell.lblselect.layer.borderWidth = 1.0
                cell.lblselect.layer.borderColor = UIColor.white.cgColor
                cell.lblselect.layer.masksToBounds = true
            }
            else
            {
                cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language56")
                cell.viewcell.backgroundColor = UIColor.white
                cell.viewcell.layer.masksToBounds = false
                cell.viewcell.layer.cornerRadius = 0.0
                cell.viewcell.layer.borderColor = UIColor.white.cgColor
                cell.viewcell.layer.borderWidth = 1.0
                cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
                cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                cell.viewcell.layer.shadowOpacity = 1.0
                cell.viewcell.layer.shadowRadius = 6.0
            }
        }
        else
        {
            cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language56")
            cell.viewcell.backgroundColor = UIColor.white
            cell.viewcell.layer.masksToBounds = false
            cell.viewcell.layer.cornerRadius = 0.0
            cell.viewcell.layer.borderColor = UIColor.white.cgColor
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
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        if tableView == tblViewDropdownList
        {
            let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
            let strvalue = String(format: "%@", dictemp.value(forKey: "value")as! CVarArg)
            let strlabel = String(format: "%@", dictemp.value(forKey: "label")as? String ?? "")
            
            self.txtdeliveryaddress.tag = Int(strvalue)!
            self.txtdeliveryaddress.text = strlabel
            
            UserDefaults.standard.set(strlabel, forKey: "loggedinusersavedlocationname")
            UserDefaults.standard.set(strvalue, forKey: "loggedinusersavedlocationid")
            UserDefaults.standard.synchronize()
            handleTap1()
        }
        else
        {
            let strplanname = arrMplan.object(at: indexPath.section) as? String ?? ""
            
            let cell = tabvplan.cellForRow(at: indexPath)as! tabvcellplan
            
            cell.lblselect.text = myAppDelegate.changeLanguage(key: "msg_language57")
            cell.viewcell.backgroundColor = UIColor(named: "greencolor")!
            cell.lbl1.textColor = .white
            cell.lbl2.textColor = .white
            cell.lblselect.textColor = .white
            cell.lblselect.layer.cornerRadius = 14.0
            cell.lblselect.layer.borderWidth = 1.0
            cell.lblselect.layer.borderColor = UIColor.white.cgColor
            cell.lblselect.layer.masksToBounds = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // your code here
                
                if strplanname == "Daily"
                {
                    self.strSelectedplanCurrently = "1"
                    self.insertSubscriptionmodelTable(strplanname: "Daily", strplanid: "1")
                    
                    let ctrl = subscriptionmodel(nibName: "subscriptionmodel", bundle: nil)
                    ctrl.strplanname = strplanname
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                else if strplanname == "Weekly"
                {
                    self.strSelectedplanCurrently = "2"
                    self.insertSubscriptionmodelTable(strplanname: "Weekly", strplanid: "2")
                    
                    let ctrl = subscriptionmodelweekly(nibName: "subscriptionmodelweekly", bundle: nil)
                    ctrl.strplanname = strplanname
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                else if strplanname == "Monthly"
                {
                    self.strSelectedplanCurrently = "3"
                    self.insertSubscriptionmodelTable(strplanname: "Monthly", strplanid: "3")
                    
                    let ctrl = subscriptionmodelmonthly(nibName: "subscriptionmodelmonthly", bundle: nil)
                    ctrl.strplanname = strplanname
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        
    }
    
    
    
    //MARK: - press Buy Once Method
    @IBAction func pressbuynow(_ sender: Any) {
        
    }
    
    
    //MARK: - Fetch SubscriptionmodelTable data Daily exist or not
    func fetchDataDAILYSubscriptionmodelTable()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,"Daily")
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            if result.count > 0
            {
                self.tabvplan.isUserInteractionEnabled = false
                self.strSelectedplanCurrently = "1"
                self.tabvplan.reloadData()
                
                let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language325"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language49")), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")
                    
                    /*self.strSelectedplanCurrently = "1"
                     let ctrl = subscriptionmodel(nibName: "subscriptionmodel", bundle: nil)
                     ctrl.strplanname = "Daily"
                     self.navigationController?.pushViewController(ctrl, animated: true)*/
                    
                    //Remove Subscriptionmodel table data
                    let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
                    guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent1 = appDelegate1.persistentContainer.viewContext
                    let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
                    fetchData1.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"1")
                    let objects1 = try! manageContent1.fetch(fetchData1)
                    for obj in objects1 {
                        manageContent1.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent1.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    //Remove Dailymodel table data
                    guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent2 = appDelegate2.persistentContainer.viewContext
                    let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailymodel")
                    fetchData2.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"1")
                    let objects2 = try! manageContent2.fetch(fetchData2)
                    for obj in objects2 {
                        manageContent2.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent2.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    //Remove Dailyproduct table data
                    guard let appDelegate3 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent3 = appDelegate3.persistentContainer.viewContext
                    let fetchData3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dailyproduct")
                    let objects3 = try! manageContent3.fetch(fetchData3)
                    for obj in objects3 {
                        manageContent3.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent3.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    self.strSelectedplanCurrently = ""
                    self.tabvplan.reloadData()
                    self.tabvplan.isUserInteractionEnabled = true
                    
                    
                    
                }))
                self.present(refreshAlert, animated: true, completion: nil)
            }
            else{
                self.strSelectedplanCurrently = ""
                self.tabvplan.reloadData()
                self.tabvplan.isUserInteractionEnabled = true
            }
        }catch {
            print("err")
            self.strSelectedplanCurrently = ""
            self.tabvplan.reloadData()
            self.tabvplan.isUserInteractionEnabled = true
        }
        
        let strpaymentcompleted = UserDefaults.standard.value(forKey: "paymentcompleted")as? String ?? ""
        print("strpaymentcompleted",strpaymentcompleted)
        if strpaymentcompleted == "2"{
            UserDefaults.standard.removeObject(forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                self.tabBarController?.selectedIndex = 0
            }
            else
            {
                self.tabBarController?.selectedIndex = 4
            }
        }
    }
    
    //MARK: - Fetch SubscriptionmodelTable data Weekly exist or not
    func fetchDataWEEKLYSubscriptionmodelTable()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,"Weekly")
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            if result.count > 0
            {
                self.tabvplan.isUserInteractionEnabled = false
                self.strSelectedplanCurrently = "2"
                self.tabvplan.reloadData()
                
                let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language326"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language49")), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")
                    
                    /*self.strSelectedplanCurrently = "2"
                     let ctrl = subscriptionmodelweekly(nibName: "subscriptionmodelweekly", bundle: nil)
                     ctrl.strplanname = "Weekly"
                     self.navigationController?.pushViewController(ctrl, animated: true)*/
                    
                    //Remove Subscriptionmodel table data
                    let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
                    guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent1 = appDelegate1.persistentContainer.viewContext
                    let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
                    fetchData1.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"2")
                    let objects1 = try! manageContent1.fetch(fetchData1)
                    for obj in objects1 {
                        manageContent1.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent1.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    //Remove Weeklymodel table data
                    guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent2 = appDelegate2.persistentContainer.viewContext
                    let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklymodel")
                    fetchData2.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"2")
                    let objects2 = try! manageContent2.fetch(fetchData2)
                    for obj in objects2 {
                        manageContent2.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent2.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    //Remove Weeklyproduct table data
                    guard let appDelegate3 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent3 = appDelegate3.persistentContainer.viewContext
                    let fetchData3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weeklyproduct")
                    let objects3 = try! manageContent3.fetch(fetchData3)
                    for obj in objects3 {
                        manageContent3.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent3.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    self.strSelectedplanCurrently = ""
                    self.tabvplan.reloadData()
                    self.tabvplan.isUserInteractionEnabled = true
                    
                }))
                self.present(refreshAlert, animated: true, completion: nil)
                
            }
            else{
                self.strSelectedplanCurrently = ""
                self.tabvplan.reloadData()
                self.tabvplan.isUserInteractionEnabled = true
            }
        }catch {
            print("err")
            self.strSelectedplanCurrently = ""
            self.tabvplan.reloadData()
            self.tabvplan.isUserInteractionEnabled = true
        }
        
        let strpaymentcompleted = UserDefaults.standard.value(forKey: "paymentcompleted")as? String ?? ""
        print("strpaymentcompleted",strpaymentcompleted)
        if strpaymentcompleted == "2"{
            UserDefaults.standard.removeObject(forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()
        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                self.tabBarController?.selectedIndex = 0
            }
            else
            {
                self.tabBarController?.selectedIndex = 4
            }
        }
    }
    
    //MARK: - Fetch SubscriptionmodelTable data Monthly exist or not
    func fetchDataMONTHLYSubscriptionmodelTable()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageContent = appDelegate.persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
        fetchData.predicate = NSPredicate(format: "userid == %@ && subscriptiontype == %@", strcustomerid,"Monthly")
        do {
            let result = try manageContent.fetch(fetchData)
            print("result",result)
            if result.count > 0
            {
                self.tabvplan.isUserInteractionEnabled = false
                self.strSelectedplanCurrently = "3"
                self.tabvplan.reloadData()
                
                let refreshAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language327"), preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: String(format: "%@",myAppDelegate.changeLanguage(key: "msg_language49")), style: .default, handler: { [self] (action: UIAlertAction!) in
                    print("Handle Continue Logic here")
                    
                    /*self.strSelectedplanCurrently = "3"
                     let ctrl = subscriptionmodelmonthly(nibName: "subscriptionmodelmonthly", bundle: nil)
                     ctrl.strplanname = "Monthly"
                     self.navigationController?.pushViewController(ctrl, animated: true)*/
                    
                    //Remove Subscriptionmodel table data
                    let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
                    guard let appDelegate1 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent1 = appDelegate1.persistentContainer.viewContext
                    let fetchData1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Subscriptionmodel")
                    fetchData1.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
                    let objects1 = try! manageContent1.fetch(fetchData1)
                    for obj in objects1 {
                        manageContent1.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent1.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    //Remove Monthlymodel table data
                    guard let appDelegate2 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent2 = appDelegate2.persistentContainer.viewContext
                    let fetchData2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlymodel")
                    fetchData2.predicate = NSPredicate(format: "userid == %@ && subscriptionid == %@", strcustomerid,"3")
                    let objects2 = try! manageContent2.fetch(fetchData2)
                    for obj in objects2 {
                        manageContent2.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent2.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    //Remove Monthlyproduct table data
                    guard let appDelegate3 = UIApplication.shared.delegate as? AppDelegate else {return}
                    let manageContent3 = appDelegate3.persistentContainer.viewContext
                    let fetchData3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Monthlyproduct")
                    let objects3 = try! manageContent3.fetch(fetchData3)
                    for obj in objects3 {
                        manageContent3.delete(obj as! NSManagedObject)
                    }
                    do {
                        try manageContent3.save() // <- remember to put this :)
                    } catch {
                        // Do something... fatalerror
                    }
                    
                    self.strSelectedplanCurrently = ""
                    self.tabvplan.reloadData()
                    self.tabvplan.isUserInteractionEnabled = true
                    
                }))
                self.present(refreshAlert, animated: true, completion: nil)
                
            }
            else{
                self.strSelectedplanCurrently = ""
                self.tabvplan.reloadData()
                self.tabvplan.isUserInteractionEnabled = true
            }
        }catch {
            print("err")
            self.strSelectedplanCurrently = ""
            self.tabvplan.reloadData()
            self.tabvplan.isUserInteractionEnabled = true
        }
        
        let strpaymentcompleted = UserDefaults.standard.value(forKey: "paymentcompleted")as? String ?? ""
        print("strpaymentcompleted",strpaymentcompleted)
        if strpaymentcompleted == "2"{
            UserDefaults.standard.removeObject(forKey: "paymentcompleted")
            UserDefaults.standard.synchronize()

        let strLangCode = String(format: "%@", UserDefaults.standard.value(forKey: "applicationlanguage") as? String ?? "en")
            if (strLangCode == "en")
            {
                self.tabBarController?.selectedIndex = 0
            }
            else
            {
                self.tabBarController?.selectedIndex = 4
            }
        }
    }
    
    
    //MARK: - Insert Plan in SubscriptionmodelTable method
    func insertSubscriptionmodelTable(strplanname:String,strplanid:String)
    {
        let strcustomerid = UserDefaults.standard.string(forKey: "customerid") ?? ""
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        //------------------- INSERT INTO SUBSCRIPTIONMODEL TABLE ---------------- //
        let manageContent = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Subscriptionmodel", in: manageContent)!
        let users = NSManagedObject(entity: userEntity, insertInto: manageContent)
        users.setValue(strcustomerid, forKeyPath: "userid")
        users.setValue(strbearertoken, forKeyPath: "usertoken")
        users.setValue(strplanid, forKeyPath: "subscriptionid")
        users.setValue(strplanname, forKeyPath: "subscriptiontype")
        users.setValue("0", forKeyPath: "isrenew")
        do{
            try manageContent.save()
        }catch let error as NSError {
            print("could not save . \(error), \(error.userInfo)")
        }
    }
    
    
    //MARK: - get Availble LOCATIONS LIST API method
    func getAvailbleLOCATIONSLISTAPIMethod()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod65)
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
                    //print("strstatus",strstatus)
                    //print("strsuccess",strsuccess)
                    //print("strmessage",strmessage)
                    
                    DispatchQueue.main.async {
                        
                        if strsuccess == true
                        {
                            if self.arrMALLLOCATIONS.count > 0{
                                self.arrMALLLOCATIONS.removeAllObjects()
                            }
                            let arrm = json.value(forKey: "location") as? NSArray ?? []
                            self.arrMALLLOCATIONS = NSMutableArray(array: arrm)
                            print("arrMALLLOCATIONS --->",self.arrMALLLOCATIONS)
                            
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
