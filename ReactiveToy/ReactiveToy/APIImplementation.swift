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
    
    var dummyDealerships:[String]?
    var dummyTrims:[String]?
    
    func guaranteeData() {
        
        dummyDealerships = generateDealerships()
        dummyTrims = generateTrims()
        generateCars()
        
    }
    func generateTrims()->[String]{
        var trims = [Trim]()
        trims.append(Trim.init(m: 1250, e: "4Liter Turbo", mpg: 25.57, n: "Premium"))
        trims.append(Trim.init(m: 1000, e: "2Liter Turbo", mpg: 25.57, n: "Basic"))
        trims.append(Trim.init(m: 1000, e: "2Liter Turbo", mpg: 25.57, n: "Standard"))
        var trimids = [String]()
        var childUpdates:[String: AnyObject] = [String: AnyObject]()
        for trim in trims{
            let key = ref.child("Trims").childByAutoId().key
            let post = [
                "msrp":trim.msrp!, "engine": trim.engine!, "mpg":trim.gasMileage!, "name":trim.name!]
            childUpdates["/Trims/\(key)"] = post
            trimids.append(key)
        }
        ref.updateChildValues(childUpdates)
        return trimids

    }
    
    func generateDealerships()->[String]{
        var ds = [Dealership]()
        ds.append(Dealership.init(n: "Toms Ford", a: "123 Main St", lat: 30.264, lng: -97.762))
        ds.append(Dealership.init(n: "Alans Toyota", a: "123 Long St", lat: 30.262, lng: -97.765))
        ds.append(Dealership.init(n: "Johhns Chevy", a: "123 Maple St", lat: 30.282, lng: -97.769))
        var childUpdates:[String: AnyObject] = [String: AnyObject]()
        var dealershipIds = [String]()
        for dealership in ds{
            let key = ref.child("Dealerships").childByAutoId().key
            let post = [
                    "name":dealership.name!, "address": dealership.address!, "latitude":dealership.latitude!, "longitude":dealership.longitude!]
            childUpdates["/Dealerships/\(key)"] = post
            
            dealershipIds.append(key)
        }
        ref.updateChildValues(childUpdates)
        return dealershipIds
    }
    
    func generateCars(){
        var cars = [Car]()
        
        let models = ["Corolla", "A4", "Accord", "Focus"]
        for _ in 0...30{
            if let trims = dummyTrims,
                let dealerships = dummyDealerships
            {
                let trim_id = trims[Int(arc4random_uniform(3))]
                let dealership_id = dealerships[Int(arc4random_uniform(3))]
                let model = models[Int(arc4random_uniform(4))]
                cars.append(Car.init(v: "12312312312", m:model, tid: trim_id, did: dealership_id))
                
            }

        }
        var childUpdates:[String: AnyObject] = [String: AnyObject]()
        for car in cars{
            let key = ref.child("Cars").childByAutoId().key
            let post = [
                "vin":car.vin!, "model": car.model!, "trim_id":car.trimId!, "dealership_id":car.dealershipId!]
            childUpdates["/Cars/\(key)"] = post
            
        }
        ref.updateChildValues(childUpdates)
    }
    
}
extension APIImplementation : APIWrapper{
    func beginMonitoringCars() -> Observable<[Car]>{
        return Observable.create({ (subscriber) -> Disposable in
            self.ref.child("Cars").observeEventType(FIRDataEventType.Value, withBlock: { (snapshots) in
                var cars:[Car] = []
                print(snapshots)
                for(_, snapshot) in snapshots.children.enumerate(){
                    if let firsnap = snapshot as? FIRDataSnapshot,
                    let postDict = firsnap.value as? [String:AnyObject],
                    let car = Car.init(json: postDict){
                        cars.append(car)
                    }

                }
                subscriber.on(.Next(cars))
            })
            return AnonymousDisposable {
                print("ack we wanted to cancel")
            }
        })
    }
    
    
        
    func fetchDealershipWithId(id:String)->Observable<Dealership>{
        
        return Observable.create({ (subscriber) -> Disposable in
            self.ref.child("Dealerships").child(id).observeSingleEventOfType(.Value, withBlock: { (snapshot:FIRDataSnapshot) in
                let postDict = snapshot.value as! [String : AnyObject]
                if let dealership = Dealership.init(json: postDict){
                    subscriber.onNext(dealership)
                    subscriber.onCompleted()
                }
                
                print("finished")
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            return AnonymousDisposable {
                print("ack we wanted to cancel")
            }

        })
    }
    func fetchTrimWithTrimId(id:String)->Observable<Trim>{
        return Observable.create({ (subscriber) -> Disposable in
            self.ref.child("Trims").child(id).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                let postDict = snapshot.value as! [String : AnyObject]
                if let trim = Trim.init(json: postDict){
                    subscriber.onNext(trim)
                    subscriber.onCompleted()
                }
                
                print("finished")
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            return AnonymousDisposable {
                print("ack we wanted to cancel")
            }
            
        })

    }
}