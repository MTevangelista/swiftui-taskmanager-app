//
//  imageView.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 27/08/21.
//

import SwiftUI

struct imageView: View {
    
    @State var image: UIImage = UIImage()
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: imageLoader.data) ?? image)
            .resizable()
            .onReceive(imageLoader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
    }
}

struct imageView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            imageView(url: "http://google.com")
                .preferredColorScheme($0)
        }
    }
}
