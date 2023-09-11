//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 9.09.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // MARK: - Save to CoreData
    func saveData(model: MovieDetail) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let genres = model.genres[0]
            let context = appDelegate.persistentContainer.viewContext
            
            let entityDescription = NSEntityDescription.insertNewObject(forEntityName: "MoviesData",
                                                                        into: context)
            
            entityDescription.setValue(model.id, forKey: "id")
            entityDescription.setValue(model.backDropPath, forKey: "backDropPath")
            entityDescription.setValue(model.posterPath, forKey: "posterPath")
            entityDescription.setValue(model.title, forKey: "title")
            entityDescription.setValue(model.voteAverage, forKey: "voteAverage")
            entityDescription.setValue(model.releaseDate, forKey: "releaseDate")
            entityDescription.setValue(model.runtime, forKey: "runtime")
            entityDescription.setValue(model.overview, forKey: "overview")
            // For Genre
            
            entityDescription.setValue(genres.id, forKey: "genresID")
            entityDescription.setValue(genres.name, forKey: "genresName")
            // print("Save Item ID: \(genres.id)\nSave Item Name \(genres.name)")
            
            do {
                try context.save()
                print("Saved.")
            } catch {
                print("Saved Error !")
            }
        }
    }
    
    // MARK: - Delete Data
    func deleteCoreData(with dataID: Int) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesData")
            fetchRequest.returnsObjectsAsFaults = false
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", "\(dataID)")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        context.delete(result)
                        
                        do {
                            try context.save()
                            print("Item Deleted.")
                        } catch {
                            print("Error Deleting !!")
                        }
                    }
                }
            } catch {
                print("Error Deleting !!")
            }
        }
    }
    
    // MARK: - Fetch Data
    func getDataToWatchList(completion: @escaping (Result<[MovieDetail], Error>) -> Void) {
        var detailArray: [MovieDetail] = []
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesData")
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    
                    var genreArray: [Genre] = []
                    if let genresID = result.value(forKey: "genresID") as? Int,
                       let genresName = result.value(forKey: "genresName") as? String {
                        
                        let firstGenre = Genre(id: genresID, name: genresName)
                        genreArray.append(firstGenre)
                    }
                    // print("GenresID: \(), GenresName: \(genresName)")
                    detailArray.append(MovieDetail(id: result.value(forKey: "id") as! Int,
                                                   backDropPath: result.value(forKey: "backDropPath")
                                                   as! String,
                                                   posterPath: result.value(forKey: "posterPath")
                                                   as! String,
                                                   title: result.value(forKey: "title")
                                                   as! String,
                                                   voteAverage: result.value(forKey: "voteAverage")
                                                   as! Double,
                                                   releaseDate: result.value(forKey: "releaseDate")
                                                   as! String,
                                                   
                                                   // Genres
                                                   genres: genreArray,
                                                   runtime: result.value(forKey: "runtime")
                                                   as? Int ?? 0,
                                                   overview: result.value(forKey: "overview")
                                                   as? String ?? ""))
                }
                completion(.success(detailArray))
            } catch {
                
            }
        }
    }
}
