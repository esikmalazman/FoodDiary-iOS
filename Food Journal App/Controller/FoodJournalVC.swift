//
//  FoodJournalVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 16/04/2021.
//

import UIKit

class FoodJournalVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //array to store fetch messages, data for table
    var foodItems = [Food]()
    var foodRows : Int?
    
    let persistentManager = PersistentManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        fetchFood()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let foodInfo = self.foodItems[foodRows!]
        
        if segue.identifier == K.goToDetailFoodVCSegues {
            let destinationVC = segue.destination as! DetailFoodVC
            destinationVC.date = foodInfo.date
            destinationVC.desc = foodInfo.foodDesc
            destinationVC.image = UIImage(data:foodInfo.foodImg!,scale:1.0)!
        }
    }
}

//MARK:- TableViewDataSource Methods

extension FoodJournalVC : UITableViewDataSource {
    //determine number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodItems.count
    }
    //ask table view cell that it should display in each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get food from array
        let food = self.foodItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCellIdentifier, for: indexPath) as! FoodCell
        cell.foodCellContent(at: food)
        
        return cell
    }
}


//MARK:- UITableViewDelegate Methods

//manage user intereaction with tableview
extension FoodJournalVC: UITableViewDelegate {
    //take action on selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Get index of what table is select
        foodRows = indexPath.row
        //prefromSegues
        self.performSegue(withIdentifier: K.goToDetailFoodVCSegues, sender: self)
    }
    

    //swipe to left action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swipe action
        // UIContextualAction, allow an action to display when user swipe
        //.destructive, action to perform delete data/ destructive task
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            
            //1. Determine which food to delete
            guard let foodToRemove = self?.foodItems[indexPath.row] else { fatalError("Cannot remove Food that has been selected ")}
            
            //2. Remove the selected food object and save current context
            self?.persistentManager.deleteContext(for: foodToRemove)
            //4. Refetch the data
            self?.fetchFood()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//MARK:- Private methods

extension FoodJournalVC {
    
    private func renderView() {
        //listening for any notifcation that already send by sender from another VC
        NotificationCenter.default.addObserver(self, selector: #selector(fetchFood), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        //register custom design n file to be able to use in table view
        tableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: K.reusableCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @objc private func fetchFood() {
        foodItems = []
        //Fetch the data from Core Data to display in the table view
        do {
            //assign fetch data to array
            //fetch request from food model, grab all the data we have
            self.foodItems = try persistentManager.context.fetch(Food.fetchRequest())
            //make ui changes in main thread, to prevent perforamance impact
            DispatchQueue.main.async {
                //reload table view after get some data
                self.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
