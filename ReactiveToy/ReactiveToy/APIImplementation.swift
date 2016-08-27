//
//  APIImplementation.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import RxSwift

class APIImplementation{
    func guaranteeData() {
        
    }
}
extension APIImplementation : APIWrapper{
    func beginMonitoringCars() -> Observable<[Car]>{
        return Observable.just([Car.init(v: "231342423423423", e: "White", i: "Tan", tid: "123", did: "555")])
    }
    func fetchDealershipWithId(id:String)->Observable<Dealership>{
        return Observable.just(Dealership.init(n: "Tom's Ford Dealership", a: "123 Main St", lat: 30.2324, lng: -97.321))
    }
    func fetchTrimWithTrimId(id:String)->Observable<Trim>{
        return Observable.just(Trim.init(m: 3250, e: "4Liter Turbo", mpg: 25.52, n: "Premium"))
    }
}