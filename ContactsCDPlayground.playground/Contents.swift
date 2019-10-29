import Foundation
import CoreData

let entityName = "Contact"
let coreDataStack = CoreDataStack()


// saving data with CoreData
let contactEntity = NSEntityDescription.entity(forEntityName: entityName, in: coreDataStack.context)

//let batman = Contact(entity: contactEntity!, insertInto: coreDataStack.context)
let batman = Contact(entity: contactEntity!, insertInto: coreDataStack.context)

batman.id = 1
batman.name = "Batman"

coreDataStack.saveContext()

// let's save two more (in non-alphabetical order)
let arrow = Contact(entity: contactEntity!, insertInto: coreDataStack.context)
arrow.id = 2
arrow.name = "Green Arrow"
coreDataStack.saveContext()

let flash = Contact(entity: contactEntity!, insertInto: coreDataStack.context)
flash.id = 3
flash.name = "Flash"
coreDataStack.saveContext()


// retrieving data with CoreData
let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
//let fetchRequest = NSFetchRequest(entityName: entityName)

let sort = NSSortDescriptor(key:"name", ascending: true)
fetchRequest.sortDescriptors = [sort]


if let results = try? coreDataStack.context.fetch(fetchRequest) as? [Contact] {
  results.count
  results[0].name
  results[1].name
  results[2].name
} else {
  print("There was an error getting the results")
}


// filtering data with predicates (more on predicates
// at http://nshipster.com/nspredicate/)

let predicate = NSPredicate(format: "name = 'Batman'")
//let predicate = NSPredicate(format: "name contains 'm'")
//let predicate = NSPredicate(format: "name beginswith[c] 'bat'")  // [c] makes case-insensitive
//let predicate = NSPredicate(format: "name endswith 'man'")
//let predicate = NSPredicate(format: "name like 'B*'")  // use ? if match only 1 char
fetchRequest.predicate = predicate

//if let resultsBM = try? coreDataStack.context.executeFetchRequest(fetchRequest) as! [Contact] {
if let resultsBM = try? coreDataStack.context.fetch(fetchRequest) as! [Contact] {
  resultsBM.count
  resultsBM[0].name
} else {
  print("There is no Batman in the database")
}
