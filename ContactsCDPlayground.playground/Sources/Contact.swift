import Foundation
import CoreData

// making explicitly public b/c in playground sources directory

@objc(Contact)

public class Contact: NSManagedObject {
  
  @NSManaged public var name: String
  @NSManaged public var id: NSNumber
  
}
