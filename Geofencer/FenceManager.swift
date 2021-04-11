//
//  LocationManager.swift
//  Geofencer
//
//  Created by Karthik on 10/04/21.
//

import Foundation
import CoreLocation

class  FenceManager : NSObject, CLLocationManagerDelegate {
    
    let manager  = CLLocationManager()
    private let fenceCenter : CLLocationCoordinate2D
    private let radius : Double
    private let id : String
    private var completion :((CLLocationCoordinate2D)->Void)?
    weak  var  delegate : CLLocationManagerDelegate?


    init(fenceCenter:CLLocationCoordinate2D,radius:Double, id : String) {
        self.fenceCenter = fenceCenter
        self.radius = radius
        self.id = id
        super.init()
        self.createFence()
    }
    
    func fenceTracking(completion:@escaping(CLLocationCoordinate2D)->()){
      self.completion=completion
      manager.requestAlwaysAuthorization()
      manager.delegate=self
    }
    
    private func createFence(){
        let fence = CLCircularRegion(center: fenceCenter, radius: radius, identifier: id)
        fence.notifyOnEntry=true
        fence.notifyOnExit=true
        manager.startMonitoring(for: fence)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let location = manager.location?.coordinate else {
            return
        }
        print("Entering fence",location.latitude,location.longitude,manager.location!.timestamp)
        completion?(location)
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        guard let location = manager.location?.coordinate else {
            return
        }
        print("Exiting fence",location.latitude,location.longitude,manager.location!.timestamp)
        completion?(location)
    }
}
