//
//  MovieCollectionItem.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//
import UIKit
class MovieCollectionItem: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    var onReuse: () -> Void = {}
    
    override func prepareForReuse() {
        onReuse()
        self.image.image = nil
        self.image.cancelImageLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.backgroundColor = Colors.primaryColor
    }
    
    func initValues(movie: Result, tag: Int) {
        self.tag = tag
        guard let path = movie.posterPath else {
            return
        }
        guard let fileUrl = URL(string: Endpoint.mainImageUrl + path) else { return }
        self.image.loadImage(at: fileUrl)
    }
}
