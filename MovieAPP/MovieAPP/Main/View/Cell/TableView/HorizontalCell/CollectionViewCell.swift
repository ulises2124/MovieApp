//
//  CollectionViewCell.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import UIKit
class CollectionViewCell: UITableViewCell {
    private var movieCollection: UICollectionView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCollectionView() {
        self.movieCollection = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout())
        self.movieCollection?.register(UINib(nibName: "MovieCollectionItem", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionItem")
        self.movieCollection?.backgroundColor = Colors.primaryColor
        self.movieCollection?.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.movieCollection ?? UICollectionView())
        self.movieCollection?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.movieCollection?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        self.movieCollection?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        self.movieCollection?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 150, height: 230)
        return layout
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        self.movieCollection?.delegate = dataSourceDelegate
        self.movieCollection?.dataSource = dataSourceDelegate
        movieCollection?.tag = row
        guard let collectionOffset = movieCollection?.contentOffset else {
            return
        }
        movieCollection?.setContentOffset(collectionOffset, animated: false) // Stops collection view if it was scrolling.
        movieCollection?.reloadData()
    }
    var collectionViewOffset: CGFloat {
        set { movieCollection?.contentOffset.x = newValue }
        get { return (movieCollection?.contentOffset.x)! }
    }
}
