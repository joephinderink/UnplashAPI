//
//  SearchObjectController.swift
//  UnplashAPI
//
//  Created by Joep Hinderink on 24/01/2021.
//

import Foundation
import SwiftUI

class SearchObjectController : ObservableObject {
    static let shared = SearchObjectController()
    private init() {
        
    }
    
    var token = "AlA_hD8NQxU3lbpdEo-mrf_NdgvC9wD9CnDwtOXIptg"
    @Published var results = [Result]()
    @Published var  searchText : String = "Flowers"
    
    func search (){
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField:  "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Results.self, from: data)
                self.results.append(contentsOf: res.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
