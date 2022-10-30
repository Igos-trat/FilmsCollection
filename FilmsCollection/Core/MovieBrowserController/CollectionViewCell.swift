
import UIKit

class CollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseId = "CollectionViewCell"
    
    private var urlString: String = ""
    private var networking = NetworkRequest()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.text.withAlphaComponent(0.95)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        view.addSubview(starImg)
        view.addSubview(releaseLabel)
        view.addSubview(rateLabel)
        
        releaseLabel.leftBottom(inView: view)
        rateLabel.rightBottom(inView: view)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        starImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        starImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38).isActive = true
        starImg.widthAnchor.constraint(equalToConstant: 19).isActive = true
        starImg.heightAnchor.constraint(equalToConstant: 19).isActive = true
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(text: "",
                            font: .systemFont(ofSize: 16, weight: .bold),
                            color: .white)
         
         label.adjustsFontForContentSizeCategory = true
         label.numberOfLines = 2
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let starImg: UIImageView = {
        let star = UIImageView(image: UIImage(systemName: "star.fill"))
         star.translatesAutoresizingMaskIntoConstraints = false
         star.tintColor = .orange
        return star
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel(text: "",
                            font: .systemFont(ofSize: 13, weight: .medium),
                            color: .white)
        
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel(text: "",
                            font: .systemFont(ofSize: 16, weight: .bold),
                            color: .white)
        
        return label
    }()

    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureViewComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - setup into cell
    func setupOnCell(_ result: Movie){
        update(title: result.title, rate: "\(result.rate ?? 0)", posterImg: result.posterImage, release: result.convertDataFormat(result.year))
    }

    func update(title: String?, rate: String?, posterImg: String?, release: String?) {
        self.releaseLabel.text = release
        self.nameLabel.text = title
        self.rateLabel.text =  rate
        
        guard let backdropString = posterImg else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + backdropString
        
        guard let backdropImageURL = URL(string: urlString) else {
            self.imageView.image = UIImage(named: "noImage")
            return
        }
        self.imageView.image = nil
        networking.fetchImage(url: backdropImageURL) { [weak self] (data: Data) in
            if let image = UIImage(data: data) {
                self?.imageView.image = image
            } else {
                self?.imageView.image = UIImage(named: "noImage")
            }
        }
    }
    
    //MARK: - setup into cell
    func setupOnCellFromCoreData(_ result: FilmsEntity) {
        update(title: result.title, posterImg: result.posterImage)
    }

    func update(title: String?, posterImg: String?) {
        self.nameLabel.text = title
        
        guard let backdropString = posterImg else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + backdropString
        
        guard let backdropImageURL = URL(string: urlString) else {
            self.imageView.image = UIImage(named: "noImage")
            return
        }
        self.imageView.image = nil
        networking.fetchImage(url: backdropImageURL) { [weak self] (data: Data) in
            if let image = UIImage(data: data) {
                self?.imageView.image = image
            } else {
                self?.imageView.image = UIImage(named: "noImage")
            }
        }
    }
    
    // MARK: - Helper Functions
    private func configureViewComponents() {
        self.clipsToBounds = true
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0),
            imageView.topAnchor.constraint(equalTo: topAnchor,constant: 0)
        ])
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 0),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
}
