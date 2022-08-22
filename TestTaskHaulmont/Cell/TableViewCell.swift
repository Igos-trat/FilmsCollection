
import UIKit

class TableViewCell: UITableViewCell {

    static let identifire =  "TableViewCell"
    private var urlString: String = ""
    private var networking = NetworkRequest()
  
     let titleLabel: UILabel = {
        let label = UILabel(text: "", font: .systemFont(ofSize: 15, weight: .bold), color: .title())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
         
        return label
    }()
    
     let titlesPosterImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noImageAvailable"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth =  2
        imageView.layer.borderColor = #colorLiteral(red: 0.2192789018, green: 0.2672641873, blue: 0.3449955583, alpha: 1)
        return imageView
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .medium), color: .text())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
       return label
    }()
    
    let starImage: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "star.fill"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let rateLabel: UILabel = {
        let label =  UILabel(text: "", font: .systemFont(ofSize: 16, weight: .bold), color: .text())
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let releaseLabel: UILabel =  {
        let label = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .bold), color: .text())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        applyConstraints()
        
    }
    
    //MARK: - setup into cell
    func setupOnCell(_ result: Movie){
        update(title: result.title, rate: "\(result.rate ?? 0)", overview: result.overview, backdrop: result.backdropImage, release: result.convertDataFormat(result.year))
    }
    
    func update(title: String?, rate: String?, overview: String?, backdrop: String?, release: String?) {
        self.releaseLabel.text = release
        self.titleLabel.text = title
        self.rateLabel.text =  rate
        self.overviewLabel.text =  overview
        
        guard let backdropString = backdrop else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + backdropString
        
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
    }
    
    private func applyConstraints() {
        addSubview(titlesPosterImage)
        NSLayoutConstraint.activate([
            titlesPosterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titlesPosterImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titlesPosterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titlesPosterImage.widthAnchor.constraint(equalToConstant: 210)
            
        ])
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImage.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 180),
        ])
        addSubview(starImage)
        NSLayoutConstraint.activate([
            starImage.leadingAnchor.constraint(equalTo: titlesPosterImage.trailingAnchor, constant: 10),
            starImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            starImage.heightAnchor.constraint(equalToConstant: 20),
            starImage.widthAnchor.constraint(equalToConstant: 20)
                                    ])
        
        addSubview(overviewLabel)
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: titlesPosterImage.trailingAnchor, constant: 10),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            overviewLabel.bottomAnchor.constraint(equalTo: starImage.topAnchor, constant: -2),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            overviewLabel.widthAnchor.constraint(equalToConstant: 190),
                                    
                                    ])
        
        addSubview(rateLabel)
        NSLayoutConstraint.activate([
            rateLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 2),
            rateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                                    
                                    ])
        
        addSubview(releaseLabel)
        NSLayoutConstraint.activate([
            releaseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            releaseLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            releaseLabel.widthAnchor.constraint(equalToConstant: 150)
             ])
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}


