//
//  ImageDetailsView.swift
//  GiniApps
//
//  Created by Aviram on 5/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageDetailsView: View {
    
    @Binding var photo : Photo
    @State var isAnimating: Bool = true

    var body: some View {
        NavigationView {
            
            VStack{
                            
                HStackKeyValueText(key: "Views:", value: "\(photo.views)")//views
                HStackKeyValueText(key: "Downloads:", value: "\(photo.downloads)") //downloads
                HStackKeyValueText(key: "Image Tags:", value: photo.tags ?? "") //tags
                HStackKeyValueText(key: "User Name:", value: photo.user ?? "") //user name
                
                WebImage(url: URL(string: photo.largeImageURL ?? ""), isAnimating: $isAnimating)
                
                // For Preview Demo - comment in this instead:
//                HStackKeyValueText(key: "Image Views:", value: "1231221")//views
//                HStackKeyValueText(key: "Downloads:", value: "33333") //downloads
//                HStackKeyValueText(key: "Image Tags:", value: "blue, sky, white, ass") //tags
//                HStackKeyValueText(key: "User Name:", value: "Aviram") //user name
//                WebImage(url: URL(string: Constants.baseUrl))
                
                // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network.
                    // Use `.queryMemoryData` if you really need data
                }
                .resizable()
                .placeholder(Image("Gini_BG")) // Placeholder Image
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(height: 300, alignment: .center)
                
                Spacer()
                
            }//VStack
             
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                        Image("TitleIcon").resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                    }
                ToolbarItem(placement: .principal) {
                        Text("Image Details")
                            .font(.title)
                    }
                }
        }//NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HStackKeyValueText : View{
    
    var key : String = "KEY"
    var value : String = "value"
    
    var body: some View {
        HStack{
            Text(key)
                .frame(alignment: .leading)
                .padding(5)
                .padding(.leading, 15)
                .font(Font.body.bold())
            
            Spacer()
            
            Text(value)
                .padding(5)
                .padding(.trailing, 20)
        }
    }
}

