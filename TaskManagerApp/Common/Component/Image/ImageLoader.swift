//
//  ImageLoader.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 27/08/21.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    public var didChange = PassthroughSubject<Data, Never>()
    
    public var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    private let url: String
    
    init(url: String) {
        self.url = url
        handle()
    }
    
    private func handle() {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
    
}

