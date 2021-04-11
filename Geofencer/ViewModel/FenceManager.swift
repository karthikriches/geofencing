//
//  LocationManager.swift
//  Geofencer
//
//  Created by Karthik on 10/04/21.
//

import Foundation
import CoreLocation

class  FenceManager : NSObject, CLLocationManagerDelegate {
    
    private let manager  = CLLocationManager()
    private let fence : Fence!
    private var completion :((CLLocationCoordinate2D)->Void)?
    weak  var  delegate : CLLocationManagerDelegate?

    init(fence : Fence) {
        self.fence = fence
        super.init()
        self.createFence()
    }
    
    func fenceTracking(completion:@escaping(CLLocationCoordinate2D)->()){
      self.completion=completion
      manager.requestAlwaysAuthorization()
      manager.delegate=self
    }
    
    private func createFence(){
        let center = CLLocationCoordinate2D(latitude: fence.latitude, longitude: fence.longitude)
        let fenceRegion = CLCircularRegion(center: center, radius: fence!.radius, identifier: fence!.id)
        fenceRegion.notifyOnEntry=true
        fenceRegion.notifyOnExit=true
        manager.startMonitoring(for: fenceRegion)
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
