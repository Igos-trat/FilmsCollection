
import Foundation
import UIKit
import SnapKit

class SearchMovieViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var results = [Movie]()
    var timer: Timer?
   
    private var tableView: UITableView = {
       let table = UITableView()
       table.translatesAutoresizingMaskIntoConstraints =  false
       table.backgroundColor = .background
       return table
       }()
    
    let detailVc = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateNavBar()
        setupTable()
        setupSearhcBar()
    }
    //MARK: - Configurate NavigationBar
    private func configurateNavBar() {
        view.backgroundColor = .background
        title = "Search Movie"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.text]
        navigationItem.standardAppearance = appearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:
                                                            UIImage(named: "arrowshape.backward.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goBackButtonTap))
        
       
    }
    //MARK: - API
    private func fetchFromTMbd(query: String) {
        let urlString = "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.apiKEY)&query=\(query)"
        FetchData.shared.fetchStatistic(urlString: urlString) { [weak self] userModel, error in
            if error == nil {
                
                guard let userModel = userModel else { return }
                
                self?.results = userModel.movies
                print(self?.results ?? "")
                self?.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    //MARK: - Selectors
    @objc func goBackButtonTap() {
      self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - configurate SearchBar
    private func setupSearhcBar() {
       navigationItem.hidesSearchBarWhenScrolling = false
       navigationItem.searchController = searchController
       searchController.searchBar.delegate = self
       searchController.obscuresBackgroundDuringPresentation = false
       searchController.searchBar.placeholder = "Search Movie"
       searchController.searchBar.resignFirstResponder()
    }
    
    //MARK: - downloadToLibrary 
    private func downloadToLib(indexPath: IndexPath) {
        PersistenceManager.shared.downloadToLibrary(model: results[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("add to library"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - setup constraints TableView
    private func setupTable(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifire)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}
//MARK: - SearchBarDelegate
extension SearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.fetchFromTMbd(query: searchText)
            })
        }
    }
}
//MARK: - TableViewDataSource, TableViewDelegate
extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifire, for: indexPath) as! TableViewCell
        cell.selectionStyle = .blue
        cell.backgroundColor = .buttonB
        let result = results[indexPath.row]
        cell.setupOnCell(result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = results[indexPath.row]
        detailVc.setupOnCell(result)
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let download = UIAction(title: "Add to library", image: UIImage(named: "folder.badge.plus"))
                { _ in
                    self?.downloadToLib(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [download])
            }
        return config
   }
}

