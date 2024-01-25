//
//  CoreDataManager.swift
//  Gallery App
//
//  Created by Amul Patel on 25/01/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Gallery_App")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Save Images
    func saveImages(images: [UIImage]) {
        let context = persistentContainer.viewContext

        for image in images {
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let imageEntity = ImageEntity(context: context)
                imageEntity.imageData = imageData
            }
        }

        do {
            try context.save()
        } catch {
            print("Failed to save images: \(error)")
        }
    }

    // MARK: - Fetch Images
    func fetchImages() -> [UIImage] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()

        do {
            let imageEntities = try context.fetch(fetchRequest)
            let images = imageEntities.compactMap { UIImage(data: $0.imageData!) }
            return images
        } catch {
            print("Failed to fetch images: \(error)")
            return []
        }
    }

    // MARK: - Clear All Images
    func clearAllImages() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()

        do {
            let imageEntities = try context.fetch(fetchRequest)

            for entity in imageEntities {
                context.delete(entity)
            }

            try context.save()
        } catch {
            print("Failed to clear images: \(error)")
        }
    }
}

