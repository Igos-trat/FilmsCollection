
import UIKit
import CoreData

protocol MovieControllerDelegate: AnyObject{
    func didTapButtonProfile()
}

class MovieBrowserController: UICollectionViewController{


    // MARK: - Properties
    var delegate: MovieControllerDelegate?
    
    init() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            super.init(collectionViewLayout: layout)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let infoView: InfoView = {
        let view = InfoView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()

    
  
    private var results  = [Movie]()

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchFromTMbd()
        configureViewComponents()
        configurateNavBar()
    }

    // MARK: - API
    private func fetchFromTMbd() {
    let urlString = "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.apiKEY)&language=en-US&page=1"
    FetchData.shared.fetchStatistic(urlString: urlString) { [weak self] userModel, error in
        if error == nil {

            guard let userModel = userModel else { return }

            self?.results = userModel.movies
            print(self?.results ?? "")
            self?.collectionView.reloadData()
        } else {
            print(error!.localizedDescription)
        }
    }
}
    
    //MARK: - Configurate NavigationBar
    private func configurateNavBar() {
        self.title = "Movie Browser"
        collectionView.backgroundColor = .background
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.text]
        navigationItem.standardAppearance = appearance
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:
                                                            UIImage(systemName: "list.bullet"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(barButtonTapped))
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:
                                                            UIImage(systemName: "magnifyingglass"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(toSearchButtonTapped))
 
    }
    
    //MARK: - Selectors
    @objc func barButtonTapped() {
        delegate?.didTapButtonProfile()
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 0.6
        }
        
    }
    
    @objc func toSearchButtonTapped() {
        let searchVC =  SearchMovieViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
   
    @objc func handleDismissal() {
        dismissInfoView()
    
       
    }
    
    //MARK: - setup InfoView
    private func setInfoView() {
        view.addSubview(infoView)
        infoView.configureViewComponents()
    
        infoView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 34, height: 650)
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        infoView.alpha = 1
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 0.6
            self.infoView.alpha = 1
            self.infoView.transform = .identity
        }
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
    
    //MARK: - Dismiss InfoView
    private func dismissInfoView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.infoView.removeFromSuperview()
        }
    }
    
    //MARK: - set VisualEffect, dismissGesture, colletionRegister
    private func configureViewComponents() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        visualEffectView.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        let gestureTwo = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        infoView.exitButton.addGestureRecognizer(gesture)
        visualEffectView.addGestureRecognizer(gestureTwo)
    }
}

// MARK: - UICollectionViewDataSource/Delegate
extension MovieBrowserController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        let results = results[indexPath.row]
        cell.setupOnCell(results)
        cell.backgroundColor = .buttonB
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setInfoView()
        let results = results[indexPath.row]
        infoView.setupOnCell(results)
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
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

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieBrowserController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width/2)-0.5,
                      height: (view.frame.size.width/1.3)-9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


