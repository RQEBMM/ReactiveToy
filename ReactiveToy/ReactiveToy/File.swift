//
//  File.swift
//  ReactiveToy
//
//  Created by Benjamin McCloskey on 8/27/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import RxSwift

class CarManager{
    
    var cars:[Car]?
    
    private var observing:Observable<Car>?
    
    
    func getCarStream() -> Observable<Car> {
        
        
        return [Car.init(v: "3213123", m: "corolla", tid: "1213", did: "1233", server_id: "sfdsfsd")].toObservable()
    }
    
    
    
}