//
//  returnrefundslisting.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 30/11/22.
//

import UIKit

class returnrefundslisting: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var tabvmyorders: UITableView!
    var reuseIdentifier1 = "cellreturnrefund"
    var msg = ""
    
    var arrMmyorders = NSMutableArray()

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
        self.title = "Return Orders"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        arrMmyorders = ["1","2","3","4","5","6"]
        
        tabvmyorders.register(UINib(nibName: "cellreturnrefund", bundle: nil), forCellReuseIdentifier: reuseIdentifier1)
        tabvmyorders.separatorStyle = .none
        tabvmyorders.backgroundView=nil
        tabvmyorders.backgroundColor=UIColor.clear
        tabvmyorders.separatorColor=UIColor.clear
        tabvmyorders.showsVerticalScrollIndicator = false
        
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - tableView delegate & datasource Method
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if arrMmyorders.count == 0 {
            self.tabvmyorders.setEmptyMessage(msg)
        } else {
            self.tabvmyorders.restore()
        }
        return arrMmyorders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 220
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! cellreturnrefund
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor = .clear
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        /*let dic = self.arrMmyorders.object(at: indexPath.section)as! NSDictionary
        
        let strorder_id = String(format: "%@", dic.value(forKey: "order_id")as! CVarArg)
        let strstatus = String(format: "%@", dic.value(forKey: "status")as? String ?? "")
        let strtotal_amount = String(format: "%@", dic.value(forKey: "total_amount")as? String ?? "")
        let strcurrency_code = String(format: "%@", dic.value(forKey: "currency_code")as? String ?? "")
        let strcreated_at = String(format: "%@", dic.value(forKey: "created_at")as? String ?? "")
        let strordered_qty = String(format: "%@", dic.value(forKey: "ordered_qty")as? String ?? "")*/
        
      
        /*cell.lblordernovalue.text = String(format: "# %@", strorder_id)
        cell.lblstartdatevalue.text = strcreated_at
        cell.lblstatus.text = strstatus
        cell.lblquantityvalue.text = strordered_qty
        cell.lbltotalamountvalue.text = String(format: "%@ %@",strcurrency_code, strtotal_amount)*/
        
        
        cell.btndetails.layer.borderWidth = 1.0
        cell.btndetails.layer.borderColor = UIColor(named: "greencolor")!.cgColor
        cell.btndetails.layer.cornerRadius = 16.0
        cell.btndetails.layer.masksToBounds = true
        
        cell.lblstatus.layer.borderWidth = 2.0
        cell.lblstatus.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.lblstatus.layer.cornerRadius = 16.0
        cell.lblstatus.layer.masksToBounds = true
        
        
        cell.viewcell.backgroundColor = UIColor.white
        cell.viewcell.layer.masksToBounds = false
        cell.viewcell.layer.cornerRadius = 6.0
        cell.viewcell.layer.borderColor = UIColor(named: "graybordercolor")!.cgColor
        cell.viewcell.layer.borderWidth = 1.0
        cell.viewcell.layer.shadowColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        cell.viewcell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.viewcell.layer.shadowOpacity = 1.0
        cell.viewcell.layer.shadowRadius = 6.0
        
        cell.btndetails.tag = indexPath.section
        cell.btndetails.addTarget(self, action: #selector(pressDetails), for: .touchUpInside)
        
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    @objc func pressDetails(sender:UIButton)
    {
        
    }
    
}
