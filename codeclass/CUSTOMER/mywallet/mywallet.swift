//
//  mywallet.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/07/22.
//

import UIKit

class mywallet: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewtop: UIView!
    @IBOutlet weak var lblwalletbalancevalue: UILabel!
    @IBOutlet weak var btnrecharge: UIButton!
    
    
    @IBOutlet weak var lblrecentpayments: UILabel!
    @IBOutlet weak var tabvmyrecharges: UITableView!
    var reuseIdentifier1 = "cellwallettransaction"
    var msg = ""
    
    
    var arrMalltransactions = NSMutableArray()
    
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
        self.title = "My Wallet"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        tabvmyrecharges.register(UINib(nibName: "cellwallettransaction", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyrecharges.separatorStyle = .none
        tabvmyrecharges.backgroundView=nil
        tabvmyrecharges.backgroundColor=UIColor.clear
        tabvmyrecharges.separatorColor=UIColor.clear
        tabvmyrecharges.showsVerticalScrollIndicator = false
        
        arrMalltransactions = ["Success","Failed","Success","Success","Success","Success","Success","Success","Success","Success","Success","Success"]
        

        btnrecharge.layer.cornerRadius = 20.0
        btnrecharge.layer.masksToBounds = true
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - press Recharge method
    @IBAction func pressrecharge(_ sender: Any) {
        let ctrl = rechargewallet(nibName: "rechargewallet", bundle: nil)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return arrMalltransactions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellwallettransaction
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let strstatus = arrMalltransactions.object(at: indexPath.section)as? String ?? ""
        cell.lblorderstatus.text = strstatus
        
        if strstatus == "Success"
        {
            cell.lblorderstatus.textColor = UIColor(named: "greencolor")!
            
        }
        else if strstatus == "Failed"
        {
            cell.lblorderstatus.textColor = UIColor(named: "darkredcolor")!

        }
        
       
        cell.viewcell.backgroundColor = UIColor.white
        cell.viewcell.layer.masksToBounds = false
        cell.viewcell.layer.cornerRadius = 6.0
        cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.borderWidth = 1.0
        cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.viewcell.layer.shadowOpacity = 1.0
        cell.viewcell.layer.shadowRadius = 6.0
        
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

    }
    
}
