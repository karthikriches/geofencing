//
//  DBManager.swift
//  Geofencer
//
//  Created by Karthik on 10/04/21.
//

import UIKit
import CoreData

class DBManager {
    
    static let shared = DBManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func createDB(with loc:CLLocationCoordinate2D){
        let entity = Location(context:context)
        entity.latitude = loc.latitude
        entity.longitude = loc.longitude
        do {
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    func readDB(){
        let request  : NSFetchRequest = Location.fetchRequest()
        do {
           let data = try context.fetch(request)
            print(data.count)
            for i in data {
                print( i.value(forKey: "latitude") ?? "" )
                print( i.value(forKey: "longitude") ?? "" )
            }
        }
        catch {
            
        }
        
    }

}
