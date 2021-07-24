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
                UIImage.fetchImage(url) { image, error in
                    guard error == nil else { self.newsDetailImage.image = UIImage(named: "empty"); return }
                    
                    self.newsDetailImage.image = image
                }
            }
            self.newsDetailContent.text = result.content
        }
    }
    
    @IBAction func readNews(_ sender: Any) {
        let webViewController = SFSafariViewController(url: URL(string: news?.url! ?? "http://www.apple.com")!)
        
        present(webViewController, animated: true, completion: nil)
    }
}
