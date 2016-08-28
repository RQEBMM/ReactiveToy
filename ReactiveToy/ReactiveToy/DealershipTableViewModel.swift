//
//  DealershipTableViewModel.swift
//  ReactiveToy
//
//  Created by Benjamin McCloskey on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation

class DealershipTableViewModel {
    
    var name:String
    var cars:[CarViewModel]?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, cars:[CarViewModel]) {
        self.name = name
        self.cars = cars
    }
}
    