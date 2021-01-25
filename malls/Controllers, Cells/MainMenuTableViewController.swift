//
//  MainMenuTableViewController.swift
//  malls
//
//  Created by Anna Nosyk on 19.01.2021.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    

    var malls = [Malls(name: "Posnania", location: "Poznan", imageTest: "posnania"),
                 Malls(name: "King Cross", location: "Poznan", imageTest: "kingcross"),
                 Malls(name: "Galeria Malta", location: "Poznan", imageTest: "malta"),
                 Malls(name: "Avenida", location: "Poznan", imageTest: "aveninda"),
                 Malls(name: "Galeria A2", location: "Poznan", imageTest: "a2"),
                 Malls(name: "Galeria MM", location: "Poznan", imageTest: "mm"),
                 Malls(name: "Galeria Pestka", location: "Poznan", imageTest: "pestka"),
                 Malls(name: "Galeria Arkada", location: "Poznan", imageTest: "arkady"),
                 Malls(name: "Stary Browar", location: "Poznan", imageTest: "stary browar")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return malls.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        let mall = malls[indexPath.row]
        cell.nameLabel.text = mall.name
        cell.locationLabel.text = mall.location
        
        // which image do assign
        if mall.image == nil {
            cell.imageOfMall.image = UIImage(named: mall.imageTest!)
        } else {
            cell.imageOfMall.image = mall.image
        }
        
        cell.imageOfMall.layer.cornerRadius = cell.imageOfMall.frame.size.height/2
        cell.imageOfMall.clipsToBounds = true
        return cell
    }
    
    //save new value for  items
    @IBAction func unwidSegue(_ segue: UIStoryboardSegue) {
        
        guard let newMallVC = segue.source as? NewMallController else { return }
        
        newMallVC.saveNewMall()
        malls.append(newMallVC.newMall!)
        tableView.reloadData()
    }
}
