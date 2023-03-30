//
//  mapaddressgoogle.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 22/02/23.
//

import UIKit
import UIKit

import Alamofire
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import GoogleMapsCore
import GoogleMapsUtils
import Nominatim
import SwiftyJSON

class mapaddressgoogle: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var viewoverall: UIView!
    
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var mapview: GMSMapView!
    @IBOutlet weak var pinImage: UIImageView!
    
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var btncross: UIButton!
    
    @IBOutlet weak var lblalertstatus: UILabel!
    @IBOutlet weak var btnConfirmLocation: UIButton!
    
    var strFrompageMap = ""
    
    var boolcheck = false
    var strSelectedPolygonID = ""
    var strSelectedPolygonName = ""
    
    var arrmPolygonlist = NSMutableArray()
    var arrmpolygonobject = NSMutableArray()
    var arrmpolygonobjectName = NSMutableArray()
    
    var locationManager = CLLocationManager()
    var strcurrentlat = ""
    var strcurrentlong = ""
    
    var strsearchlat = Double()
    var strsearchlng = Double()
    
    var arrMautocompletesearch = NSMutableArray()
    
    var isBoolDropdown = Bool()
    let cellReuseIdentifier = "cell"
    var tblViewDropdownList: UITableView? = UITableView()
    var arrMGlobalDropdownFeed = NSMutableArray()
    
    var strSelectedplacename = ""
    var strSelectedplaceid = ""
    
    var strlocationname = ""
    var strcityname = ""
    
    var mymarker = GMSMarker()
    
    var geoCoder :CLGeocoder!
    
    var locDRAGG = false
    
    var boolSIRSTTMEPAGELOAD = false
    
    // MARK: - viewWillDisappear Method
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.navigationItem.title = myAppDelegate.changeLanguage(key: "msg_language258")
        
        self.btnConfirmLocation.setTitle(String(format: "%@", myAppDelegate.changeLanguage(key: "msg_language256")), for: .normal)
        
        self.lblalertstatus.text = ""
        self.lblalertstatus.isHidden = true
        self.lblalertstatus.layer.cornerRadius = 12.0
        self.lblalertstatus.layer.masksToBounds = true
        
        self.btnConfirmLocation.isHidden = true
        self.btnConfirmLocation.layer.cornerRadius = 12.0
        self.btnConfirmLocation.layer.masksToBounds = true
        
        self.getPolygonApiList()
        
        
        //-----LOCATION MANAGER ---- //
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        //locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.activityType = .otherNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        SetUpMap()
        geoCoder = CLGeocoder()
    }
    
    //MARK: - press Confirm Location Method
    @IBAction func pressConfirmLocation(_ sender: Any)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if txtsearch.text == ""
        {
            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language264"), preferredStyle: UIAlertController.Style.alert)
            self.present(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                print("Click of default button")
            }))
        }
        else{
            
            print("strsearchlat",self.strsearchlat)
            print("strsearchlng",self.strsearchlng)
            print("strlocationname",self.strlocationname)
            print("strcityname",self.strcityname)
            
            if strFrompageMap == "addnewaddress"
            {
                print("From Page --> ADD NEW ADDRESS")
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                    if controller.isKind(of: addnewaddress.self) {
                        let tabVC = controller as! addnewaddress
                        tabVC.strstreetaddressfrommap = String(format: "%@", txtsearch.text!)
                        tabVC.strstreetaddressfrommapLocation = strlocationname
                        tabVC.strstreetaddressfrommapCity = strcityname
                        tabVC.strSelectedLATITUDE = String(self.strsearchlat)
                        tabVC.strSelectedLONGITUDE = String(self.strsearchlng)
                        tabVC.strSELECTEDPOLYGONDETAILS = self.strSelectedPolygonName
                        self.navigationController?.popToViewController(tabVC, animated: true)
                    }
                }
            }
            else if strFrompageMap == "updatemyaddress"
            {
                print("From Page --> UPDATE ADDRESS")
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                    if controller.isKind(of: updatemyaddress.self) {
                        let tabVC = controller as! updatemyaddress
                        tabVC.strstreetaddressfrommap = String(format: "%@", txtsearch.text!)
                        tabVC.strstreetaddressfrommapLocation = strlocationname
                        tabVC.strstreetaddressfrommapCity = strcityname
                        tabVC.strSelectedLATITUDE = String(self.strsearchlat)
                        tabVC.strSelectedLONGITUDE = String(self.strsearchlng)
                        tabVC.strSELECTEDPOLYGONDETAILS = self.strSelectedPolygonName
                        self.navigationController?.popToViewController(tabVC, animated: true)
                    }
                }
            }
            else if strFrompageMap == "popuphomepage"
            {
                print("From Page --> HOME PAGE POPUP")
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                    if controller.isKind(of: homeclass.self) {
                        let tabVC = controller as! homeclass
                        
                        /*print("strPOPUPstreetaddressfrommap",strPOPUPstreetaddressfrommap)
                        print("strPOPUPstreetaddressfrommapLocation",strPOPUPstreetaddressfrommapLocation)
                        print("strPOPUPstreetaddressfrommapCity",strPOPUPstreetaddressfrommapCity)
                        print("strPOPUPSelectedLATITUDE",strPOPUPSelectedLATITUDE)
                        print("strPOPUPSelectedLONGITUDE",strPOPUPSelectedLONGITUDE)*/
                        
                        tabVC.strPOPUPstreetaddressfrommap = String(format: "%@", txtsearch.text!)
                        tabVC.strPOPUPstreetaddressfrommapLocation = strlocationname
                        tabVC.strPOPUPstreetaddressfrommapCity = strcityname
                        tabVC.strPOPUPSelectedLATITUDE = String(self.strsearchlat)
                        tabVC.strPOPUPSelectedLONGITUDE = String(self.strsearchlng)
                        tabVC.strSELECTEDPOLYGONDETAILS = self.strSelectedPolygonName
                        self.navigationController?.popToViewController(tabVC, animated: true)
                    }
                }
            }
            else if strFrompageMap == "subscriptionorderreview"
            {
                print("From Page --> SUBSCRIPTION ORDER REVIEW")
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                    if controller.isKind(of: subscriptionorderreview.self) {
                        let tabVC = controller as! subscriptionorderreview
                        tabVC.strFulladdress = String(format: "%@", txtsearch.text!)
                        tabVC.strFulladdressLocationname = strlocationname
                        tabVC.strFulladdressCityname = strcityname
                        tabVC.strSelectedLATITUDE = String(self.strsearchlat)
                        tabVC.strSelectedLONGITUDE = String(self.strsearchlng)
                        self.navigationController?.popToViewController(tabVC, animated: true)
                    }
                }
            }
            else if strFrompageMap == "orderonceclass"
            {
                print("From Page --> ORDER ONCE TAB PAGE")
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                    if controller.isKind(of: orderonceclass.self) {
                        let tabVC = controller as! orderonceclass
                        tabVC.strstreetaddressfrommapORDERONCE = String(format: "%@", txtsearch.text!)
                        tabVC.strstreetaddressfrommapLocationORDERONCE = strlocationname
                        tabVC.strstreetaddressfrommapCityORDERONCE = strcityname
                        //tabVC.strSelectedLATITUDE = String(self.strsearchlat)
                        //tabVC.strSelectedLONGITUDE = String(self.strsearchlng)
                        self.navigationController?.popToViewController(tabVC, animated: true)
                    }
                }
            }
            else if strFrompageMap == "subsriptionclass"
            {
                print("From Page --> SUBSCRIPTION TAB PAGE")
                
                guard let vc = self.navigationController?.viewControllers else { return }
                for controller in vc {
                    if controller.isKind(of: subsriptionclass.self) {
                        let tabVC = controller as! subsriptionclass
                        tabVC.strstreetaddressfrommapSUBSCRIPTION = String(format: "%@", txtsearch.text!)
                        tabVC.strstreetaddressfrommapLocationSUBSCRIPTION = strlocationname
                        tabVC.strstreetaddressfrommapCitySUBSCRIPTION = strcityname
                        //tabVC.strSelectedLATITUDE = String(self.strsearchlat)
                        //tabVC.strSelectedLONGITUDE = String(self.strsearchlng)
                        self.navigationController?.popToViewController(tabVC, animated: true)
                    }
                }
            }
        }
    }
    
    //MARK: - set map method
    func SetUpMap()
    {
        print("self.strsearchlat",self.strsearchlat)
        print("self.strsearchlng",self.strsearchlng)
        
        self.strsearchlat = 25.2048
        self.strsearchlng = 55.2708
        
        let camera = GMSCameraPosition.camera(withLatitude:self.strsearchlat, longitude: self.strsearchlng, zoom: 25)
        self.mapview.camera = camera
        self.mapview.delegate = self
        self.mapview.mapType = .normal
        self.mapview.isMyLocationEnabled = true
        self.mapview.isTrafficEnabled = true
        self.mapview.isBuildingsEnabled = true
        self.mapview.settings.myLocationButton = true
        self.mapview.setMinZoom(0.5, maxZoom: 10000.0)
        
        self.mapview.bringSubviewToFront(pinImage)
        
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition)
    {
        print("position --- > ",position as Any)
        
        print("position zoom--- > ",position.zoom)
        
        let lat = position.target.latitude
        let lng = position.target.longitude
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.lblalertstatus.isHidden = false
        self.lblalertstatus.backgroundColor = .red
        self.lblalertstatus.text = myAppDelegate.changeLanguage(key: "msg_language263")
        self.boolcheck = false
        
        self.btnConfirmLocation.isHidden = false
        self.btnConfirmLocation.backgroundColor = UIColor.lightGray
        self.btnConfirmLocation.titleLabel?.textColor = UIColor.black
        self.btnConfirmLocation.isUserInteractionEnabled = false
    }
    func mapView(_ mapView:GMSMapView,idleAt position:GMSCameraPosition)
    {
        print("position --- > ",position as Any)
        
        print("position zoom--- > ",position.zoom)
        
        let lat = position.target.latitude
        let lng = position.target.longitude
        
        /*if position.zoom >= 16
        {
            let camera = GMSCameraPosition.camera(withLatitude:lat, longitude: lng, zoom: position.zoom)
            self.mapview.camera = camera
            
            //CHECK INSIDE / OUSTSIDE POLYGON AREA METHOD
            self.checkpolygonPointMultiple(lat: lat, long: lng)
            self.alertViewFunction()
        }
        else
        {
            let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
            self.lblalertstatus.isHidden = false
            self.lblalertstatus.backgroundColor = .red
            self.lblalertstatus.text = myAppDelegate.changeLanguage(key: "msg_language263")
            self.boolcheck = false
            
            self.btnConfirmLocation.isHidden = false
            self.btnConfirmLocation.backgroundColor = UIColor.lightGray
            self.btnConfirmLocation.titleLabel?.textColor = UIColor.black
            self.btnConfirmLocation.isUserInteractionEnabled = false
            
            //self.showToast(message: myAppDelegate.changeLanguage(key: "msg_language473"), seconds: 3.0)
        }*/
        
        let camera = GMSCameraPosition.camera(withLatitude:lat, longitude: lng, zoom: position.zoom)
        self.mapview.camera = camera
        
        //CHECK INSIDE / OUSTSIDE POLYGON AREA METHOD
        self.checkpolygonPointMultiple(lat: lat, long: lng)
        self.alertViewFunction()
        
        // Create Location
        let location = CLLocation(latitude: lat, longitude: lng)
        
        // Geocode Location
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemarks = placemarks{
                if let location = placemarks.first?.location{
                    //self.addressTextField.text = (placemarks.first?.name ?? "")+" "+(placemarks.first?.subLocality ?? " ")
                    if let addressDict = (placemarks.first?.addressDictionary as? NSDictionary){
                        let dict = JSON(addressDict)
                        print("REVERSE GEO CODING ADDRESS -- >>>>>>",dict)
                        
                        var address:String = ""
                        for data in dict["FormattedAddressLines"].arrayValue{
                            address = address+" "+data.stringValue
                        }
                        print("address",address)
                        let strSubAdministrativeArea = dict["SubAdministrativeArea"].stringValue
                        let strcity = dict["City"].stringValue
                        let strcountry = dict["Country"].stringValue
                        
                        self.strlocationname = strSubAdministrativeArea
                        self.strcityname = strcity
                        
                        self.locDRAGG = true
                        self.txtsearch.text = String(format: "%@ %@ %@", address,strcity,strcountry)
                        // here you will get the Address.
                    }
                }
            }
            
        }
        
        /*if self.locDRAGG == false
        {
            self.performPlaceidFromLatLong(strlat: String(format: "%0.10f", lat), strlong: String(format: "%0.10f", lng))
        }*/
    }
    
    
    //MARK: - CLLocationManager Authorization Delegate method
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.authorizedAlways){
            print("authorizedAlways")
        }
        else if (status == CLAuthorizationStatus.authorizedWhenInUse){
            print("authorizedWhenInUse")
        }
        else{
            print("denied")
        }
    }
    
    
    //MARK: - CLLocationManager did Update location changes delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("Current Location Updating...")
        var latdouble = Double()
        var longdouble = Double()
        latdouble = (manager.location?.coordinate.latitude)!
        longdouble = (manager.location?.coordinate.longitude)!
        
        self.strcurrentlat = String(format: "%0.10f", latdouble)
        self.strcurrentlong = String(format: "%0.10f", longdouble)
        print("self.strcurrentlat",self.strcurrentlat)
        print("self.strcurrentlong",self.strcurrentlong)
        
        if boolSIRSTTMEPAGELOAD == false
        {
            //FOR FISTIMEPAGE LOAD ONLY
            self.strsearchlat = latdouble
            self.strsearchlng = longdouble
            print("self.strsearchlat",self.strsearchlat)
            print("self.strsearchlng",self.strsearchlng)
            
            //IF FOR FISTIMEPAGE LOAD ONLY THEN IT WILL AUTOMATICALLY CHECK CURRENT DEVICE LATITUDE LONGITUDE AREA WITH POLYGON AREA
            self.performPlaceidFromLatLong(strlat: String(format: "%0.10f", self.strsearchlat), strlong: String(format: "%0.10f", self.strsearchlng))
            
            let camera = GMSCameraPosition.camera(withLatitude:self.strsearchlat, longitude: self.strsearchlng, zoom: 15)
            self.mapview.camera = camera
            
            boolSIRSTTMEPAGELOAD = true
        }
        
        /*if self.txtsearch.text?.count == 0
        {
            self.strsearchlat = latdouble
            self.strsearchlng = longdouble
            
            print("self.strsearchlat",self.strsearchlat)
            print("self.strsearchlng",self.strsearchlng)
            
            //IF SEARCH TEXT ADDRESS IS BLANK THEN IT WILL AUTOMATICALLY CHECK CURRENT DEVICE LATITUDE LONGITUDE AREA WITH POLYGON AREA
            self.performPlaceidFromLatLong(strlat: self.strcurrentlat, strlong: self.strcurrentlong)
        }
        else{
            
            self.strsearchlat = latdouble
            self.strsearchlng = longdouble
            
            print("self.strsearchlat",self.strsearchlat)
            print("self.strsearchlng",self.strsearchlng)
            
            self.performPlaceidFromLatLong(strlat: String(format: "%0.10f", self.strsearchlat), strlong: String(format: "%0.10f", self.strsearchlng))
        }
        
        let camera = GMSCameraPosition.camera(withLatitude:self.strsearchlat, longitude: self.strsearchlng, zoom: 15)
        self.mapview.camera = camera*/
        
    }
    
    
    
    
    //MARK: - ceate camera GoogleMapView method
    func createCameraGoogleMap(latvalue:Double,longvalue:Double)
    {
        let camera = GMSCameraPosition.camera(withLatitude: latvalue, longitude: longvalue, zoom: 2)
        self.mapview.camera = camera
        showMarker(position: camera.target)
    }
    
    //MARK: - create Google Map Marker method
    func showMarker(position: CLLocationCoordinate2D)
    {
        mymarker.position = position
        mymarker.title = "My Location"
        mymarker.snippet = ""
        //mymarker.isDraggable = true // We will not Long press on marker and dragg it anywhere to point the position in GMS Google Map
        mymarker.map = self.mapview
    }
    
    //MARK: - remove all marker from Map Method
    func removeMarkers(mapView: GMSMapView){
        self.mymarker.map = nil
    }
    
    
    //MARK: - GMS Google Map Delegate Methods
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = "My Current location"
        view.addSubview(lbl1)
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.text = ""
        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.addSubview(lbl2)
        return view
    }
    
    //MARK: - GMSMarker Dragging Delegate Method
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging")
        print("marker.position",marker.position)
        
        //CHECK INSIDE / OUSTSIDE POLYGON AREA METHOD
        self.checkpolygonPointMultiple(lat: marker.position.latitude, long: marker.position.longitude)
        self.alertViewFunction()
        
        self.strsearchlat = marker.position.latitude
        self.strsearchlng = marker.position.longitude
        self.performPlaceidFromLatLong(strlat: String(format: "%0.10f", self.strsearchlat), strlong: String(format: "%0.10f", self.strsearchlng))
    }
    
    //MARK: - GMSMarker DId Tap on Mapview Delegate Method
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
    {
        print("coordinate",coordinate)
        
        //CHECK INSIDE / OUSTSIDE POLYGON AREA METHOD
        self.checkpolygonPointMultiple(lat: coordinate.latitude, long: coordinate.longitude)
        self.alertViewFunction()
        
        self.strsearchlat = coordinate.latitude
        self.strsearchlng = coordinate.longitude
        self.performPlaceidFromLatLong(strlat: String(format: "%0.10f", self.strsearchlat), strlong: String(format: "%0.10f", self.strsearchlng))
    }
    
    /*func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition)
     {
     //self.mapview.camera = position
     /*if mapView.camera.zoom >= 10 {
      // ADD YOUR MARKERS HERE
      self.mapview.camera = position
      
      let point = CLLocationCoordinate2DMake(self.strsearchlat,self.strsearchlng)
      self.mymarker.position = point
      
      } else {
      mapView.clear()
      }*/
     }*/
    
    //MARK: - get Polugon API List method
    func getPolygonApiList()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.clear)
        }
        
        let strbearertoken = UserDefaults.standard.value(forKey: "bearertoken")as? String ?? ""
        print("strbearertoken",strbearertoken)
        
        var strconnurl = String()
        strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, Constants.methodname.apimethod109)
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        //request.setValue("Bearer \(strbearertoken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("strconnurl",strconnurl)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                DispatchQueue.main.async {
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
                            if self.arrmPolygonlist.count > 0{
                                self.arrmPolygonlist.removeAllObjects()
                            }
                            
                            let arrmlocation = dictemp.value(forKey: "location") as? NSArray ?? []
                            self.arrmPolygonlist = NSMutableArray(array: arrmlocation)
                            print("arrmPolygonlist --->",self.arrmPolygonlist)
                            
                            self.createMultiPolygon()
                            
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
                    self.view.activityStopAnimating()
                }
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    //MARK: - create multi Polygon from Arraylist Method
    func createMultiPolygon()
    {
        for x in 0 ..< arrmPolygonlist.count
        {
            let dictemp = arrmPolygonlist.object(at: x)as? NSDictionary
            let strname = String(format: "%@", dictemp?.value(forKey: "name")as? String ?? "")
            let strid = String(format: "%@", dictemp?.value(forKey: "id")as! CVarArg)
            let stremirate = String(format: "%@", dictemp?.value(forKey: "emirate")as? String ?? "")
            print("strid %@ strname %@ stremirate %2",strid,strname,stremirate)
            
            let arrm = dictemp?.value(forKey: "coordinates")as? NSArray
            
            var polygon = GMSPolygon()
            let rect = GMSMutablePath()
            
            for xx in 0 ..< arrm!.count
            {
                let dic1 = arrm!.object(at: xx)as? NSDictionary
                let strlatitude = String(format: "%@", dic1?.value(forKey: "latitude")as! CVarArg)
                let strlongitude = String(format: "%@", dic1?.value(forKey: "longitude")as! CVarArg)
                
                //let strcoordinate = String(format: "%@", arrm?.object(at: xx)as? String ?? "")
                //let items = strcoordinate.components(separatedBy: ", ")
                //let str1 = items[0]
                //let str2 = items[1]
                //let point = CLLocationCoordinate2DMake(Double(strlatitude)!,Double(strlongitude)!)
                
                rect.add(CLLocationCoordinate2D(latitude: Double(strlatitude)!, longitude: Double(strlongitude)!))
            }
            polygon = GMSPolygon(path: rect)
            arrmpolygonobject.add(polygon)

            polygon.fillColor = UIColor(red: 152/255, green: 251/255, blue: 152/255, alpha: 0.4)
            polygon.strokeColor = UIColor(named: "darkredcolor")!
            polygon.strokeWidth = 4
            polygon.map = self.mapview
            
            let strcombine = String(format:"%@+%@+%@",strid,strname,stremirate)
            arrmpolygonobjectName.add(strcombine)
        }
        
        print("arrmpolygonobject",arrmpolygonobject.count)
        print("arrmpolygonobjectName",arrmpolygonobjectName.count)
        
        if self.txtsearch.text?.count == 0
        {
            self.btnConfirmLocation.isHidden = true
            self.btnConfirmLocation.backgroundColor = UIColor.lightGray
            self.btnConfirmLocation.titleLabel?.textColor = UIColor.black
            self.btnConfirmLocation.isUserInteractionEnabled = false
        }
        else{
            self.btnConfirmLocation.isHidden = false
            self.btnConfirmLocation.backgroundColor = UIColor(named: "greencolor")!
            self.btnConfirmLocation.titleLabel?.textColor = UIColor.white
            self.btnConfirmLocation.isUserInteractionEnabled = true
        }
    }
    
    
    //MARK: - Check MULTIPLE Coordinate WITHIN POLYGON OR NOT
    func checkpolygonPointMultiple(lat:Double,long:Double)
    {
        for xx in 0 ..< arrmpolygonobject.count
        {
            let gms_polygon = arrmpolygonobject.object(at: xx)as? GMSPolygon
            
            let point = CLLocationCoordinate2DMake(lat,long)
            if gms_polygon!.contains(coordinate: point)
            {
                //do stuff here
                print("Your location was inside your polygon.")
                let strpolygonname = String(format:"%@",self.arrmpolygonobjectName.object(at: xx) as? String ?? "")
                
                print("strpolygonname",strpolygonname)
                boolcheck = true
                strSelectedPolygonName = strpolygonname
            }
            else
            {
                print("Your location was outside your polygon.")
            }
        }
        
    }
    func alertViewFunction()
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        print("self.strSelectedPolygonName",self.strSelectedPolygonName)
        
        //ALERT VIEW CHECKING
        if boolcheck == true{
            
            DispatchQueue.main.async {
                
                /*let alert = UIAlertController(title: "Alert", message: "You are inside our delivery area!", preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                 }
                 alert.addAction(okAction)
                 self.present(alert, animated: true, completion: nil)*/
                
                self.lblalertstatus.isHidden = false
                self.lblalertstatus.backgroundColor = .blue
                self.lblalertstatus.text = myAppDelegate.changeLanguage(key: "msg_language262")
                self.boolcheck = false
                
                self.btnConfirmLocation.isHidden = false
                self.btnConfirmLocation.backgroundColor = UIColor(named: "greencolor")!
                self.btnConfirmLocation.titleLabel?.textColor = UIColor.white
                self.btnConfirmLocation.isUserInteractionEnabled = true
                
            }
        }
        else
        {
            DispatchQueue.main.async {
                
                /*let alert = UIAlertController(title: "Alert", message: "We do not deliver to this area!", preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                 }
                 alert.addAction(okAction)
                 self.present(alert, animated: true, completion: nil)*/
                
                self.lblalertstatus.isHidden = false
                self.lblalertstatus.backgroundColor = .red
                self.lblalertstatus.text = myAppDelegate.changeLanguage(key: "msg_language263")
                self.boolcheck = false
                
                self.btnConfirmLocation.isHidden = false
                self.btnConfirmLocation.backgroundColor = UIColor.lightGray
                self.btnConfirmLocation.titleLabel?.textColor = UIColor.black
                self.btnConfirmLocation.isUserInteractionEnabled = false
                
            }
        }
    }
    
    
    
    // MARK: - Textfield Delegate Method
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
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
        if let text = txtsearch.text,
           let textRange = Range(range, in: text)
        {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            print("updatedText",updatedText)
            
            if updatedText.count >= 5
            {
                print("Call the Search Autocomplete Function")
                self.googlePlacesResult(input: updatedText)
            }
            else if updatedText.count < 5
            {
                // Backspace handled
                guard !string.isEmpty else {
                    self.txtsearch.text = ""
                    if self.isBoolDropdown == true{
                        self.handleTap1()
                    }
                    return true
                }
            }
            else
            {
                // Backspace handled
                guard !string.isEmpty else {
                    self.txtsearch.text = ""
                    if self.isBoolDropdown == true{
                        self.handleTap1()
                    }
                    return true
                }
            }
        }
        
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
    //MARK: - press cross AutoComplete Search Boc method
    @IBAction func pressCross(_ sender: Any)
    {
        //REMOVE Marker PIN
        // self.removeMarkers(mapView: self.mapview)
        
        //RECREATE POLYGON AGAIN AFTER CLEAR MAPVIEW ANNOTATION PIN
        //self.getPolygonApiList()
        
        //Current Device Location Set
        //self.locationManager.startUpdatingLocation()
        
        //Clear Search box input
        self.txtsearch.text = ""
        self.txtsearch.becomeFirstResponder()
        
        if self.txtsearch.text?.count == 0{
            self.lblalertstatus.isHidden = true
            self.btnConfirmLocation.isHidden = true
        }else{
            self.lblalertstatus.isHidden = false
            self.btnConfirmLocation.isHidden = false
        }
    }
    
    
    //MARK: - Google autocomplete place API request
    func googlePlacesResult(input: String)
    {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        //let searchWordProtection = input.replacingOccurrences(of: " ", with: "");
        
        let currentLocationLatitude1 = String(format: "%@", self.strcurrentlat)
        let currentLocationLongtitude1 = String(format: "%@", self.strcurrentlong)
        print("lat------",currentLocationLatitude1)
        print("lat------",currentLocationLongtitude1)
        
        //25.0709434,55.1287182 - JLT DUBAI
        
        let urlString = NSString(format: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=establishment|geocode&location=%@,%@&radius=40000&language=en&key=%@",input,"\(25.0709434)","\(55.1287182)",Constants.conn.GoogleAPIKey)
        print(urlString)
        
        let url = NSURL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
        print(url!)
        let defaultConfigObject = URLSessionConfiguration.default
        let delegateFreeSession = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
        let request = NSURLRequest(url: url! as URL)
        let task =  delegateFreeSession.dataTask(with: request as URLRequest, completionHandler:{(data, response, error) -> Void in
            if let data = data
            {
                do {
                    let jSONresult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let results:NSArray = jSONresult["predictions"] as! NSArray
                    let status = jSONresult["status"] as! String
                    print("results",results)
                    print("status",status)
                    
                    if status == "NOT_FOUND" || status == "REQUEST_DENIED"
                    {
                        //let userInfo:NSDictionary = ["error": jSONresult["status"]!]
                        //let newError = NSError(domain: "API Error", code: 666, userInfo: userInfo as [NSObject : AnyObject])
                        //let arr:NSArray = [newError]
                        //print("arr",arr)
                        //return
                        
                        if self.arrMautocompletesearch.count > 0{
                            self.arrMautocompletesearch.removeAllObjects()
                        }
                        if self.isBoolDropdown == true {
                            self.handleTap1()
                        }
                        
                        let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language261"), preferredStyle: UIAlertController.Style.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                            print("Click of default button")
                        }))
                    }
                    else
                    {
                        print("results",results)
                        
                        if self.arrMautocompletesearch.count > 0{
                            self.arrMautocompletesearch.removeAllObjects()
                        }
                        
                        let aarrm1 = NSMutableArray(array: results)
                        self.arrMautocompletesearch = aarrm1
                        print("arrMMyExpenselist >>",self.arrMautocompletesearch)
                        
                        if self.arrMautocompletesearch.count > 0
                        {
                            if self.isBoolDropdown == true {
                                self.handleTap1()
                            }else{
                                self.popupDropdown(arrFeed: self.arrMautocompletesearch, txtfld: self.txtsearch, tagTable: 100)
                            }
                        }
                        else
                        {
                            let uiAlert = UIAlertController(title: "", message: myAppDelegate.changeLanguage(key: "msg_language261"), preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: myAppDelegate.changeLanguage(key: "msg_language76"), style: .default, handler: { action in
                                print("Click of default button")
                            }))
                        }
                    }
                }
                catch
                {
                    print("json error: \(error)")
                    
                    if self.arrMautocompletesearch.count > 0{
                        self.arrMautocompletesearch.removeAllObjects()
                    }
                    if self.isBoolDropdown == true {
                        self.handleTap1()
                    }
                }
            }
            else if let error = error
            {
                print(error)
                
                if self.arrMautocompletesearch.count > 0{
                    self.arrMautocompletesearch.removeAllObjects()
                }
                if self.isBoolDropdown == true {
                    self.handleTap1()
                }
            }
        })
        task.resume()
    }
    
    
    // MARK: - SearchAutocomplete List dropdown Method
    func popupDropdown(arrFeed:NSMutableArray,txtfld:UITextField, tagTable:Int)
    {
        let point = (txtfld.superview?.convert(txtfld.frame.origin, to: self.view))! as CGPoint
        print(point.y)
        
        isBoolDropdown = true
        tblViewDropdownList = UITableView(frame: CGRect(x: 0, y: point.y + self.txtsearch.frame.size.height + 4, width: self.viewoverall.frame.size.width, height: 0))
        tblViewDropdownList?.delegate = self
        tblViewDropdownList?.dataSource = self
        tblViewDropdownList?.tag = tagTable
        tblViewDropdownList?.backgroundView = nil
        tblViewDropdownList?.backgroundColor = UIColor.white
        tblViewDropdownList?.separatorColor = UIColor.clear
        self.view.addSubview(tblViewDropdownList!)
        
        arrMGlobalDropdownFeed = arrFeed
        
        UIView .animate(withDuration: 0.35, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = CGRect()
            frame = (self.tblViewDropdownList?.frame)!
            frame.size.height =  UIScreen.main.bounds.size.height/2.0-64
            self.tblViewDropdownList?.frame = frame
            //print(self.tblViewDropdownList?.frame as Any)
        }, completion: nil)
    }
    
    
    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMGlobalDropdownFeed.count
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
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
        
        let  str1 = String(format: "%@", dictemp.value(forKey: "description") as? String ?? "")
        //let  str2 = String(format: "%@", dictemp.value(forKey: "place_id") as? String ?? "")
        
        title1.text = String(format: "%@",str1) as String
        
        let lblSeparator = UILabel(frame: CGRect(x: 0, y: 39, width: tableView.frame.size.width, height: 1))
        lblSeparator.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        cell.contentView.addSubview(lblSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMGlobalDropdownFeed[indexPath.row] as! NSDictionary
        print("dictemp",dictemp)
        let  str1 = String(format: "%@", dictemp.value(forKey: "description") as? String ?? "")
        let  str2 = String(format: "%@", dictemp.value(forKey: "place_id") as? String ?? "")
        
        self.strSelectedplacename = str1
        self.strSelectedplaceid = str2
        
        if self.txtsearch.text!.count > 0{
            self.txtsearch.text = ""
        }
        self.txtsearch.text = str1
        
        //self.btnsearch.isHidden = true
        self.txtsearch.resignFirstResponder()
        
        self.handleTap1()
        
        
        self.performGoogleSearchPlaceID1111(strplaceid: self.strSelectedplaceid)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performGoogleSearchPlaceID(strplaceid: self.strSelectedplaceid)
        }
        
        
    }
    func handleTap1()
    {
        isBoolDropdown = false
        self.tblViewDropdownList?.removeFromSuperview()
        self.tblViewDropdownList = nil
    }
    
    
    //MARK: - GET PLACEID from LATITUDE LONGITUDE - Google API
    func performPlaceidFromLatLong(strlat:String,strlong:String)
    {
        var strconnurl = String(format: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=10000&key=%@", strlat,strlong,Constants.conn.GoogleAPIKey)
        strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
        print("strconnurl",strconnurl)
        AF.request(strconnurl,method: .get,encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            
            switch response.result{
            case .success(let JSON):
                
                //print("Success with JSON: \(String(describing: JSON))")
                
                //let array = JSON as? NSArray
                //print("array",array)
                
                let dic = JSON as? NSDictionary
                //print("dic",dic as Any)
                
                DispatchQueue.main.async {
                    
                    //FIXME_____ FETCH PLACE ID ______//
                    let arraddress_components = dic?.value(forKey: "results")as! NSArray
                    
                    if arraddress_components.count > 0{
                        let dicaddress = arraddress_components.object(at: 0)as! NSDictionary
                        let strplace_id = String(format: "%@", dicaddress.value(forKey: "place_id")as? String ?? "")
                        self.performGoogleSearchPlaceID(strplaceid: strplace_id)
                    }
                    
                }
                
                break
            case .failure:
                print("failure")
            }
        }
    }
    //MARK: -  GET Lat Long by PlaceID - Google API
    func  performGoogleSearchPlaceID(strplaceid:String)
    {
        var strconnurl = String(format: "https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@", strplaceid,Constants.conn.GoogleAPIKey)
        strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
        print("strconnurl",strconnurl)
        AF.request(strconnurl,method: .get,encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            
            switch response.result{
            case .success(let JSON):
                
                //print("Success with JSON: \(String(describing: JSON))")
                
                //let array = JSON as? NSArray
                //print("array",array)
                
                let dic = JSON as? NSDictionary
                //print("dic",dic as Any)
                
                let dic1 = dic?.value(forKey: "result") as? NSDictionary
                //print("dic1",dic1 as Any)
                
                let dic2 = dic1?.value(forKey: "geometry") as? NSDictionary
                let dic3 = dic2?.value(forKey: "location") as? NSDictionary
                
                //FIXME_____ FETCH CITY AND LOCATION NAME ______//
                let arraddress_components = dic1?.value(forKey: "address_components")as! NSArray
                for xx in 0 ..< arraddress_components.count
                {
                    let dicaddress = arraddress_components.object(at: xx)as! NSDictionary
                    let strlong_name = String(format: "%@", dicaddress.value(forKey: "long_name")as? String ?? "")
                    
                    let arrmtypes = dicaddress.value(forKey: "types")as! NSArray
                    for yy in 0 ..< arrmtypes.count
                    {
                        let strtype = String(format: "%@", arrmtypes.object(at: yy)as? String ?? "")
                        if strtype == "sublocality" || strtype == "neighborhood" || strtype == "sublocality_level_1"
                        {
                            //THEN FETCH LOCATION NAME
                            print("strlong_name1",strlong_name)
                            //self.strlocationname = strlong_name
                        }
                        
                        if strtype == "administrative_area_level_1"
                        {
                            //THEN FETCH REGION NAME
                            print("strlong_name2",strlong_name)
                            self.strlocationname = strlong_name
                        }
                        
                        if strtype == "locality"
                        {
                            //THEN FETCH CITY NAME
                            print("strlong_name3",strlong_name)
                            self.strcityname = strlong_name
                        }
                    }
                }
                
                let strformatted_address =  String(format: "%@", dic1?.value(forKey: "formatted_address")as? String ?? "")
                print("strformattedaddress >>>>>>",strformatted_address)
                
                print("location name",self.strlocationname)
                print("city name",self.strcityname)
                
                
                
                let strlatselected = String(format: "%@", dic3?.value(forKey: "lat")as! CVarArg)
                let strlngselected = String(format: "%@", dic3?.value(forKey: "lng")as! CVarArg)
                print("strlatselected",strlatselected)
                print("strlngselected",strlngselected)
                
                DispatchQueue.main.async {
                    
                    self.strsearchlat = Double(strlatselected)!
                    self.strsearchlng = Double(strlngselected)!
                    print("strsearchlat",self.strsearchlat)
                    print("strsearchlng",self.strsearchlng)
                    
                    
                    
                    if self.txtsearch.text!.count > 0{
                        self.txtsearch.text = ""
                    }
                    print("strformatted_address --->",strformatted_address)
                    self.txtsearch.text = strformatted_address
                    
                    //let camera = GMSCameraPosition.camera(withLatitude: self.strsearchlat, longitude: self.strsearchlng, zoom: 2)
                    //self.mapview.animate(to: camera)
                    
                    //DROP A MARKER AT SEARCHED LOCATION COORDINATES
                    //let point = CLLocationCoordinate2DMake(self.strsearchlat,self.strsearchlng)
                    //self.mymarker.position = point
                    
                    
                    /*self.mymarker = GMSMarker()
                     self.mymarker.position = CLLocationCoordinate2DMake(self.strsearchlat, self.strsearchlng)
                     self.mymarker.appearAnimation = GMSMarkerAnimation.pop
                     self.mymarker.title = "My Location" // Marker title here
                     self.mymarker.snippet = ""
                     self.mymarker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
                     //self.mymarker.icon = UIImage(named: "marker") //Set marker icon here
                     self.mymarker.map = self.mapview // Mapview here*/
                    
                    //CHECK INSIDE / OUSTSIDE POLYGON AREA METHOD
                    //self.checkpolygonPointMultiple(lat: self.strsearchlat, long: self.strsearchlng)
                    //self.alertViewFunction()
                }
                break
            case .failure:
                print("failure")
            }
        }
    }
    
    //MARK: -  GET Lat Long by PlaceID111 - Google API
    func  performGoogleSearchPlaceID1111(strplaceid:String)
    {
        var strconnurl = String(format: "https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@", strplaceid,Constants.conn.GoogleAPIKey)
        strconnurl = strconnurl.replacingOccurrences(of: " ", with: "%20")
        print("strconnurl",strconnurl)
        AF.request(strconnurl,method: .get,encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.result)
            
            switch response.result{
            case .success(let JSON):
                
                //print("Success with JSON: \(String(describing: JSON))")
                
                //let array = JSON as? NSArray
                //print("array",array)
                
                let dic = JSON as? NSDictionary
                //print("dic",dic as Any)
                
                let dic1 = dic?.value(forKey: "result") as? NSDictionary
                //print("dic1",dic1 as Any)
                
                let dic2 = dic1?.value(forKey: "geometry") as? NSDictionary
                let dic3 = dic2?.value(forKey: "location") as? NSDictionary
                
                let strlatselected = String(format: "%@", dic3?.value(forKey: "lat")as! CVarArg)
                let strlngselected = String(format: "%@", dic3?.value(forKey: "lng")as! CVarArg)
                print("strlatselected",strlatselected)
                print("strlngselected",strlngselected)
                
                DispatchQueue.main.async {
                    
                    self.strsearchlat = Double(strlatselected)!
                    self.strsearchlng = Double(strlngselected)!
                    print("strsearchlat",self.strsearchlat)
                    print("strsearchlng",self.strsearchlng)
                    
                    let camera = GMSCameraPosition.camera(withLatitude:self.strsearchlat, longitude: self.strsearchlng, zoom: 15)
                    self.mapview.camera = camera
                    
                    //CHECK INSIDE / OUSTSIDE POLYGON AREA METHOD
                    self.checkpolygonPointMultiple(lat: self.strsearchlat, long: self.strsearchlng)
                    self.alertViewFunction()
                }
                break
            case .failure:
                print("failure")
            }
        }
    }
}

extension GMSPolygon {
    
    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        
        if self.path != nil {
            if GMSGeometryContainsLocation(coordinate, self.path!, true) {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
}
extension UIViewController{

func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
 }
