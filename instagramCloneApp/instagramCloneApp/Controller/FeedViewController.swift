//
//  FeedController.swift
//  instagramCloneApp
//
//  Created by Ashraf on 14/02/22.
//

import UIKit
import Firebase


class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let feedsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let reuseIdentifier = "cell"
    
//  MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCpllectionView()
    }
    
//  MARK: - Helper
    
    func setupCpllectionView(){
        self.view.addSubview(feedsCollectionView)
        feedsCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
                                   bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain,
                                                                                  target: self, action: #selector(handleLogout))
        navigationItem.title = "Feed"
        
        feedsCollectionView.dataSource = self
        feedsCollectionView.delegate = self
        feedsCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
//    MARK: - Actions
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        catch {
            print("DEBUG: - Failed to sign out")
        }
    }
    
    
//  MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        return cell
    }
    
//    MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width
        var height =  width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
    
}
