//
//  MovieDetailView.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import UIKit
class MovieDetailView: UIViewController {
    // MARK: - VARS
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var closeBtn: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "close")?.withTintColor(.white), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    private lazy var titleLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Colors.primaryLetters
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 19.0)
        view.numberOfLines = 0
        return view
    }()
    private lazy var dateMovieLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Colors.primaryLetters
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 15.0)
        return view
    }()
    private lazy var overviewLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Colors.primaryLetters
        view.text = "Overview"
        view.textAlignment = .left
        view.font = UIFont.boldSystemFont(ofSize: 19.0)
        return view
    }()
    private lazy var descriptionLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Colors.primaryLetters
        view.numberOfLines = 0
        view.sizeToFit()
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 16.0)
        return view
    }()
    private var myCollectionView:UICollectionView?
    var presenter: MovieDetailPresenterProtocol?
    var id: Int = 0
    private var tags = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    deinit {
        print("Free Movie Detail Memory")
    }
    
    // MARK: - UI METHODS
    private func configUI() {
        self.view.backgroundColor = Colors.clearPrimaryColor
        self.setupScrollView()
        self.setupViewItems()
        self.setupCollectionView()
        self.presenter?.getMovieData(id: self.id)
    }
    
    private func setupScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
    }
    
    private func setupViewItems() {
        self.contentView.addSubview(self.closeBtn)
        self.closeBtn.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30).isActive = true
        self.closeBtn.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40).isActive = true
        self.closeBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.closeBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.closeBtn.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        self.contentView.addSubview(self.image)
        self.image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 60).isActive = true
        self.image.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.image.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentView.addSubview(self.titleLbl)
        self.titleLbl.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 10).isActive = true
        self.titleLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40).isActive = true
        self.titleLbl.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 40).isActive = true
        self.contentView.addSubview(self.dateMovieLbl)
        self.dateMovieLbl.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor, constant: 0).isActive = true
        self.dateMovieLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40).isActive = true
        self.dateMovieLbl.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 40).isActive = true
        self.contentView.addSubview(self.overviewLbl)
        self.overviewLbl.topAnchor.constraint(equalTo: self.dateMovieLbl.bottomAnchor, constant: 20).isActive = true
        self.overviewLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40).isActive = true
        self.overviewLbl.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 40).isActive = true
        self.contentView.addSubview(self.descriptionLbl)
        self.descriptionLbl.topAnchor.constraint(equalTo: self.overviewLbl.bottomAnchor, constant: 20).isActive = true
        self.descriptionLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40).isActive = true
        self.descriptionLbl.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 40).isActive = true
    }
    
    private func setupCollectionView() {
        self.myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout())
        self.myCollectionView?.backgroundColor = .clear
        self.myCollectionView?.delegate = self
        self.myCollectionView?.dataSource = self
        self.myCollectionView?.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        self.myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.myCollectionView ?? UICollectionView())
        self.myCollectionView?.topAnchor.constraint(equalTo: self.descriptionLbl.bottomAnchor, constant: 20).isActive = true
        self.myCollectionView?.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        self.myCollectionView?.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        self.myCollectionView?.heightAnchor.constraint(equalToConstant: 400).isActive = true
        self.myCollectionView?.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: 90, height: 30)
        return layout
    }
    
    // MARK: - ACTIONS
    @objc func closeScreen(sender: UIButton!) {
        self.presenter?.closeView()
    }
}

// MARK: - UICollectionViewDelegate & Data Source
extension MovieDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        let tag = self.tags[indexPath.row]
        cell.tagTitle.text = tag.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select one")
    }
}

// MARK: - VIPER METHODS
extension MovieDetailView: MovieDetailViewProtocol {
    func onSuccesMovieData(data: MovieDetail) {
        self.titleLbl.text = data.title
        if data.overview?.count == 0 {
            self.overviewLbl.isHidden = true
        }
        self.descriptionLbl.text = data.overview
        guard let genres = data.genres else {
            return
        }
        self.tags = genres
        let time = String().minutesToHoursAndMinutes(data.runtime ?? 0)
        guard let date = data.releaseDate else {
            return
        }
        self.dateMovieLbl.text = "\(String().toMovementDate(date: date) ) - \(time.hours)h \(time.leftMinutes)m"
        guard let path = data.posterPath else {
            return
        }
        guard let fileUrl = URL(string: Endpoint.mainImageUrl + path) else { return }
        self.image.loadImage(at: fileUrl)
        self.myCollectionView?.reloadData()
    }
    
    func onErrorMovieData() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong, please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.presenter?.closeView()
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("Error")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
