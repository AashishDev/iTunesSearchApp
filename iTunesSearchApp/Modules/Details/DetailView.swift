//
//  DetailViewController.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import UIKit

protocol DetailViewProtocol:AnyObject {
    var presenter:DetailPresenterProtocol? { get set }
}

class DetailViewController: UIViewController,DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    
    private var tableDataArray:[[SearchResultModel]] = []
    @IBOutlet weak var tableView: UITableView!
    var searchText:String?
    var entity:[String]?
    var service:iTunesSearchServiceProtocol? = iTunesSearchService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Result"

        tableView.register(UITableViewCell.self
                           , forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .black
        Task {
            guard let searchText = searchText,let entity = entity else {
                return
            }
            
            self.showSpinner(onView: self.view)
            if let searchResult = await presenter?.fetchItunesItem(searchText: searchText, mediaTypes: entity), searchResult.count > 0  {
                self.removeSpinner()
                self.tableDataArray =  searchResult
                self.tableView.reloadData()
            }
            else {
                self.removeSpinner()
                showAlertWith(message: AlertMessage.NoRecordFound, buttons: ["Okay"], completion: nil)
            }
        }
    }
    
}

extension DetailViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionTitle = entity?[section] else { return nil }
        return sectionTitle.capitalized
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.boldSystemFont(ofSize: 19)
            header.textLabel!.textColor = UIColor.white
            header.contentView.backgroundColor = UIColor.black
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier:DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        
        let model =  tableDataArray[indexPath.section]
        cell.configure(with: model,indexPath: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
}

