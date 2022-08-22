
import Foundation
import UIKit

class MovieLibrary: UIViewController {

    private var results = [FilmsEntity]()
   
    private var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(CollectionCellForLibrary.self, forCellWithReuseIdentifier: CollectionCellForLibrary.reuseId)
        collection.backgroundColor = .background()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    //MARK: - this
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurate()
        setVisualEffectView()
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("add to library"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    //MARK: - setup VisualEffectView
    private func setVisualEffectView() {
        view.addSubview(visualEffectView)
        
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        visualEffectView.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissInfoView))
        let gestureTwo = UITapGestureRecognizer(target: self, action: #selector(dismissInfoView))
        infoView.exitButton.addGestureRecognizer(gesture)
        visualEffectView.addGestureRecognizer(gestureTwo)
    }

    //MARK: - Dismiss InfoView
    @objc private func dismissInfoView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.infoView.removeFromSuperview()
        }
    }
    
    //MARK: - setup InfoView
    private func setInfoView() {
        view.addSubview(infoView)
        infoView.configureViewComponents()
    
        infoView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 34, height: 700)
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
    
    //MARK: - Configutation
    func configurate() {
        view.backgroundColor = .background()
        self.title = "Movie Library"
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
                                    ])
    
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.text()]
        navigationItem.standardAppearance = appearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:
                                                            UIImage(named: "arrowshape.backward.fill"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(goBackButtonTap))
    }
    
    //MARK: - Selectors
    @objc func goBackButtonTap() {
      self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //MARK: - FetchCoreData
    private func fetchLocalStorageForDownload() {
        PersistenceManager.shared.fetchFromCoreData { [weak self] result in
            switch result {
            case .success(let films):
                self?.results = films
                
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - downloadToLibrary
    private func removeFromLibrary(indexPath: IndexPath) {
        
        PersistenceManager.shared.removeFromCoreData(model: results[indexPath.row]) { [weak self] result in
            switch result {
            case .success():
                print("Deleted fromt the database")
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.results.remove(at: indexPath.row)
            self?.collectionView.deleteItems(at: [indexPath])
        }
    }
}

// MARK: - UICollectionViewDataSource/Delegate
extension MovieLibrary: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellForLibrary.reuseId, for: indexPath) as! CollectionCellForLibrary
        
        let results = results[indexPath.row]
        cell.setupOnCellFromCoreData(results)
        cell.backgroundColor = .buttonB()
        return cell
    }
    
    // MARK: - this
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setInfoView()
        let results = results[indexPath.row]
        infoView.setupOnCellFromCoreData(results)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let download = UIAction(title: "Delete", image: UIImage(named: "trash.fill"))
                { _ in
                    self?.removeFromLibrary(indexPath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [download])
            }
        return config
        }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieLibrary: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width/3)-1,
                      height: (view.frame.size.width/2)-1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}



