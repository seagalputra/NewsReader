//
//  NewsApi.swift
//  NewsReader
//
//  Created by Dwiferdio Seagal Putra on 24/07/21.
//

import Foundation
import Alamofire
import AlamofireImage

class NewsApi {
    static let NEWS_API_KEY: String? = Bundle.main.infoDictionary?["NEWS_API_KEY"] as? String
    static let NEWS_BASE_URL: String? = Bundle.main.infoDictionary?["NEWS_BASE_URL"] as? String
    
    static func get(completion: @escaping (GenericResponse?, AFError?) -> Void) {
        let url = "\(NEWS_BASE_URL!)/v2/top-headlines?country=id&apiKey=\(NEWS_API_KEY!)"
        
        AF.request(url).responseDecodable(of: GenericResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

extension UIImage {
    static func fetchImage(_ url: String, completion: @escaping (UIImage?, AFIError?) -> Void) {
        let imageDownloader = ImageDownloader()
        let imageUrl = URLRequest(url: URL(string: url)!)
        
        imageDownloader.download(imageUrl, completion: { response in
            switch response.result {
            case .success(let image):
                completion(image, nil)
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
}
