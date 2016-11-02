import Foundation
import CoreData

let entityName = "Contact"
let coreDataStack = CoreDataStack()

// saving data with CoreData
let contactEntity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: coreDataStack.context)

let batman = Contact(entity: contactEntity!, insertIntoManagedObjectContext: coreDataStack.context)

batman.id = 1
batman.name = "Batman"

coreDataStack.saveContext()

// let's save two more (in non-alphabetical order)
let arrow = Contact(entity: contactEntity!, insertIntoManagedObjectContext: coreDataStack.context)
arrow.id = 2
arrow.name = "Green Arrow"
coreDataStack.saveContext()

let flash = Contact(entity: contactEntity!, insertIntoManagedObjectContext: coreDataStack.context)
flash.id = 3
flash.name = "Flash"
coreDataStack.saveContext()


// retrieving data with CoreData
let fetchRequest = NSFetchRequest(entityName: entityName)

let sort = NSSortDescriptor(key:"name", ascending: true)
fetchRequest.sortDescriptors = [sort]

if let results = try? coreDataStack.context.executeFetchRequest(fetchRequest) as! [Contact] {
  results.count
  results[0].name
  results[1].name
  results[2].name
} else {
  print("There was an error getting the results")
}
