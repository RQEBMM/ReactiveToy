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
    
}
extension APIImplementation : APIWrapper{
    func beginMonitoringCars() -> Observable<Car>{
        return Observable.create({ (subcriber) -> Disposable in
            //ill do stuff here to hit the api
        })
    }
    func fetchDealershipWithId(id:String)->Observable<Dealership>{
        return Observable.create({ (subcriber) -> Disposable in
            
        })
    }
    func fetchTrimWithTrimId(id:String)->Observable<Trim>{
        return Observable.create({ (subscriber) -> Disposable in
            
        })
    }
}