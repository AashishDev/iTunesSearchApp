//
//  MediaTypeViewController.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import UIKit

protocol MediaTypeViewProtocol:AnyObject {
    var presenter:MediaTypePresenterProtocol? { get set }
}

class MediaTypeViewController: UITableViewController,MediaTypeViewProtocol {
    var presenter: MediaTypePresenterProtocol?
    weak var delegate:MediaTypeSelectionProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Media Type"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsMultipleSelection = true
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        let selectedMediaTypes =
        tableView.indexPathsForSelectedRows?.map({ $0.row })
            .map({ MediaType.allCases[$0].title})
        self.delegate?.selectMediaTypes(mediaTypes: selectedMediaTypes ?? [""])
        presenter?.doneButtonTapped(from: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let mediaType = MediaType.allCases[indexPath.row].title
        cell.textLabel?.text = mediaType
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

