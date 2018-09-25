//
//  statePreViewController.swift
//  Unity-iPhone
//
//  Created by Administrator on 2018/9/18.
//

import UIKit
import MapKit
import CoreLocation
class statePreViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    let fullScreenSize = UIScreen.main.bounds.size
    var whichOne = Int()
    let locationManager = CLLocationManager()

    @IBOutlet var btnMenu: UIBarButtonItem!

    @IBOutlet weak var btnWrite: UIButton!

    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var lblshow: UILabel!
    @IBOutlet weak var lblshow2: UILabel!
    
    func getNowMM()->Int{                 //取得目前時間的分數
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "mm"
        let time:Int = Int(dformatter.string(from: now))!
        //print("目前分鐘數：" + String(time))
        return time
    }
    func howLong(whichOne:Int,mylat:Double,mylng:Double) -> Double {                              //計算距離
        var distance:Double
        switch whichOne {
        case 1: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9946605, lng2:121.5887605) * 1000
        case 2: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9975801, lng2:121.5799735) * 1000
        case 3: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9932772, lng2:121.5900815) * 1000
        case 4: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9921553, lng2:121.5890408) * 1000
        case 5: distance = xx(lat1:mylat,lng1:mylng,lat2:24.995106, lng2:121.583514) * 1000
        case 6: distance = xx(lat1:mylat,lng1:mylng,lat2:24.9977223, lng2:121.5810719) * 1000
        default: distance = 0.0
        }
        return distance
    }
    func rad(d:Double)->Double{                                             //距離演算法
        return (d * 3.14159265358979) / 180.0
    }
    func xx (lat1:Double,lng1:Double,lat2:Double,lng2:Double)->Double{      //距離演算法
        let earthRadius:Double=6378.137
        
        let radLat1:Double = rad(d:lat1)
        let radLat2:Double = rad(d:lat2)
        let a:Double = radLat1 - radLat2
        let b:Double = rad(d:lng1) - rad(d:lng2)
        var s:Double = 2 * asin(sqrt(pow(sin(a/2),2) + cos(radLat1) * cos(radLat2) * pow(sin(b/2),2)))
        s = s * earthRadius
        s = round(s*10000) / 10000
        return s
        
    }
    
    func distanceIs(distance:Double)->Bool{                                  //判斷距離是否到達
        var yn:Bool
        if distance<=10 {yn = true}
        else{yn = false}
        return yn
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = CLLocationDistance(3); //表示移動3公尺再更新座標資訊
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
       
        
        //控制物件位置---------------------
        lblshow.text = String(whichOne)
        btnPre.frame = CGRect(x: Int((fullScreenSize.width * 0)) , y:Int((fullScreenSize.height * 0.89)) , width: Int((fullScreenSize.width * 0.5)) , height: Int((fullScreenSize.width * 0.1)))
        btnGuess.frame = CGRect(x: Int((fullScreenSize.width * 0.5)) , y:Int((fullScreenSize.height * 0.89)) , width: Int((fullScreenSize.width * 0.5)) , height: Int((fullScreenSize.width * 0.1)))

        btnWrite.frame = CGRect(x: Int((fullScreenSize.width * 0.35)) , y:Int((fullScreenSize.height * 0.83)) , width: Int((fullScreenSize.width * 0.3)) , height: Int((fullScreenSize.width * 0.1)))
        btnWrite.setBackgroundImage(UIImage(named: "btn_reward0" ), for: UIControlState.normal)
        btnWrite.setTitleColor(UIColor.white, for: UIControlState.normal)
        if UserDefaults.standard.bool(forKey: "english"){
            btnWrite.setTitle("Write", for: UIControlState.normal)
        }else{
            btnWrite.setTitle("填寫", for: UIControlState.normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        var mylat,mylng:Double
        mylat=location.coordinate.latitude
        mylng=location.coordinate.longitude
        howLong(whichOne: whichOne, mylat: mylat, mylng: mylng)
        lblshow2.text = String(howLong(whichOne: whichOne, mylat: mylat, mylng: mylng))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSelect1"{
            let xx:State_select = segue.destination as! State_select
            xx.whichOne = whichOne
        }else{
            let xx:stateGuessViewController = segue.destination as! stateGuessViewController
        xx.whichOne = whichOne
        }
    }
    

}
