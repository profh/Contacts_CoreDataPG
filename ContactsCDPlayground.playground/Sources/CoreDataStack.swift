import Foundation
import CoreData

// again, making public so playground can access these

public class CoreDataStack {
  
  public let model:NSManagedObjectModel
  public let persistentStoreCoordinator:NSPersistentStoreCoordinator
  public let context:NSManagedObjectContext
  
  public init() {
    // initialize our contact entity
    let contactEntity = NSEntityDescription()
    contactEntity.name = "Contact"
    contactEntity.managedObjectClassName = "Contact" 
    
    // create the attributes for the entity (just id and name for now)
    let idAttribute = NSAttributeDescription()
    idAttribute.name = "id"
    idAttribute.attributeType = .integer64AttributeType
    idAttribute.isOptional = false
    idAttribute.isIndexed = true
    
    let contactAttribute = NSAttributeDescription()
    contactAttribute.name = "name"
    contactAttribute.attributeType = .stringAttributeType
    contactAttribute.isOptional = false
    contactAttribute.isIndexed = false
    
    // add the properties to the entity
    contactEntity.properties = [idAttribute, contactAttribute]
    
    // add the entities to the model
    model = NSManagedObjectModel()
    model.entities = [contactEntity]
    
    // setup the persistent store coordinator
    persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
    do {
      try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
      // try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: nil, options: nil)
    }
    catch {
      print("error creating persistentstorecoordinator: \(error)")
    }
    
    // set up managed object context
    context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = persistentStoreCoordinator
    
  }
  
  // a simple function to save the context only if it has changes
  public func saveContext () {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        abort()
      }
    }
  }
}
