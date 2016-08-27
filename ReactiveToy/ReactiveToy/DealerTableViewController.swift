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
    
    var dealerships:[DealershipTableViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ServiceLocator.sharedInstance.getApiWrapper().beginMonitoringCars()
            .flatMap { cars -> Observable<Car> in
                cars.toObservable()
            }.map { (car) -> String in
                car.dealershipId!
            }.distinctUntilChanged().flatMap { (dealerId) -> Observable<Dealership> in
                ServiceLocator.sharedInstance.getApiWrapper().fetchDealershipWithId(dealerId)
            }.map { (dealership) -> DealershipTableViewModel in
                DealershipTableViewModel(name: dealership.name!)
            }.map { (dealershipVm) in
                self.dealerships?.append(dealershipVm)
                print(self.dealerships)
        }
        
                
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
        
        guard let sections = dealerships else {return 0}
        
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let myDealerships = dealerships else {return 0}
        let section = myDealerships[section]
        
        return section.cars!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forIndexPath: indexPath)
        
        guard let myDealerships = dealerships else {return cell}
        let theCar = myDealerships[indexPath.section].cars![indexPath.row]
        
        cell.textLabel!.text = theCar.name
        cell.detailTextLabel!.text = theCar.trim
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let myDealerships = dealerships else {return ""}
        let theDealer = myDealerships[section]
        
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
