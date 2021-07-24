//
//  NewsTableViewController.swift
//  NewsReader
//
//  Created by Dwiferdio Seagal Putra on 20/07/21.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsTableViewController: UITableViewController {

    @IBOutlet var newsTableView: UITableView!
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
        self.newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        NewsApi.get() { result, error in
            guard error == nil else { return }
            
            self.articles = result?.articles ?? []
            self.newsTableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell {
            let article = self.articles[indexPath.row]
            cell.newsTitle.text = article.title
            if let sourceName = article.source.name, let authorName = article.author {
                cell.newsAdditionalData.text = "\(sourceName) - \(authorName)"
            }
            
            if let url = article.urlToImage {
                UIImage.fetchImage(url) { image, error in
                    guard error == nil else { cell.newsPhoto.image = UIImage(named: "empty"); return }
                    
                    cell.newsPhoto.image = image
                }
            } else {
                cell.newsPhoto.image = UIImage(named: "empty")
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsDetailViewControllerScene") as? NewsDetailViewController else { return }
        
        detail.news = self.articles[indexPath.row]
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
