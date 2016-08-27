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
        var cars:[CarViewModel]?
        
        init(name: String) {
            self.name = name
        }
        
        init(name: String, cars:[CarViewModel]) {
            self.name = name
            self.cars = cars
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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var dealerships = [DealershipTableViewModel]()
        var dealerIds = [String]()
        var carTainer = [String:String]()
        var carModels = [CarViewModel]()
        var cars = [Car]()
        
        let carStream = ServiceLocator.sharedInstance.getApiWrapper().beginMonitoringCars()
            .flatMap { cars -> Observable<Car> in
                cars.toObservable()
        }
        carStream.map { (car) -> String in
                cars.append(car)
                return car.dealershipId!
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
                DealershipTableViewModel(name: dealership.name!)
            }.map { (dealershipVm) in
                dealerships.append(dealershipVm)
                self.tableView.reloadData()
            }.subscribeNext{
                print(dealerships)
                print(cars)
                // now we have dealerships and cars
                cars.toObservable().map { (car) -> Car in
                    car.trim = 
        }
        
//        carStream.map { (car) -> (String,String) in
//            (car.model!,car.trimId!)
//            }.flatMap { (modelTrimTuple) -> Observable<(String,Trim)> in
//                (modelTrimTuple.0, ServiceLocator.sharedInstance.getApiWrapper().fetchTrimWithTrimId(modelTrimTuple.1))
//            }.map { (modelTrimObjTuple) -> CarViewModel in
//                self.carModels.append(CarViewModel(aName:modelTrimObjTuple.0, aTrim:modelTrimObjTuple.1.name))
//            }.subscribeNext{}
//        
        
        print(self.dealerships)
        
        title = "Cars by Dealership"
        
        //        dealerships = [
        //            DealershipTableViewModel(name: "A Dealer", carList:[
        //                CarViewModel(aName:"Car 1", aTrim:"Trim 1"),
        //                CarViewModel(aName:"Car 2", aTrim:"Trim 2"),
        //                CarViewModel(aName:"Car 3", aTrim:"Trim 3")
        //                ]),
        //            DealershipTableViewModel(name: "Another Dealer", carList:[
        //                CarViewModel(aName:"Car A", aTrim:"Trim A"),
        //                CarViewModel(aName:"Car B", aTrim:"Trim B"),
        //                CarViewModel(aName:"Car C", aTrim:"Trim C")
        //                ])
        //        ]
        
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
        
        guard let cars = tableViewModel[section].contents.cars else {return 0}
        
        return cars.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forIndexPath: indexPath)
        
        let theCar = tableViewModel[indexPath.section].cars![indexPath.row]
        
        cell.textLabel!.text = theCar.name
        cell.detailTextLabel!.text = theCar.trim
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let theDealer = dealerships[section]
        
        return theDealer.dealerName
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
