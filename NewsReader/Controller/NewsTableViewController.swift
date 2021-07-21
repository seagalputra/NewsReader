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
    
    // TODO: Place into constant class
    let API_KEY: String? = Bundle.main.infoDictionary?["NEWS_API_KEY"] as? String
    let BASE_URL: String? = Bundle.main.infoDictionary?["NEWS_BASE_URL"] as? String
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newsTableView.dataSource = self
        self.newsTableView.delegate = self
        self.newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        fetchNews() { result in
            self.articles = result?.articles ?? []
            self.newsTableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell {
            
            // TODO: Please refactor this!
            let article = self.articles[indexPath.row]
            cell.newsTitle.text = article.title
            if let sourceName = article.source.name, let authorName = article.author {
                cell.newsAdditionalData.text = "\(sourceName) - \(authorName)"
            }
            
            if let url = article.urlToImage {
                fetchImage(url: url) { image in cell.newsPhoto.image = image }
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

extension NewsTableViewController {
    // TODO: Refactor this!
    func fetchNews(completion: @escaping (GenericResponse?) -> Void) {
        let url = "\(BASE_URL!)/v2/top-headlines?country=id&apiKey=\(API_KEY!)"
        
        AF.request(url).responseDecodable(of: GenericResponse.self) { response in
            if case .success(let data) = response.result {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
    
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
