//
//  SeachService.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

class FlickerSearchService: SearchServiceType {
    typealias CompletionType = (UIImage?, Error?) -> Void
    
    func search(searchString: String, completion: @escaping CompletionType) {
        
        let searchURL = self.getUrl(searchString: searchString)
        self.performSearch(searchURL, completion)
    }
    
    private func performSearch(_ searchURL: URL, _ completion: @escaping CompletionType) {
        
        let session = URLSession.shared
        let request = URLRequest(url: searchURL)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                let status = (response as! HTTPURLResponse).statusCode
                if status != 200 {
                    completion(nil, SearchServiceError.unknown)
                    return
                }
                
                guard let data = data else {
                    completion(nil, SearchServiceError.noData)
                    return
                }
                
                let parsedResult: [String:AnyObject]
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                } catch {
                    completion(nil, SearchServiceError.parseJSON)
                    return
                }
                
                guard let photosDictionary = parsedResult[FlickerConstants.Keys.Photos] as? [String:AnyObject] else {
                    completion(nil, SearchServiceError.parseJSON)
                    return
                }

                guard let photosArray = photosDictionary[FlickerConstants.Keys.Photo] as? [[String: AnyObject]] else {
                    completion(nil, SearchServiceError.parseJSON)
                    return
                }

                if let photoDictionary = photosArray.first {
                    guard let imageUrlString = photoDictionary[FlickerConstants.Keys.ImageURL] as? String else {
                        completion(nil, SearchServiceError.parseJSON)
                        return
                    }
                    
                    self.fetchImage(imageUrlString, completion)
                } else {
                    completion(nil, SearchServiceError.noPhotosFound)
                    return
                }
            }
        }
        task.resume()
    }
    
    private func fetchImage(_ url: String, _ completion: @escaping CompletionType) {
        
        guard let imageURL = URL(string: url) else {
            completion(nil, SearchServiceError.urlNotValid)
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            else if let data = data, let image = UIImage(data: data) {
                completion(image, nil)
            }
        }
        
        task.resume()
    }

    
    private func getUrl(searchString: String) -> URL {
        
        var components = URLComponents()
        components.scheme = FlickerConstants.URLParams.APIScheme
        components.host = FlickerConstants.URLParams.APIHost
        components.path = FlickerConstants.URLParams.APIPath
        
        components.queryItems = [URLQueryItem]()
        
        components.queryItems?.append(URLQueryItem(name: FlickerConstants.APIKeys.APIKey, value: FlickerConstants.APIValues.APIKey))
        components.queryItems?.append(URLQueryItem(name: FlickerConstants.APIKeys.SearchMethod, value: FlickerConstants.APIValues.SearchMethod))
        components.queryItems?.append(URLQueryItem(name: FlickerConstants.APIKeys.ResponseFormat, value: FlickerConstants.APIValues.ResponseFormat))
        components.queryItems?.append(URLQueryItem(name: FlickerConstants.APIKeys.Extras, value: FlickerConstants.APIValues.MediumURL))
        components.queryItems?.append(URLQueryItem(name: FlickerConstants.APIKeys.SafeSearch, value: FlickerConstants.APIValues.SafeSearch))
        components.queryItems?.append(URLQueryItem(name: FlickerConstants.APIKeys.DisableJSONCallback, value: FlickerConstants.APIValues.DisableJSONCallback))
        components.queryItems?.append(URLQueryItem(name: FlickerConstants.APIKeys.Text, value: searchString))
        
        return components.url!
    }
}
