//
//  ContentView.swift
//  GiniApps
//
//  Created by Aviram on 2/11/22.
//

import SwiftUI
import CoreData

struct ImagesTableView: View {

    @ObservedObject var model: ImagesTableViewModel
    
    var body: some View {
                
        NavigationView {
            
            List {
                ForEach($model.allPhotos) { photo in
                    NavigationLink {
                        ImageDetailsView(photo: photo)
//                        ImageDetailsView()

                    } label: {
                        ImageCellView(photo: photo)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .task {
                print("BEFORE Photos Count: \(model.allPhotos.count)")
                await model.getHitsFromApiService()
                print("waited!")
                print("AFTER Photos Count: \(model.allPhotos.count)")
            }
            
            .onAppear() {
                
            }
            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading){
                                        Image("TitleIcon").resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50, alignment: .leading)
                                    }
                                ToolbarItem(placement: .principal) {
                                        Text("Pixabay Images")
                                            .font(.title)
                                    }
                                }
            
        
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addPhoto) {
//                        Label("GET Photos", systemImage: "plus")
//                    }
//                }
//            }
        }
    }
    
//    private func addPhoto(){
//        if !hits.isEmpty{
//            addPhoto(hit: hits[0])
//        }
//    }
    
//    private func addPhoto(hit : Hit) {
//        withAnimation {
//            let newPhoto = Photo(context: viewContext)
//            populatePhoto(photo: newPhoto, With: hit)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { photos[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
//    }
//}



