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
    
    lazy var mWrapper = APIImplementation.init()
    
    func getAPIWrapper()->APIWrapper{
        return mWrapper
    }
    init(){
        //mWrapper.guaranteeData()
    }
}