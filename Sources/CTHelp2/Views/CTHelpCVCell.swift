//
//  CTHelpCVCell.swift
//  CenterCellCollectionView
//
//  Created by Stewart Lynch on 6/26/19.
//  Copyright © 2019 Stewart Lynch. All rights reserved.
//
import UIKit

@available(iOS 12.0, *)
class CTHelpCVCell: UICollectionViewCell {
    
    var bgView = UIView()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 25)
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var imageHeightConstraint:NSLayoutConstraint!
    
    var helpTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        if #available(iOS 13.0, *) {
            textView.textColor = .label
        } else {
            textView.textColor = .black
        }
        textView.isEditable = false
        return textView
    }()
    
    var heightConstraint: NSLayoutConstraint!
    var actionButtonTopConstraint: NSLayoutConstraint!
    var cButton:UIButton = {
        let button = UIButton(type: .system)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        }
        return button
    }()
    var closeButton = CTPaddedButton.newButton()
    var actionBtn = UIButton(frame: .zero)
    
    weak var delegate: CTHelpViewController!
    
    
    var webSite:String?
    var contactEmail:String?
    var data:Data?
    var contactButtonTitle:String?
    var webButtonTitle:String?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(iOS 12.0, *)
    func setup() {
        backgroundColor = .clear
        addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            bgView.backgroundColor = .systemBackground
        } else {
            bgView.backgroundColor = .white
        }
        bgView.layer.cornerRadius = 14
        bgView.layer.shadowOpacity = 0.25
        bgView.layer.shadowOffset = .init(width: 5, height: 5)
        bgView.layer.shadowRadius = 7
        bgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 315 ).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: 281).isActive = true
        if #available(iOS 13.0, *) {
            addSubview(cButton)
            cButton.translatesAutoresizingMaskIntoConstraints = false
            cButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            cButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            cButton.tintColor = UIColor.systemGray
            cButton.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
            cButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor).isActive = true
            cButton.addTarget(self, action: #selector(closeHelp), for: .touchUpInside)
        } else {
            addSubview(closeButton)
            closeButton.padding = 28
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            closeButton.backgroundColor = UIColor.systemGray
            closeButton.setTitle("✚", for: .normal)
            closeButton.setTitleColor(.white, for: .normal)
            closeButton.layer.cornerRadius = 10
            closeButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
            closeButton.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10).isActive = true
            closeButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor,constant: -10).isActive = true
            closeButton.addTarget(self, action: #selector(closeHelp), for: .touchUpInside)
        }
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 8).isActive = true
        if #available(iOS 13.0, *) {
            titleLabel.trailingAnchor.constraint(equalTo: cButton.leadingAnchor, constant: -5).isActive = true
        } else {
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -5).isActive = true
        }
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 241).isActive = true
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 70)
        imageHeightConstraint.isActive = true
        
        bgView.addSubview(actionBtn)
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        actionBtn.backgroundColor = UIColor.systemBlue
        actionBtn.setTitle("Contact Developer", for: .normal)
        actionBtn.layer.cornerRadius = 5
        
        actionBtn.setTitleColor(.white, for: .normal)
        actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        actionBtn.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        actionBtn.widthAnchor.constraint(equalToConstant: 151).isActive = true
        actionButtonTopConstraint = actionBtn.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -43)
        actionButtonTopConstraint.isActive = true
        
        addSubview(helpTextView)
        helpTextView.translatesAutoresizingMaskIntoConstraints = false
        helpTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        helpTextView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10).isActive = true
        helpTextView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -10).isActive = true
        helpTextView.bottomAnchor.constraint(equalTo: actionBtn.topAnchor, constant: -5).isActive = true
        
        actionBtn.addTarget(self, action: #selector(actionRequest(_:)), for: .touchUpInside)
    }
    
    func configureView(ctHelpItem:CTHelpItem,bgViewColor:UIColor?,titleColor:UIColor?,helpTextColor:UIColor?,actionButtonBGColor:UIColor?, actionButtonTextColor:UIColor?, closeButtonBGColor:UIColor?,ctString:CTString?) {
        var imageViewHeightConstraintConstant:CGFloat = 0
        // Set up colors
        if let color = bgViewColor {
            bgView.backgroundColor = color
        }
        if let webButtonTitle = ctString?.webButtonTitle {
            self.webButtonTitle = webButtonTitle
        } else {
            self.webButtonTitle = "Visit Web Site"
        }
        
        if let contactButtonTitle = ctString?.contactButtonTitle {
            self.contactButtonTitle = contactButtonTitle
        } else {
            self.contactButtonTitle = "Contact Developer"
        }
        
        if let color = titleColor {
            titleLabel.textColor = color
        }
        
        if let color = helpTextColor {
            helpTextView.textColor = color
        }
        
        if let color = actionButtonBGColor {
            actionBtn.backgroundColor = color
        }
        
        if let color = actionButtonTextColor {
            actionBtn.setTitleColor(color, for: .normal)
        }
        
        if let color = closeButtonBGColor {
            if #available(iOS 13.0, *) {
              cButton.tintColor = color
            } else {
                closeButton.backgroundColor = color
            }
        }
        
        titleLabel.text = ctHelpItem.title
        helpTextView.text = ctHelpItem.helpText
        if let webSite = ctHelpItem.webSite {
            self.webSite = webSite
        }
        if let contactEmail = ctHelpItem.contactEmail {
            self.contactEmail = contactEmail
        }
        if let data = ctHelpItem.data {
            self.data = data
        }
        
        if ctHelpItem.imageName != "" {
            imageView.image = UIImage(named: ctHelpItem.imageName)
            if let height = UIImage(named: ctHelpItem.imageName)?.size.height {
                imageViewHeightConstraintConstant = height
            }
        }
        
        imageHeightConstraint.constant = min(imageViewHeightConstraintConstant, 230.0)
        
        if let btn = ctHelpItem.btn {
            switch btn {
            case .Web:
                actionButtonTopConstraint.constant = -43
                actionBtn.isHidden = false
                actionBtn.setTitle(webButtonTitle, for: .normal)
            case .Email:
                actionButtonTopConstraint.constant = -43
                actionBtn.isHidden = false
                actionBtn.setTitle(contactButtonTitle, for: .normal)
            }
        } else {
            actionButtonTopConstraint.constant = 0
            actionBtn.isHidden = true
        }
    }
    
    @objc func actionRequest(_ sender: UIButton) {
        if actionBtn.title(for: .normal) == webButtonTitle {
            if let webSite = webSite {
                guard let url = URL(string: webSite) else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            if let contactEmail = contactEmail {
                delegate?.emailDeveloper(withAddress: contactEmail, withData: data)
            }
        }
    }
    
    @objc func closeHelp() {
        delegate.dismissVC()
    }
}
