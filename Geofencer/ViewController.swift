//
//  ViewController.swift
//  Geofencer
//
//  Created by Karthik on 10/04/21.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    

    @IBOutlet weak var locationButton: UIButton!
    let DB = DBManager()
    
    let fence = FenceManager(fenceCenter: (CLLocationCoordinate2D.init(latitude: 37.785834, longitude: 80.406416)) , radius: 100, id: "fence1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationButton.layer.cornerRadius = 5
    }

    @IBAction func locationPressed(_ sender: Any) {
        
        fence.fenceTracking {
            location  in
            print(location.latitude,location.longitude)
            DBManager.shared.createDB(with: location)
            DBManager.shared.readDB()
        }
    }
    
    
}

