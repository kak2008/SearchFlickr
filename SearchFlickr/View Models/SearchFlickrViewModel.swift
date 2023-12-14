//
//  SearchFlickrViewModel.swift
//  SearchFlickr
//
//  Created by Anish Kodeboyina on 12/12/23.
//

import Foundation

protocol FlickrImageDataDelegate {
    func didfetchFlickrData()
}

class SearchFlickrViewModel {
    
    var flickrData: FlickrData?
    var flickrImageDataDelegate: FlickrImageDataDelegate?
    
    var numberOfCells: Int {
        flickrData?.items.count ?? 0
    }
    
    init(flickrImageDataDelegate: FlickrImageDataDelegate? = nil) {
        self.flickrImageDataDelegate = flickrImageDataDelegate
    }
    
    func getImageUrlString(for indexPath: IndexPath) ->  String {
        flickrData?.items[indexPath.row].media.m ?? ""
    }
    
    func getFlickrImageData(userEntry: String = "") {
        fetchFlickrImageData(userEntry: userEntry) { flickrData, error in
            if let flickrData = flickrData, error == nil {
                self.flickrData = flickrData
            } else {
                self.flickrData = nil
            }
            self.flickrImageDataDelegate?.didfetchFlickrData()
        }
    }
    
    private func fetchFlickrImageData(userEntry: String, completion: @escaping (FlickrData?, Error?) -> Void) {
        let endpointUrlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(userEntry)"
        
        guard let url = URL(string: endpointUrlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(FlickrData.self, from: data)
                completion(jsonData, nil)
            } catch {
                print("error:\(error)")
            }
        }
        task.resume()
    }
}
