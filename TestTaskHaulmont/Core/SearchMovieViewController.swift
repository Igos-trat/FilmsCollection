
import Foundation
import UIKit

class SearchMovieViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var results = [Movie]()
    var timer: Timer?
   
    private var tableView: UITableView = {
       let table = UITableView()
       table.translatesAutoresizingMaskIntoConstraints =  false
       table.backgroundColor = .background()
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
        view.backgroundColor = .background()
        title = "Search Movie"
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.text()]
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
    
    //MARK: - setup constraints TableView
    private func setupTable(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifire)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
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
        cell.backgroundColor = .buttonB()
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
}

