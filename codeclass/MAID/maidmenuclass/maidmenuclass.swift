//
//  maidmenuclass.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/11/22.
//

import UIKit

class maidmenuclass: BaseViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvmenu: UITableView!
    var reuseIdentifier1 = "tabvcelllist"
    @IBOutlet weak var lblname: UILabel!
    var arrMenu = NSMutableArray()
    var arrMenuimages = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setupNavLogo()
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"cross2"), for: .normal)
        menuBtn.addTarget(self, action: #selector(presscross), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        let dicmaiddetails = UserDefaults.standard.value(forKey: "maiddetails")as? NSDictionary
        let strmaidid = String(format: "%@", dicmaiddetails!.value(forKey: "id")as! CVarArg)
        let strmaidfirstname = String(format: "%@", dicmaiddetails!.value(forKey: "firstname")as? String ?? "")
        let strmaidlastname = String(format: "%@", dicmaiddetails!.value(forKey: "lastname")as? String ?? "")
        //print("dicmaiddetails",dicmaiddetails as Any)
        //print("strmaidid",strmaidid)
        //print("strmaidfirstname",strmaidfirstname)
        //print("strmaidlastname",strmaidlastname)
        
        lblname.text = String(format: "%@ %@", strmaidfirstname,strmaidlastname)
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        arrMenu = [myAppDelegate.changeLanguage(key: "msg_language294"),myAppDelegate.changeLanguage(key: "msg_language295"),myAppDelegate.changeLanguage(key: "msg_language104"),myAppDelegate.changeLanguage(key: "msg_language296"),myAppDelegate.changeLanguage(key: "msg_language297"),myAppDelegate.changeLanguage(key: "msg_language298"),myAppDelegate.changeLanguage(key: "msg_language204"),myAppDelegate.changeLanguage(key: "msg_language276")]
        arrMenuimages = ["acc4","acc10","sl3","acc6","acc01","acc12","acc7","logout"]
        
        tabvmenu.register(UINib(nibName: "tabvcelllist", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmenu.separatorStyle = .none
        tabvmenu.backgroundView=nil
        tabvmenu.backgroundColor=UIColor.white
        tabvmenu.separatorColor=UIColor.clear
        tabvmenu.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - press Cross Button Method
    @objc func presscross(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMenu.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 54
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! tabvcelllist
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let strname =  String(format: "%@", arrMenu.object(at: indexPath.row)as? String ?? "")
        let strimagename =  String(format: "%@", arrMenuimages.object(at: indexPath.row)as? String ?? "")
        
        cell.lblname.textColor = .black
        cell.lblname.text = strname
        
        cell.imgvicon.contentMode = .scaleAspectFit
        cell.imgvicon.image = UIImage(named: strimagename)
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 53.5, width: tableView.frame.size.width, height: 0.5))
        lblSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let strname =  String(format: "%@", arrMenu.object(at: indexPath.row)as? String ?? "")
        //let strimagename =  String(format: "%@", arrMenuimages.object(at: indexPath.row)as? String ?? "")
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if strname == myAppDelegate.changeLanguage(key: "msg_language294")
        {
            let obj = maidviewsubscriptions(nibName: "maidviewsubscriptions", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: false)
        }
        else if strname == myAppDelegate.changeLanguage(key: "msg_language295")
        {
            let obj = maidpausedsubscriptions(nibName: "maidpausedsubscriptions", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: false)
        }
        else if strname == myAppDelegate.changeLanguage(key: "msg_language276")
        {
            UserDefaults.standard.removeObject(forKey: "bearertokenmaid")
            UserDefaults.standard.synchronize()
            
            let strbearertoken = UserDefaults.standard.value(forKey: "bearertokenmaid")as? String ?? ""
            print("strbearertoken",strbearertoken)
            
            self.navigationController?.popToRootViewController(animated: false)
        }
        else if strname == myAppDelegate.changeLanguage(key: "msg_language104")
        {
            let obj = maidorderonce(nibName: "maidorderonce", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else if strname == myAppDelegate.changeLanguage(key: "msg_language296")
        {
            let obj = maidwalletdetails(nibName: "maidwalletdetails", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else if strname == myAppDelegate.changeLanguage(key: "msg_language297")
        {
            let obj = maidprofiledetails(nibName: "maidprofiledetails", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: false)
        }
        else if strname == myAppDelegate.changeLanguage(key: "msg_language298")
        {
            let obj = maidaddresslist(nibName: "maidaddresslist", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: false)
        }
        else if strname == myAppDelegate.changeLanguage(key: "msg_language204")
        {
            let obj = maidallorderslist(nibName: "maidallorderslist", bundle: nil)
            self.navigationController?.pushViewController(obj, animated: false)
        }
    }
}
