//
//  FeedTableViewCell.swift
//  SocialCellUI
//
//  Created by 김정민 on 2022/03/24.
//

import UIKit
import SnapKit

class FeedTableViewCell: UITableViewCell {
    
    private var imageRatioConstraints: NSLayoutConstraint!
    
    
    var feed: Feed! {
        didSet {
            profileImageView?.image = feed.author.profileImage
            authorLabel?.text = feed.author.name
            timeLabel?.text = feed.time
            contentTextLabel?.text = feed.contents.text
            contentImageView?.image = feed.contents.image
            likesLabel?.text = "\(feed.likes)"
            
            contentTextLabel?.isHidden = contentTextLabel?.text?.isEmpty == true
            contentImageView?.isHidden = contentImageView?.image == nil
            
            if let contentImageRatioContraint = imageRatioConstraints {
                contentImageRatioContraint.isActive = false
                contentImageView.removeConstraint(contentImageRatioContraint)
            }
            
            if let image = contentImageView.image {
                imageRatioConstraints = contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor,multiplier: image.size.height / image.size.width)
            }
            
        }
    }
    
    private var profileImageView: UIImageView!
    private var authorLabel: UILabel!
    private var timeLabel: UILabel!
    private var contentTextLabel: UILabel!
    private var contentImageView: UIImageView!
    private var likesLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        drawCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension FeedTableViewCell {
    
    private func drawCell() {
        
        selectionStyle = .none
        profileImageView = UIImageView()
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
        
        authorLabel = UILabel()
        authorLabel.adjustsFontForContentSizeCategory = true
        authorLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        authorLabel.textColor = .black
        authorLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        authorLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        authorLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        
        timeLabel = UILabel()
        timeLabel.adjustsFontForContentSizeCategory = true
        timeLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        timeLabel.textColor = .darkGray
        timeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, authorLabel, timeLabel])
        profileStack.axis = .horizontal
        profileStack.spacing = UIStackView.spacingUseSystem
        
        contentTextLabel = UILabel()
        contentTextLabel.adjustsFontForContentSizeCategory = true
        contentTextLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentTextLabel.textColor = .black
        contentTextLabel.numberOfLines = 0
        
        
        contentImageView = UIImageView()
        contentImageView.clipsToBounds = true
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.isUserInteractionEnabled = true
        
        
        let likesImageView = UIImageView(image: UIImage(systemName: "hand.thumbsup.fill"))
        likesImageView.tintColor = .systemBlue
        likesImageView.contentMode = .scaleAspectFit
        likesImageView.setContentHuggingPriority(.required, for: .horizontal)
        
        likesLabel = UILabel()
        likesLabel.adjustsFontForContentSizeCategory = true
        likesLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        
        let likeStack = UIStackView(arrangedSubviews: [likesImageView,likesLabel])
        likeStack.alignment = .center
        likeStack.distribution = .fill
        likeStack.axis = .horizontal
        likeStack.spacing = UIStackView.spacingUseSystem
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .center
        
        ["좋아요","댓글 달기","공유하기"].forEach{ title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tintColor = .darkGray
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.gray.cgColor
            buttonStack.addArrangedSubview(button)
        }
        
        let contentStack = UIStackView(arrangedSubviews: [profileStack,contentTextLabel,contentImageView,likeStack,buttonStack])
        
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .equalSpacing
        contentStack.spacing = UIStackView.spacingUseSystem
        contentView.addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(20)
            make.trailing.equalTo(contentView.snp.trailing).inset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
            make.top.equalTo(contentView.snp.top).inset(8)
        }
        
        
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.1)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        contentImageView.snp.makeConstraints { make in
            make.width.equalTo(contentImageView.snp.height).priority(.high)
        }
        
        likesImageView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(likesLabel.snp.height).priority(.high)
            make.height.greaterThanOrEqualTo(30)
            make.width.equalTo(likesImageView.snp.height)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:)))
        contentImageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func tapImageView(_ sender: UITapGestureRecognizer) {
        
        guard let constraint = imageRatioConstraints else {
            return
        }
        
        constraint.isActive = !constraint.isActive
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        NotificationCenter.default.post(name: Notification.Name("NeedsupdateLayout"), object: nil)
        
    }
}
