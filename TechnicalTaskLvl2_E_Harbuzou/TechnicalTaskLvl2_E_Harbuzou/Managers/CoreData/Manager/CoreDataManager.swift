import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShipsModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}

extension CoreDataManager {
    func fetchShips() -> [ShipEntity] {
        let fetchRequest: NSFetchRequest<ShipEntity> = ShipEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch ships: \(error)")
            return []
        }
    }
    
    func saveShips(_ ships: [Ship]) {
        let existingShips = fetchShips()
        let existingNames = Set(existingShips.map { $0.name ?? "" })
        
        for ship in ships where !existingNames.contains(ship.name) {
            let entity = ShipEntity(context: context)
            entity.name = ship.name
            entity.image = ship.image?.absoluteString
            entity.type = ship.type
            entity.builtYear = Int64(ship.builtYear ?? 0)
            entity.weight = Int64(ship.weight) ?? 0
            entity.homePort = ship.homePort
            entity.roles = ship.roles.joined(separator: ", ")
        }
        
        saveContext()
    }
}
