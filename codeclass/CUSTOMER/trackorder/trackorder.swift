//
//  trackorder.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class trackorder: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var imgvorderplacedicon: UIImageView!
    @IBOutlet weak var lblorderno: UILabel!
    @IBOutlet weak var lblorderplacedon: UILabel!
    @IBOutlet weak var lblorderqtyandtotalamount: UILabel!
    
    
    @IBOutlet weak var tabvordertrack: UITableView!
    var reuseIdentifier1 = "celltrackorder"
    var msg = ""
    
    
    var arrMordertrackstatus = NSMutableArray()
    var arrMordertrackstatusid = NSMutableArray()

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
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        self.title = "Track Order"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        arrMordertrackstatus = ["Order Placed","Order Confirmed","In Progress","Out for Delivery","Order Delivered"]
        arrMordertrackstatusid = ["1","1","0","0","0"]
        
        tabvordertrack.register(UINib(nibName: "celltrackorder", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvordertrack.separatorStyle = .none
        tabvordertrack.backgroundView=nil
        tabvordertrack.backgroundColor=UIColor.clear
        tabvordertrack.separatorColor=UIColor.clear
        tabvordertrack.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMordertrackstatus.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 84
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! celltrackorder
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let strstatus = arrMordertrackstatus.object(at: indexPath.row)as? String ?? ""
        let strstatusid = arrMordertrackstatusid.object(at: indexPath.row)as? String ?? ""
        
        cell.lblstatusname.text = strstatus
        //"Order Placed","Order Confirmed","In Progress","Out for Delivery","Order Delivered"
    
        if strstatus == "Order Placed"
        {
            if strstatusid == "0"{
                cell.imgvstatus.image = UIImage(named: "ORstatus1")
                cell.lblvertical1.isHidden = true
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "graybordercolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "graybordercolor")!
            }
            else{
                cell.imgvstatus.image = UIImage(named: "ORstatus11")
                cell.lblvertical1.isHidden = true
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "greencolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "greencolor")!
            }
        }
        else if strstatus == "Order Confirmed"
        {
            if strstatusid == "0"{
                cell.imgvstatus.image = UIImage(named: "ORstatus2")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "graybordercolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "graybordercolor")!
            }
            else{
                cell.imgvstatus.image = UIImage(named: "ORstatus22")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "greencolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "greencolor")!
            }
        }
        else if strstatus == "In Progress"
        {
            if strstatusid == "0"{
                cell.imgvstatus.image = UIImage(named: "ORstatus3")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "graybordercolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "graybordercolor")!
            }
            else{
                cell.imgvstatus.image = UIImage(named: "ORstatus33")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "greencolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "greencolor")!
            }
        }
        else if strstatus == "Out for Delivery"
        {
            if strstatusid == "0"{
                cell.imgvstatus.image = UIImage(named: "ORstatus4")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "graybordercolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "graybordercolor")!
            }
            else{
                cell.imgvstatus.image = UIImage(named: "ORstatus44")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "greencolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "greencolor")!
            }
        }
        else if strstatus == "Order Delivered"
        {
            if strstatusid == "0"{
                cell.imgvstatus.image = UIImage(named: "ORstatus5")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = false
                cell.lblvertical1.backgroundColor = UIColor(named: "graybordercolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "graybordercolor")!
            }
            else{
                cell.imgvstatus.image = UIImage(named: "ORstatus55")
                cell.lblvertical1.isHidden = false
                cell.lblvertical2.isHidden = true
                cell.lblvertical1.backgroundColor = UIColor(named: "greencolor")!
                cell.lblvertical2.backgroundColor = UIColor(named: "greencolor")!
            }
        }
        
       
        cell.viewcell.backgroundColor = UIColor.white
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

    }

}
