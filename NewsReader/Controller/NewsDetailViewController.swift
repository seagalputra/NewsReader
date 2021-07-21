//
//  NewsDetailViewController.swift
//  NewsReader
//
//  Created by Dwiferdio Seagal Putra on 21/07/21.
//

import UIKit
import SafariServices
import AlamofireImage

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var newsDetailTitle: UILabel!
    @IBOutlet weak var newsDetailAdditionalData: UILabel!
    @IBOutlet weak var newsDetailImage: UIImageView!
    @IBOutlet weak var newsDetailContent: UILabel!
    var news: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let result = news {
            self.newsDetailTitle.text = result.title
            
            if let sourceName = result.source.name, let authorName = result.author {
                self.newsDetailAdditionalData.text = "\(sourceName) - \(authorName)"
            }
            
            if let url = result.urlToImage {
                fetchImage(url: url) { image in self.newsDetailImage.image = image }
            }
            self.newsDetailContent.text = result.content
        }
    }
    
    @IBAction func readNews(_ sender: Any) {
        let webViewController = SFSafariViewController(url: URL(string: news?.url! ?? "http://www.apple.com")!)
        
        present(webViewController, animated: true, completion: nil)
    }
}

extension NewsDetailViewController {
    // TODO: DUPLICATED CODE! Make this as UIImage extensions
    func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        let imageDownloader = ImageDownloader()
        let imageUrl = URLRequest(url: URL(string: url)!)
        
        imageDownloader.download(imageUrl, completion: { response in
            if case .success(let image) = response.result {
                completion(image)
            } else {
                completion(UIImage(named: "empty"))
            }
        })
    }
}
