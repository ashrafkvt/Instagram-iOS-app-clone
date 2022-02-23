//
//  FeedCell.swift
//  instagramCloneApp
//
//  Created by Ashraf on 22/02/22.
//

import Foundation
import UIKit

class FeedCell: UICollectionViewCell{
    
//    MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "user-photo")
        return iv
    }()
    
    private lazy var userNameButton: UIButton = {
        let usernameBtn = UIButton(type: .system)
        usernameBtn.setTitle("username", for: .normal)
        usernameBtn.setTitleColor(.black, for: .normal)
        usernameBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        usernameBtn.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        return usernameBtn
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "post-image")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "100 likes"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "caption goes here "
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "one week ago"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(profileImageView)
        profileImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        contentView.addSubview(userNameButton)
        userNameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        contentView.addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        
        configureActionButtons()
        
        contentView.addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: contentView.leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        contentView.addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        contentView.addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: contentView.leftAnchor, paddingTop: 6, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Actions
    
    @objc func didTapUserName(){
        print("DEBUG: - Tapped")
    }
    
//    MARK: - Helpers
    
    func configureActionButtons(){
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
    
}
