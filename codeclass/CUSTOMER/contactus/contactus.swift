//
//  contactus.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 04/11/22.
//

import UIKit
import WebKit
class contactus: UIViewController,UIWebViewDelegate,WKNavigationDelegate, WKUIDelegate
{

    @IBOutlet weak var viewoverall: UIView!
    @IBOutlet weak var webcontactus: WKWebView!
    
    var strPageUrl = String()
    
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
        self.title = "Contact Us"
        
        let backicon = UIImage(named: "back")
        let back = UIBarButtonItem(image: backicon, style: .plain, target: self, action: #selector(pressBack))
        back.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = back
        
        strPageUrl = "https://alrawabidairy.com/contact-us/"
        webcontactus.uiDelegate = self
        webcontactus.navigationDelegate = self
        let url = URL.init(string: strPageUrl) //URL (string: TNC)
        let request = URLRequest(url: url!)
        webcontactus.load(request)
    }
    
    //MARK: - press back method
    @objc func pressBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: -  WkWebView Delegate Method
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!)
    {
        print("finish to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation)
    {
        
    }
}
