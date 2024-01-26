//
//  ImageView.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/11/2023.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    @State var image: UIImage = UIImage()
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String){
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        // Refactoring to reload images only those that have not yet been loaded
        Image(uiImage:UIImage(data: imageLoader.data) ?? image)
            .resizable()
            .onReceive(imageLoader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
        )
    }
}

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data(){
        didSet{
            didChange.send(data)
        }
    }
    
    init(url: String){
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url){data,response,error in
            guard let data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

#Preview {
    ImageView(url: "http://google.com")
}
