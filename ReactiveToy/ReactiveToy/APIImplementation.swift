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
    func beginMonitoringCars() -> Observable<Car>{
        return Observable.just(Car.init())
    }
    func fetchDealershipWithId(id:String)->Observable<Dealership>{
        return Observable.just(Dealership.init())
    }
    func fetchTrimWithTrimId(id:String)->Observable<Trim>{
        return Observable.just(Trim.init())
    }
}