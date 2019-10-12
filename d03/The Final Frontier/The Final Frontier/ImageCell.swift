//
//  ImageCell.swift
//  The Final Frontier
//
//  Created by Ryan de Kwaadsteniet on 2017/11/14.
//  Copyright © 2017 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initialiser not implemented")
    }
}

class ImageCell: BaseCell {
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    var image: Image? {
        didSet {
            
            titleLabel.text = image?.title
            bannerImageView.addSubview(activityView)
            activityView.center = bannerImageView.center
            activityView.startAnimating()
            setupBannerImage()
            
            // set title of image (uilabel)
            titleLabel.text = image?.title
            // casts the object attribute of photographer naem into the text view
            if let photographerName = self.image?.photographer?.name {
                let subtitleText = "\(photographerName)"
                self.authorTextView.text = subtitleText
            }
            
            //measure title text
            if let title = image?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = image?.photographer?.profileImage {
            userImageView.loadImageUsingUrlString(profileImageUrl, activityView: activityView)
        }
    }
    
    func setupBannerImage() {
        if let imageUrl = image?.imageBanner {
            bannerImageView.loadImageUsingUrlString(imageUrl, activityView: activityView)
        }
    }
    
    // image view for the main image, type CustomImageView as I tailored it for images fetched from urls
    let bannerImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.image = UIImage(named: "stockImage")
        // fits according to aspect ratio so as to not cut the image short
        imageView.contentMode = .scaleAspectFit
        // image confined to bounds of view
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // custom image view for the photographer's image
    let userImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.image = UIImage(named: "stockPhotographer")
        // rounding a square until it becomes a perfect circle (corner radius half length of square)
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // basic view for the separator line between cells
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        // defaults to true when views created programmatically, as I am using autolayout and then
        // providing a non ambiguous, nonconflicting set of constraints for the view
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    // create the text view for the subtitle (photographer's name)
    let authorTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        // so text is not cut short on the left
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
        
        // subviews added and constraints initialised
        override func setupViews() {
            addSubview(bannerImageView)
            addSubview(separatorView)
            addSubview(userImageView)
            addSubview(titleLabel)
            addSubview(authorTextView)
            
            //horizontal contsraints
            addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: bannerImageView)
            addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|", views: userImageView, titleLabel)
            addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
            //vertical constraints
            addConstraintsWithFormat(format: "V:|-16-[v0]-4-[v1(44)]-50-[v2(1)]|", views: bannerImageView, userImageView, separatorView)
            
            // title top constraint
            addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: bannerImageView, attribute: .bottom, multiplier: 1, constant: 4)])
            // title height constraint
            addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)])

            // photographer top constraint
            addConstraints([NSLayoutConstraint(item: authorTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4)])
            // photographer left constraint
            addConstraints([NSLayoutConstraint(item: authorTextView, attribute: .left, relatedBy: .equal, toItem: userImageView, attribute: .right, multiplier: 1, constant: 8)])
            // photographer right constraint
            addConstraints([NSLayoutConstraint(item: authorTextView, attribute: .right, relatedBy: .equal, toItem: bannerImageView, attribute: .right, multiplier: 1, constant: 0)])
            // photographer height constraint
            addConstraints([NSLayoutConstraint(item: authorTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30)])
        }
        
    }
