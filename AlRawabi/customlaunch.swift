//
//  customlaunch.swift
//  Halalo
//
//  Created by SandipanMacmini on 28/12/21.
//

import UIKit
//import AVKit
import SwiftyGif

class customlaunch: UIViewController,SwiftyGifDelegate
{
    @IBOutlet weak var viewoverall: UIView!
    
    //let playerController = AVPlayerViewController()
    @IBOutlet weak var imgvSplash: UIImageView!
    @IBOutlet weak var imgvloader: UIImageView!
    
    @IBOutlet weak var imgv1: UIImageView!
    @IBOutlet weak var imgv2: UIImageView!
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - viewDidDisappear Method
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true)
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        self.imgv1.isHidden = false
        self.imgv2.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            // HERE
            self.imgv1.transform = CGAffineTransform.identity.scaledBy(x: 1.8, y: 1.8) // Scale your image
            self.imgv2.transform = CGAffineTransform.identity.scaledBy(x: 1.8, y: 1.8) // Scale your image
        }) { (finished) in
            UIView.animate(withDuration: 7, animations: {
                self.imgv1.transform = CGAffineTransform.identity // undo in 1 seconds
                self.imgv2.transform = CGAffineTransform.identity // undo in 1 seconds
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                    
                    //BY DEFAULT ALWAYS POPUP HOME WILL SHOW
                    /*UserDefaults.standard.removeObject(forKey: "bearertokenmaid")
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.removeObject(forKey: "bearertoken")
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.set(0, forKey: "subscribebyoncepopupshown")
                    UserDefaults.standard.synchronize()*/
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    self.tabBarController?.tabBar.isHidden = false
                    //appDelegate.tabSetting(type: "login")
                    appDelegate.tabSetting(type: "home")
                }
            })
        }
        
    }
    
    // MARK: - viewDidLoad Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        
        self.imgv1.isHidden = true
        self.imgv2.isHidden = true
        
        /*imgvloader.backgroundColor = .clear
        do {
            let gif = try UIImage(gifName: "loadertransparent.gif")
            imgvloader.setGifImage(gif)
            imgvloader.loopCount = 8
            imgvloader.delegate = self
        } catch {
            print(error)
        }*/
    }
    
    
    //MARK: - Gif Delegate Method
    /*func gifDidStart(sender: UIImageView)
    {
        print("gifDidStart")
    }
    func gifDidLoop(sender: UIImageView)
    {
        print("gifDidLoop")
    }
    func gifDidStop(sender: UIImageView)
    {
        print("gifDidStop")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            self.tabBarController?.tabBar.isHidden = false
            appDelegate.tabSetting(type: "login")
        }
    }*/
}
