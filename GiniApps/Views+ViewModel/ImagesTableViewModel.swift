//
//  ImagesTableViewModel.swift
//  GiniApps
//
//  Created by Aviram on 4/11/22.
//

import SwiftUI

final class ImagesTableViewModel: ObservableObject {

    let apiService = APIService()
    let viewContext = PersistenceController.shared.viewContext
    
    @Published var allPhotos:[Photo] = PersistenceController.shared.fetchAllPhotos()

    private func addPhoto(hit : Hit) {
        withAnimation {
            let newPhoto = Photo(context: viewContext)
            populatePhoto(photo: newPhoto, With: hit)

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    
    
    private func populatePhoto(photo: Photo, With hit: Hit){
        photo.id = Int32(hit.id)
        photo.likes = Int32(hit.likes ?? 0)
        photo.comments = Int32(hit.comments ?? 0)
        photo.imageURL = hit.imageURL
        photo.previewURL = hit.previewURL
        photo.downloads = Int32(hit.downloads ?? 0)
        photo.favorites = Int32(hit.favorites ?? 0)
        photo.imageHeight = Int32(hit.imageHeight ?? 0)
        photo.imageSize = Int64(hit.imageSize ?? 0)
        photo.imageWidth = Int32(hit.imageWidth ?? 0)
        photo.largeImageURL = hit.largeImageURL
        photo.pageURL = hit.pageURL
        photo.previewHeight = Int32(hit.previewHeight ?? 0)
        photo.previewWidth = Int32(hit.previewWidth ?? 0)
        photo.tags = hit.tags
        photo.type = hit.type
        photo.user = hit.user
        photo.userId = Int32(hit.user_id ?? 0)
        photo.userImageURL = hit.userImageURL
        photo.views = Int32(hit.views ?? 0)
        photo.webformatURL = hit.webformatURL
        photo.webformatHeight = Int32(hit.webformatHeight ?? 0)
        photo.webformatWidth = Int32(hit.webformatWidth ?? 0)
        
    }
    
    func getHitsFromApiService() async {
        //API-SERVICE - sends GET request
        await apiService.getDataWith{ (result) in
            switch result {
                case .Success(let response):

                for hit in response.hits {
                    
                    //if photo exists in the core-data:
                    if PersistenceController.shared.fetchPhoto(photoId: hit.id) != nil {
                        print("photo \(hit.id) already exists...")
                        continue
                    }
                    guard let likesCount = hit.likes else { continue }
                    guard let commentsCount = hit.comments else { continue }
                    if likesCount < 51 || commentsCount < 21{
                        continue
                    }
                        
                    let photo = Photo(context: self.viewContext)
                    self.populatePhoto(photo: photo, With: hit)

                    self.allPhotos.insert(photo, at: self.allPhotos.count)
                    self.allPhotos.sort(by: {$0.likes > $1.likes})
                    
                    do{
                        try self.viewContext.save()
                    }catch{
                        print("ERROR saving hit.id: \(hit.id)")
                    }
                }


                case .Error(let response):
                 print("ERROR : " + response)
            }
        }
    }
}
