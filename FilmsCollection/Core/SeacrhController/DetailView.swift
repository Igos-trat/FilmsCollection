
import UIKit

class DetailView: UIViewController {
    
    
    private var urlString: String = ""
    private var networking = NetworkRequest()
    
    let titlesPosterImage: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "noImageAvailable"))
       imageView.contentMode = .scaleAspectFill
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.layer.masksToBounds = true
       return imageView
   }()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "", font: .systemFont(ofSize: 23, weight: .bold), color: .title)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium), color: .text)
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 30
        label.adjustsFontForContentSizeCategory = true
        label.sizeToFit()
        return label
    }()
    
    let starImage: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "star.fill"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let rateLabel: UILabel = {
        let label =  UILabel(text: "", font: .systemFont(ofSize: 16, weight: .bold), color: .text)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let releaseLabel: UILabel =  {
        let label = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .bold), color: .text)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let posterView: UIImageView = {
        let poster = UIImageView()
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateNavBar()
        configureConstraints()
    }
    
    //MARK: - setup into cell
    func setupOnCell(_ result: Movie){
        update(title: result.title, rate: "\(result.rate ?? 0)", overview: result.overview, backdrop: result.backdropImage, release: result.convertDataFormat(result.year), poster: result.posterImage)
    }
    
    func update(title: String?, rate: String?, overview: String?, backdrop: String?, release: String?, poster: String?) {
        self.releaseLabel.text = release
        self.titleLabel.text = title
        self.rateLabel.text =  rate
        self.overviewLabel.text =  overview
        
        guard let backdropString = backdrop else {return}
        urlString = "https://image.tmdb.org/t/p/w500" + backdropString
        
        guard let backdropImageURL = URL(string: urlString) else {
            self.titlesPosterImage.image = UIImage(named: "noImageAvailable")
            return
        }
        self.titlesPosterImage.image = nil
        networking.fetchImage(url: backdropImageURL) { [weak self] (data: Data) in
            if let image = UIImage(data: data) {
                self?.titlesPosterImage.image = image
            } else {
                self?.titlesPosterImage.image = UIImage(named: "noImageAvailable")
            }
        }
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.posterView.image = UIImage(named: "noImage")
            return
        }
        self.posterView.image = nil
        networking.fetchImage(url: posterImageURL) { [weak self] (data: Data) in
            if let image = UIImage(data: data) {
                self?.posterView.image = image
            } else {
                self?.posterView.image = UIImage(named: "noImage")
            }
        }
    }

    //MARK: - Configurate NavigationBar
   private func configurateNavBar() {
    view.backgroundColor = .background
    let appearance = UINavigationBarAppearance()
    appearance.titleTextAttributes = [.foregroundColor: UIColor.text]
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
    //MARK: - setupConstraints
    private func configureConstraints() {

        view.addSubview(titlesPosterImage)
        NSLayoutConstraint.activate([
        titlesPosterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        titlesPosterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
        titlesPosterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
        titlesPosterImage.heightAnchor.constraint(equalToConstant: 280),
        titlesPosterImage.widthAnchor.constraint(equalToConstant: 100)
                                    ])
        
        titlesPosterImage.addSubview(posterView)
        NSLayoutConstraint.activate([
        posterView.centerYAnchor.constraint(equalTo: titlesPosterImage.centerYAnchor),
        posterView.leadingAnchor.constraint(equalTo: titlesPosterImage.leadingAnchor, constant: 10),
        posterView.widthAnchor.constraint(equalToConstant: 140),
        posterView.heightAnchor.constraint(equalToConstant: 200)

                                    ])
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: titlesPosterImage.bottomAnchor,constant: 5),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        titleLabel.widthAnchor.constraint(equalToConstant: 250),
                                    ])
        
        view.addSubview(rateLabel)
        NSLayoutConstraint.activate([
        rateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
        rateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),
                                ])
        
        view.addSubview(starImage)
        NSLayoutConstraint.activate([
        starImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
        starImage.trailingAnchor.constraint(equalTo: rateLabel.leadingAnchor, constant: -3),
        starImage.widthAnchor.constraint(equalToConstant: 18),
        starImage.heightAnchor.constraint(equalToConstant: 18)
                                    ])
        
        view.addSubview(overviewLabel)
        NSLayoutConstraint.activate([
        overviewLabel.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 10),
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
                                    ])
      
        view.addSubview(releaseLabel)
        NSLayoutConstraint.activate([
        releaseLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
        releaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),
        releaseLabel.widthAnchor.constraint(equalToConstant: 200)
                                    ])
        }
    }

