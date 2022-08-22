import Foundation
import UIKit
import CoreData

class PersistenceManager {
    
    enum DataError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = PersistenceManager()
    
    func downloadToLibrary(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let item = FilmsEntity(context: context)
    
        item.title = model.title
        item.overview = model.overview
        item.posterImage = model.posterImage
        item.backdropImage = model.backdropImage
        item.rate = model.rate!
        item.year = model.convertDataFormat(model.year)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataError.failedToSaveData))
        }
    }
        
    func fetchFromCoreData(completion: @escaping (Result<[FilmsEntity], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<FilmsEntity>
        request = FilmsEntity.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DataError.failedToFetchData))
        }
    }
    
    func removeFromCoreData(model: FilmsEntity, completion: @escaping (Result<Void, Error>)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataError.failedToDeleteData))
        }
    }
}
