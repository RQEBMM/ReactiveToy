//
//  DealerTableViewController.swift
//  ReactiveToy
//
//  Created by Benjamin McCloskey on 8/26/16.
//  Copyright © 2016 AB. All rights reserved.
//

import UIKit
import RxSwift

class DealerTableViewController: UITableViewController {
    
    class DealershipTableViewModel {
        
        var name:String
        var id:String
        var cars = [CarViewModel]()
        
        init(name: String, id: String) {
            self.name = name
            self.id = id
        }
        
        init(name: String, cars:[CarViewModel], id:String) {
            self.name = name
            self.cars = cars
            self.id = id
        }
    }
    
    class CarViewModel {
        
        var name:String
        var trim:String
        
        init(aName: String, aTrim:String) {
            name = aName
            trim = aTrim
        }
    }
    
    var tableViewModel = [DealershipTableViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cars by Dealership"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var dealerships = [Dealership]()
        var dealerIds = [String]()
        var carTainer = [String:String]()
        var carModels = [CarViewModel]()
        var carCache = [Car]()
        
        ServiceLocator.sharedInstance.getApiWrapper().beginMonitoringCars()
            .flatMap { cars -> Observable<Car> in
                carCache = cars
                return cars.toObservable()
            }.map { (car) -> String in
                car.dealershipId!
            }.filter { (dealerId) -> Bool in
                if (dealerIds.contains(dealerId)) {
                    return false
                } else {
                    dealerIds.append(dealerId)
                    return true
                }
            }.flatMap { (dealerId) -> Observable<Dealership> in
                ServiceLocator.sharedInstance.getApiWrapper().fetchDealershipWithId(dealerId)
            }.map { (dealership) -> DealershipTableViewModel in
                dealerships.append(dealership)
                return DealershipTableViewModel(name: dealership.name!, id:dealership.id)
            }.map { (dealershipvm) -> DealershipTableViewModel in
                carCache.toObservable()
                    .filter { (car) -> Bool in
                        if(dealershipvm.id == car.dealershipId){
                            return true
                        }else{
                            return false
                        }
                    }.map { (car) -> Car in
                        ServiceLocator.sharedInstance.getApiWrapper().fetchTrimWithTrimId(car.trimId!)
                            .map { (trim) in
                                dealershipvm.cars.append(CarViewModel(aName: car.model!, aTrim: trim.name!))
                                
                                self.tableViewModel.append(dealershipvm)
                                self.tableView.reloadData()
                                print("dealerVM: \(dealershipvm.cars)")
                        }
                }
                
                return dealershipvm
            }.subscribeNext {_ in
                self.tableView.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return tableViewModel.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let cars = tableViewModel[section].cars
        
        return cars.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forIndexPath: indexPath)
        
        let theCar = tableViewModel[indexPath.section].cars[indexPath.row]
        
        cell.textLabel!.text = theCar.name
        cell.detailTextLabel!.text = theCar.trim
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let theDealer = tableViewModel[section]
        
        return theDealer.name
    }
    
    
}
