//
//  Data.swift
//  DesignCode
//
//  Created by James Allan on 9/25/20.
//

import SwiftUI


struct Post: Codable, Identifiable {
    
    var id = UUID()
    var title: String
    var body: String
}


class API {
    
    func getPost(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { print("invalid url"); return}
        
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { print("No Data"); return}
                let posts = try! JSONDecoder().decode([Post].self, from: data)
                
                DispatchQueue.main.async {
                    completion(posts)
                }
          
        }
        .resume()
    }
}
