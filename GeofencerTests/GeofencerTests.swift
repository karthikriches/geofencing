//
//  GeofencerTests.swift
//  GeofencerTests
//
//  Created by Karthik on 10/04/21.
//

import XCTest
@testable import Geofencer
import  CoreLocation

class GeofencerTests: XCTestCase {

    var fence1 : FenceManager!

    override func setUp() {
        super.setUp()
        fence1 = FenceManager(fenceCenter: (CLLocationCoordinate2D.init(latitude: 37.785834, longitude: 80.406416)) , radius: 100, id: "fence1")

    }
    
    
    override  func tearDown() {
        super.tearDown()
        print("tear down")
        fence1 = nil
    }
    
    
    func test1(){
        let expect = expectation(description: "geofenceEntryExit")

        fence1.fenceTracking { location in
            XCTAssertNotNil(location)
            expect.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)


    }
    
}


class mockFenceDelegate : NSObject, CLLocationManagerDelegate  {
    
    var action = "false"
        
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        action="entry"
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        action="exit"
    }
    
    
}
