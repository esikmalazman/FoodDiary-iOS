//
//  FoodJournalVC.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 16/04/2021.
//

import UIKit

//UITableViewSource, to display items in table view
class FoodJournalVC: UIViewController,UITableViewDataSource
{
   
    

    @IBOutlet weak var tableView: UITableView!
    //manage & reference to persistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //array to store fetch messages, data for table
    var items : [Food]?
   
    
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //listening for any notifcation that already send by sender from another VC
        NotificationCenter.default.addObserver(self, selector: #selector(fetchFood), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        //register custom design n file to be able to use in table view
        tableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: K.reusableCellIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        //assign table view to adopt delegate
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        fetchFood()
    }
    
    @objc func fetchFood()
    {
        items = []
        //Fetch the data from Core Data to display in the table view
        do
        {
            //assign fetch data to array
            //fetch request from food model, grab all the data we have
            self.items = try context.fetch(Food.fetchRequest())
            
            //make ui changes in main thread, to prevent perforamance impact
            DispatchQueue.main.async
            {
                //reload table view after get some data
                self.tableView.reloadData()
            }
           
        }
        catch
        {
            print(error)
        }
      
    }
    
    //determine number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.items?.count ?? 0
        
    }
    //ask table view cell that it should display in each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Get food from array
        let food = self.items![indexPath.row]
        //create a cell to return to table view
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCellIdentifier, for: indexPath) as! FoodCell
        cell.dateLabel.text = food.date
        cell.descriptionLabel.text = food.foodDesc
        
        
        // allows to remove
        // Instance will be immediately deallocated because property ‘imageView’ is ‘weak’
        //convert Data to UIImage
        cell.foodImage.image = UIImage(data:food.foodImg!,scale:1.0)!
        //set cell text
//        cell.textLabel?.text = food.foodDesc
        return cell
        
    }


}

//manage user intereaction with tableview
//MARK:- UITableViewDelegate

extension FoodJournalVC:UITableViewDelegate
{
    //swipe to left action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        //Create swipe action
        
        //UIContextualAction, allow an action to display when user swipe
        //.destructive, action to perform delete data/ destructive task
        let action = UIContextualAction(style: .destructive, title: "Delete")
        { (action, view, completionHandler) in
            
            //1. Which food to delete
            let foodToRemove = self.items![indexPath.row]
            
            //2. Remove the move
            self.context.delete(foodToRemove)
            
            //3. Save the data
            do
            {
            try self.context.save()
            }
            catch
            {
                print(error)
            }
            
            //4. Refetch the data
            self.fetchFood()
        }
       
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
