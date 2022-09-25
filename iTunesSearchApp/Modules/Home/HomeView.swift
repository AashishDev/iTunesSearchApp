//
//  HomeView.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//

import UIKit
// ViewController
// protocol
// reference presenter

protocol HomeListViewProtocol:AnyObject {
    var presenter:HomePresenterProtocol? { get set }
}

protocol MediaTypeSelectionProtocol:AnyObject {
    func selectMediaTypes(mediaTypes:[String])
}

class HomeViewController: UIViewController,HomeListViewProtocol,MediaTypeSelectionProtocol  {
    var presenter:HomePresenterProtocol?
    private var selectedMediaTypes:[String] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iTunes Search"
        presenter?.viewDidLoad()
    }
    
    @IBAction func didAddMediaTypeTapped(_ sender: UIButton) {
        presenter?.showMediaTypeSelection(from: self)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let mediaTypes = self.selectedMediaTypes.map({$0.lowercased().replacingOccurrences(of: " ", with: "")})
        let query = searchTextField.text!
        presenter?.submitDetailForSearching(searchText: query, selectedTypes: mediaTypes, from: self)
    }
    
    func selectMediaTypes(mediaTypes:[String]) {
        self.selectedMediaTypes = mediaTypes
        self.collectionView.reloadData()
    }
}

extension HomeViewController:UICollectionViewDataSource,
                               UICollectionViewDelegate,
                               UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaTypeCollectionViewCell.identifier, for: indexPath) as? MediaTypeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = self.selectedMediaTypes[indexPath.row]
        cell.titleLabel.text = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.selectedMediaTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:250, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
