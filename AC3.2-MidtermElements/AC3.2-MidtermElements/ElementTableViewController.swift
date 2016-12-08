//
//  ElementTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by John Gabriel Breshears on 12/8/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import UIKit

class ElementTableViewController: UITableViewController {
    var endPoint: String = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    var allElements: [Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breaking Elements"
        loadTableview()
    }
    
    func loadTableview() {
        APIRequestManager.manager.getData(endPoint: endPoint) { ( data: Data?) in
            guard let unwrappedData = data else {return}
            self.allElements = Element.buildElementsArray(from: unwrappedData)!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }//end of closure
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        dump(allElements.count)
        return allElements.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        let thisPath = allElements[indexPath.row]
        cell.textLabel?.text = thisPath.name
        cell.detailTextLabel?.text = ("\(thisPath.symbol)") + ("(") + ("\(thisPath.number)") + (")") + ("\(thisPath.weight)")
        
       
        APIRequestManager.manager.getData(endPoint: thisPath.thumbNailImage) { ( data: Data?) in
            guard let unwrappedData = data else {return}
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: unwrappedData)
                cell.setNeedsLayout()
            }
        }//end clousre
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let selectedCell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: selectedCell) {
                  let thisElement = allElements[indexPath.row]
                if let destationViewController = segue.destination as? ElementDetailViewController {
                    destationViewController.detailElement = thisElement
                }
            }
        }
    }
        
    
    
    
    /*
 
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "albumTrack" {
     
     let selectedCell = sender as! UITableViewCell
     
     if let indexPath = tableView.indexPath(for: selectedCell){
     
     let thisAlbum = allSpotifyAlbums[indexPath.row]
     
     if let destationViewController = segue.destination as? DetailViewController {
     destationViewController.detailThisAlbum = thisAlbum
     }
     }
     
     }
     
     
     }
 */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
