//
//  DetailTableViewCell.swift
//  iTunesSearchApp
//
//  Created by Aashish Tyagi on 9/24/22.
//
import UIKit

class DetailTableViewCell: UITableViewCell {
    static let identifier = "DetailTableViewCell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchResultItems:[SearchResultModel] = []
    var selectedItem:((SearchResultModel)-> Void)?
    var isPopular:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = UIColor.black
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with vm:[SearchResultModel], indexPath:IndexPath) {
        self.searchResultItems = vm
        isPopular = (indexPath.section == 0)
        self.collectionView.reloadData()
    }
}

extension DetailTableViewCell:UICollectionViewDataSource,
                                 UICollectionViewDelegate,
                                 UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let model = self.searchResultItems[indexPath.row]
        cell.title.text = model.name
        
        cell.imageView.layer.cornerRadius = 8.0
        cell.imageView.backgroundColor = UIColor.lightGray
        cell.imageView.loadImage(urlString: model.assetPath)
        cell.imageView.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResultItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:300, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = searchResultItems[indexPath.row]
        self.selectedItem?(model)
    }
}

