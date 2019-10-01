//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Steven Leyva on 10/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResult: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping(Error?) -> Void) {
        
        // Building out the URL
        
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        let entityQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [searchQueryItem, entityQueryItem]
        
        guard let requestURL = components?.url else {
            completion(nil)
            return
        }
        
        // Create a URLRequest
        
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: <#T##URL#>)
        
    }
}
