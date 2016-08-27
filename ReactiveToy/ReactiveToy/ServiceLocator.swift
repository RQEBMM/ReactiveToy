//
//  ServiceLocator.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation

class ServiceLocator{
    static let sharedInstance = ServiceLocator()
    
    lazy var apiWrapper = APIImplementation.init()
    lazy var carManager = CarManager.init()
    
    init(){
        apiWrapper.guaranteeData()
    }
    
    func getApiWrapper()->APIWrapper {
        return apiWrapper
    }
    
    func getCarManager()->CarManager {
        return carManager
    }
    
}