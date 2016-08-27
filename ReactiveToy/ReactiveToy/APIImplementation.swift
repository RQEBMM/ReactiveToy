//
//  APIImplementation.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import RxSwift
import Firebase


class APIImplementation{
    lazy var ref = FIRDatabase.database().reference()
    
    func guaranteeData() {
        
        generateDealerships()
    }
    
    func generateDealerships(){
        var ds = [Dealership]()
        ds.append(Dealership.init(n: "Toms Ford", a: "123 Main St", lat: 30.264, lng: -97.762))
        ds.append(Dealership.init(n: "Alans Toyota", a: "123 Long St", lat: 30.262, lng: -97.765))
        ds.append(Dealership.init(n: "Johhns Chevy", a: "123 Maple St", lat: 30.282, lng: -97.769))
        var childUpdates:[String: AnyObject] = [String: AnyObject]()
        for dealership in ds{
            let key = ref.child("Dealerships").childByAutoId().key
            let post = [
                    "name":dealership.name, "address": dealership.address, "latitude":dealership.latitude, "longitude":dealership.longitude]
            childUpdates["/Dealerships/\(key)"] = post
        }
        ref.updateChildValues(childUpdates)
    }
    
}
extension APIImplementation : APIWrapper{
    func beginMonitoringCars() -> Observable<[Car]>{
        return Observable.just([Car.init(aVin: "231342423423423", aModel: "Corolla", aTrimId: "123", aDealershipId: "555")])
    }
    func fetchDealershipWithId(id:String)->Observable<Dealership>{
        return Observable.just(Dealership.init(n: "Tom's Ford Dealership", a: "123 Main St", lat: 30.2324, lng: -97.321))
    }
    func fetchTrimWithTrimId(id:String)->Observable<Trim>{
        return Observable.just(Trim.init(m: 3250, e: "4Liter Turbo", mpg: 25.52, n: "Premium"))
    }
}