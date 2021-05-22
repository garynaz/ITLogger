//
//  MiscFunctions.swift
//  ITLogger
//
//  Created by Gary Naz on 5/21/21.
//

import SwiftUI
import CoreData


//Allows for the use of Optionals where Binding parameters are required (Ex.TextFields).
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

func fetchUserDetails(withUser user: String) -> User? {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<User>(entityName: "User")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "username == %@", user)
    
    do {
        let fetchUser = try context.fetch(fetchRequest)
        return fetchUser.first
    } catch let fetchError {
        print("Failed to fetch: \(fetchError)")
    }
    return nil
}

func fetchUserTicketDetails(inquiry: String) -> Ticket? {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Ticket>(entityName: "Ticket")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "inquiry == %@", inquiry)
    
    do {
        let fetchUser = try context.fetch(fetchRequest)
        return fetchUser.first
    } catch let fetchError {
        print("Failed to fetch: \(fetchError)")
    }
    return nil
}



func createUserObject(company: String, name: String, username: String, password: String, photo: UIImage?, admin: Bool){
    //Produces a Data object from an Array of Images.
    func coreDataObjectFromImages(image: UIImage) -> Data? {
        let dataArray = NSMutableArray()
        
        if let data = image.pngData() {
            dataArray.add(data)
        }
        return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let newUser = User(context: context)
    newUser.id = UUID()
    newUser.admin = admin
    newUser.company = company
    newUser.name = name
    newUser.username = username
    newUser.password = password
    newUser.photo = coreDataObjectFromImages(image: (photo ?? UIImage(systemName:"person.circle")!))
    
    do {
        try context.save()
        print("New User Created")
    } catch {
        print(error)
    }
}

func createTicketObject(user: User, inquiry: String, priority: String, status: String, type: String){
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm E, d MMM y"
    
    let newTicket = Ticket(context: context)
    newTicket.id = UUID()
    newTicket.date = formatter.string(from: today)
    newTicket.inquiry = inquiry
    newTicket.priority = priority
    newTicket.status = status
    newTicket.type = type
    
    user.addToTickets(newTicket)
    
    do {
        try context.save()
        print("New Ticket Created")
    } catch {
        print(error)
    }
}

//Produces an Array of Images from a Data object.
func imagesFromCoreData(object: Data?) -> [UIImage]? {
    var retVal = [UIImage]()
    
    guard let object = object else { return nil }
    if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
        for data in dataArray {
            if let data = data as? Data, let image = UIImage(data: data) {
                retVal.append(image)
            }
        }
    }
    return retVal
}
