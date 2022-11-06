//
//  ImageCellView.swift
//  GiniApps
//
//  Created by Aviram on 2/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageCellView: View {
    
    @Binding var photo : Photo
    @State var isAnimating: Bool = true

    var body: some View {
       
        WebImage(url: URL(string: photo.previewURL ?? ""), isAnimating: $isAnimating)
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
        .overlay(alignment: .bottomLeading, content: {
                BubbleView(text: "Likes: ", number: Int(photo.likes))
                    .padding(.leading,5)
                    .padding(.bottom,30)
            })

            .overlay(alignment: .bottomTrailing, content: {
                BubbleView(text: "Comments: ", number: Int(photo.comments))
                    .padding(.trailing,5)
                    .padding(.bottom,30)
            })
        
    }
}

struct BubbleView : View{
    let text : String
    let number : Int
    var alignment : Alignment = .center
    
    var body: some View {
        Text( text + "\(number)")
            
            .frame(width: 125, height: 25, alignment: alignment)
            .background(Color.green)
            .opacity(0.66)
            .cornerRadius(15.0)
            .padding()
    }
}

//PREVIEW:
struct ImageViewCell_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(text: "Likes", number: 124)
//
//        Photo(context: viewContext)
//        ImageCellView()
    }
}
