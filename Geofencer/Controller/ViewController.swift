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
    
    //create an instance of  geofence
    let fence = FenceManager(fence: Fence(latitude: 37.785834, longitude: 80.406416, radius: 100, id: "fence1"))
            
    override func viewDidLoad() {
        super.viewDidLoad()
        locationButton.layer.cornerRadius = 5
    }

    @IBAction func locationPressed(_ sender: Any) {
                
        fence.fenceTracking { [weak self]
            location  in
            DBManager.shared.createDB(with: location)
            //DBManager.shared.readDB()
        }
    }
    
    
}

