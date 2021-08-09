//
//  TagCell.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import UIKit
class TagCell: UICollectionViewCell {
    @IBOutlet var view: UIView!
    @IBOutlet var tagTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cornerRadius = 6
    }
}
