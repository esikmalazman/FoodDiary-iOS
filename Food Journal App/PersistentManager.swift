//
//  PersistentManager.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 22/08/2021.
//

import UIKit

struct PersistentManager {
    
    static let shared = PersistentManager()
    
    //UIApplication.shared.delegate as! AppDelegate, allow access to app delegate
    // .persistentContainer, allow access to persistent container(db)
    //.viewContext, allow to manage reference to persistent container to store & retrieve from core data
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveContext() {
        do {
            print("Item saved")
            try self.context.save()
            
        } catch {
            print(error)
        }
    }
    
    func deleteContext(for food : Food) {
        print("Item deleted")
        context.delete(food)
        saveContext()
    }
}
