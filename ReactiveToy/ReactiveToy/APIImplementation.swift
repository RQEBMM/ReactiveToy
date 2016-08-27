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
    
    var dummyDealerships:[Dealership]?
    var dummyTrims:[Trim]?
    
    func guaranteeData() {
        
        dummyDealerships = generateDealerships()
        dummyTrims = generateTrims()
        
    }
    func generateTrims()->[Trim]{
        var trims = [Trim]()
        trims.append(Trim.init(m: 1250, e: "4Liter Turbo", mpg: 25.57, n: "Premium"))
        trims.append(Trim.init(m: 1000, e: "2Liter Turbo", mpg: 25.57, n: "Basic"))
        trims.append(Trim.init(m: 1000, e: "2Liter Turbo", mpg: 25.57, n: "Standard"))
        var childUpdates:[String: AnyObject] = [String: AnyObject]()
        for trim in trims{
            let key = ref.child("Trims").childByAutoId().key
            let post = [
                "msrp":trim.msrp, "engine": trim.engine, "mpg":trim.gasMileage, "name":trim.name]
            childUpdates["/Trims/\(key)"] = post
        }
        ref.updateChildValues(childUpdates)
        return trims

    }
    
    func generateDealerships()->[Dealership]{
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
        return ds
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