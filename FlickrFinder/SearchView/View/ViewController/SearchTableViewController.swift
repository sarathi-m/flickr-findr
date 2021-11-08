//
//  SearchTableViewController.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import UIKit

class SearchTableViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var presenter: SearchViewToPresenterProtocol?
    var isLoadingMore = false

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Flickr Findr"
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        
        //remove empty cells
        tableView.tableFooterView = UIView()
        
        //register Custom Cell
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SearchTableViewCellId")
        
        //register Loading Cell
        tableView.register(LoadingMoreCell.self, forCellReuseIdentifier: "LoadingMoreCellId")
    }
}

// MARK: - UITableViewDataSource
extension SearchTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let pageLoaderNeeded = presenter?.isPageLoaderNeeded(), pageLoaderNeeded {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter?.getPhotosCount() ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCellId", for: indexPath) as? SearchTableViewCell, let photo = presenter?.getPhoto(index: indexPath.row) {
            cell.loadCellFor(photo)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingMoreCellId", for: indexPath) as! LoadingMoreCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension // Thumbnail Cell height
        } else {
            return 55 //Loading Cell height
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToDetailView(fromRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //load next set of data if last element reached in a tableview
        if let count = presenter?.getPhotosCount(), indexPath.row == count - 1, !isLoadingMore {
            presenter?.nextPageRequest()
            isLoadingMore = true
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 0 {
            activityIndicator.show()
            presenter?.searchRequest(text: searchBar.text!)
        } else {
            showError(description: "Enter Search Text")
        }
    }
}

// MARK: - SearchViewPresenterToViewProtocol
extension SearchTableViewController: SearchViewPresenterToViewProtocol {

    func showSearchResult() {
        tableView.reloadData()
        activityIndicator.hide()
    }
    
    func showNextPage() {
        tableView.reloadData()
        isLoadingMore = false
    }

    func showError(description: String) {
        activityIndicator.hide()
        let alert = UIAlertController(title: Error, message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

