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
    var fence2 : FenceManager!

    override func setUp() {
        super.setUp()
        fence1 = FenceManager(fenceCenter: (CLLocationCoordinate2D.init(latitude: 37.785834, longitude: 80.406416)) , radius: 100, id: "fence1")
        fence2 = FenceManager(fenceCenter: (CLLocationCoordinate2D.init(latitude: 12.785834, longitude: 80.406416)) , radius: 100, id: "fence2")

    }
    
    
    override  func tearDown() {
        super.tearDown()
        print("tear down")
        fence1 = nil
        fence2 = nil
    }
    
    
    func test1(){
        let expect = expectation(description: "geofenceEntryExit")
        let mock = mockFenceDelegate()
        fence1.delegate = mock
        fence1.fenceTracking { (location) in
            XCTAssertNotNil(location)
            expect.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)


    }
    
}


class mockFenceDelegate : NSObject, CLLocationManagerDelegate  {
    
    private var expectation : XCTestExpectation?
    var didEnter : ((Bool)->Void)?
        
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        didEnter!(true)
    }
    

    
}
