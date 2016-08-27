//
//  APIWrapper.swift
//  ReactiveToy
//
//  Created by Avtar Khalsa on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import Foundation
import RxSwift


protocol APIWrapper{
    func beginMonitoringCars() -> Observable<[Car]>;
    func fetchDealershipWithId(id:String)->Observable<Dealership>;
    func fetchTrimWithTrimId(id:String)->Observable<Trim>;
    
}