//
//  MainView.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import UIKit
class MainView: UIViewController {
    // MARK: - VARS
    var storedOffsets = [Int: CGFloat]()
    private let refreshControl = UIRefreshControl()
    private let movieTableView: UITableView
        = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
            tableView.register(CollectionViewCell.self, forCellReuseIdentifier: "CollectionCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
            return tableView
        }()
    var presenter: MainPresenterProtocol?
    var movies = [Result]()
    var movieCollection = [Result]()
    var isNextPage = false
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    deinit {
        print("Free MainView Memory")
    }
    
    // MARK: - UI METHODS
    private func configUI() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
        self.navigationController?.navigationBar.barTintColor = Colors.primaryColor
        self.view.backgroundColor = Colors.primaryColor
        self.setupTableView()
        self.updateData()
    }
    
    private func setupTableView() {
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.refreshControl.tintColor = Colors.headerColor
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.movieTableView.addSubview(refreshControl)
        self.movieTableView.backgroundColor = Colors.primaryColor
        self.view.addSubview(self.movieTableView)
        self.movieTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.movieTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.movieTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.movieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: - ScrollView Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Method for fetch more data
        if self.movieTableView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if isNextPage {
                self.isNextPage = false
                self.page = page + 1
                self.movieTableView.tableFooterView = UIView().createSpinnerFooter(view: self.movieTableView, color: Colors.headerColor)
                self.loadMoreCompanies()
            }
        }
    }
    
    // MARK: - Func METHODS
    @objc func refresh(_ sender: AnyObject) {
        self.movies.removeAll()
        self.movieCollection.removeAll()
        self.updateData()
    }
    
    private func loadMoreCompanies() {
        self.presenter?.fetchData(page: self.page)
    }
    
    private func updateData() {
        self.page = 1
        self.presenter?.fetchData(page: self.page)
        self.presenter?.fetchCollectionData()
    }
}

// MARK: - UICollectionViewDelegate & Data Source
extension MainView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionItem", for: indexPath) as! MovieCollectionItem
        let movie = movieCollection[indexPath.row]
        cell.initValues(movie: movie, tag: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.openDetail(id: self.movieCollection[indexPath.row].id ?? 0)
    }
}

// MARK: - UITableViewDelegate & Data Source
extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            headerView.backgroundColor = Colors.headerBackgroundColor
            let label = UILabel()
            label.frame = CGRect.init(x: 10, y: -12, width: headerView.frame.width, height: headerView.frame.height)
            label.text = "Playing Now"
            label.textColor = Colors.headerColor
            headerView.addSubview(label)
            return headerView
        default:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            headerView.backgroundColor = Colors.headerBackgroundColor
            let label = UILabel()
            label.frame = CGRect.init(x: 10, y: -12, width: headerView.frame.width, height: headerView.frame.height)
            label.text = "Most Popular"
            label.textColor = Colors.headerColor
            headerView.addSubview(label)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 230
        default:
            return 114
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let cell = cell as! CollectionViewCell
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            let index = indexPath.row
            let movie = self.movies[index]
            cell.initValues(movie: movie, tag: index)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        default:
            guard let id = self.movies[indexPath.row].id else {
                return
            }
            self.presenter?.openDetail(id: id)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - VIPER METHODS
extension MainView: MainViewProtocol {
    func onSuccessFetchCollection(list: [Result]) {
        self.movieCollection.append(contentsOf: list)
        self.movieTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onSuccessFetchList(list: [Result]) {
        self.movieTableView.tableFooterView = nil
        self.isNextPage = true
        let countNews = self.movies.count
        self.movies.append(contentsOf: list)
        if countNews == 0 {
            self.movieTableView.reloadData()
            self.refreshControl.endRefreshing()
        } else {
            DispatchQueue.main.async {
                let indexPaths = ((self.movies.count - list.count) ..< self.movies.count).map { IndexPath(row: $0, section: 1) }
                self.movieTableView.performBatchUpdates({
                    self.movieTableView.insertRows(at: indexPaths, with: .fade)
                }, completion: nil )
            }
        }
    }
}
