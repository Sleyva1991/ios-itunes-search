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
        
        // Perform the request (with a data task)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // Handle any errors
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            // (Usually) decode the data
            
            guard let data = data else {
                NSLog("No data returned from iTunes search")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let resultsSearch = try decoder.decode(searchResults.self, from: data)
                self.searchResult = resultsSearch.results
            } catch {
                NSLog("Unable to decode data into searchResult: \(error)")
            }
            completion(error)
        }.resume()
        
    }
}
