//
//  MovieCell.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import UIKit
class MovieCell: UITableViewCell {
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var progress: CircularProgressBarView!
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var percentage: UILabel!
    @IBOutlet var seperator: UIView!
    var onReuse: () -> Void = {}
    
    override func prepareForReuse() {
        onReuse()
        self.movieImage.backgroundColor = .darkGray
        self.movieImage.image = nil
        self.movieImage.cancelImageLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.masksToBounds = true
        movieImage.layer.borderWidth = 1
        movieImage.layer.borderColor = UIColor.white.cgColor
        movieImage.backgroundColor = Colors.primaryColor
        seperator.backgroundColor = Colors.headerBackgroundColor
    }
    
    func initValues(movie: Result, tag: Int) {
        self.tag = tag
        self.movieImage.backgroundColor = .clear
        self.title.text = movie.title
        self.date.text = String().toMovementDate(date: movie.releaseDate ?? "")
        self.duration.text = movie.overview
        guard let path = movie.posterPath else {
            return
        }
        guard let fileUrl = URL(string: Endpoint.mainImageUrl + path) else { return }
        self.movieImage.loadImage(at: fileUrl)
        if let average = movie.voteAverage {
            let calification = average * 10
            self.setupProgress(progress: Int(calification))
            self.percentage.text = "\(String(format: "%.0f", calification))"
        }
    }
    
    func setupProgress(progress: Int) {
        let setProgress = (progress * 360) / 100
        self.progress.startAngle = -90
        if progress > 50 {
            self.progress.progressColors = [Colors.Progress.greenProgress]
            self.progress.trackColor = Colors.Progress.greenStatic
        } else {
            self.progress.progressColors = [Colors.Progress.yellowProgress]
            self.progress.trackColor = Colors.Progress.yellowStatic
        }
        self.progress.animate(toAngle: Double(setProgress), duration: 0.5, completion: nil)
    }
}
