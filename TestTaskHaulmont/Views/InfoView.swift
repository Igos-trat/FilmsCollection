
import UIKit

class InfoView: UIView {
    
    // MARK: - Properties
    private var urlString: String = ""
    private var networking = requestFromTMDb()
    
     lazy var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "multiply"), for: .normal)
        button.backgroundColor = .buttonB()
        button.layer.cornerRadius = 30/2
        return button
    }()
    
    var starImg: UIImageView = {
       let star = UIImageView(image: UIImage(systemName: "star.fill"))
        star.translatesAutoresizingMaskIntoConstraints = false
        star.tintColor = .orange
       return star
   }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        return iv
    }()
    
    let titleFilmLabel: UILabel = {
        let label = UILabel(text: "",
                            font: .systemFont(ofSize: 24, weight: .bold),
                            color: .title())
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let overviewLabel: UILabel = {
        let text = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium), color: .text())
        text.textAlignment = .justified
        text.numberOfLines = 25
        text.translatesAutoresizingMaskIntoConstraints =  false
        return text
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel(text: "Release",
                            font: .systemFont(ofSize: 16, weight: .semibold),
                            color: .title())
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel(text: "Rating",
                            font: .systemFont(ofSize: 16, weight: .semibold),
                            color: .title())
        
        
        return label
    }()

    let releaseIndexLabel: UILabel = {
        let label = UILabel(text: "",
                            font: .systemFont(ofSize: 16, weight: .semibold),
                            color: .text())
        
        return label
    }()
    
    let rateIndexLabel: UILabel = {
        let label = UILabel(text: "",
                            font: .systemFont(ofSize: 16, weight: .semibold),
                            color: .text())
        return label
    }()
  
    var stackView = UIStackView()
    var stackIndexView = UIStackView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStack()
        setupIndexStack()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup into cell
    func setupOnCell(_ result: Movie){
        update(title: result.title, rate: "\(result.rate ?? 0)", overview: result.overview, backdrop: result.backdropImage, release: result.convertDataFormat(result.year))
    }
    
    func update(title: String?, rate: String?, overview: String?, backdrop: String?, release: String?) {
        self.releaseIndexLabel.text = release
        self.titleFilmLabel.text = title
        self.rateIndexLabel.text =  rate
        self.overviewLabel.text =  overview
        
        guard let backdropString = backdrop else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + backdropString
        
        guard let backdropImageURL = URL(string: urlString) else {
            self.imageView.image = UIImage(named: "noImageAvailable")
            return
        }
        self.imageView.image = nil
        networking.fetchImage(url: backdropImageURL) { [weak self] (data: Data) in
            if let image = UIImage(data: data) {
                self?.imageView.image = image
            } else {
                self?.imageView.image = UIImage(named: "noImageAvailable")
            }
        }
    }

    // MARK: - setStackViews
     func setupStack() {
        stackView = UIStackView(arrangedSubviews: [
                                                   releaseLabel,
                                                   rateLabel
                                                  ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
     func setupIndexStack() {
        stackIndexView = UIStackView(arrangedSubviews: [
                                                        releaseIndexLabel,
                                                        rateIndexLabel
                                                  ])
        stackIndexView.axis = .vertical
        stackIndexView.spacing = 10
        stackIndexView.distribution = .equalSpacing
        stackIndexView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - setupViews
    func configureViewComponents() {
        backgroundColor = .background()
        self.layer.masksToBounds = true
        
        addSubview(exitButton)
        exitButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 30, height: 30)
        
        addSubview(titleFilmLabel)
        titleFilmLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 45, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 0)
        titleFilmLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 85, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 225)
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor,constant: 330).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100).isActive = true
        
        addSubview(stackIndexView)
        stackIndexView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: 30).isActive = true
        stackIndexView.topAnchor.constraint(equalTo: topAnchor, constant: 330).isActive = true
        
        addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: stackIndexView.bottomAnchor, constant: 20).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        stackIndexView.addSubview(starImg)
        starImg.trailingAnchor.constraint(equalTo: stackIndexView.trailingAnchor, constant: -7).isActive = true
        starImg.bottomAnchor.constraint(equalTo: stackIndexView.bottomAnchor, constant: -1).isActive = true
        starImg.widthAnchor.constraint(equalToConstant: 18).isActive = true
        starImg.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
}
