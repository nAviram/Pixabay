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

                        } label: {
                            ImageCellView(photo: photo)
                        }
                    }
                }//List
                    .listStyle(PlainListStyle())
                    .task {
                        await model.getHitsFromApiService()
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
        }//NavigationView
    }//body
}



