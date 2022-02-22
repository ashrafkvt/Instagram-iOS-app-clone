//
//  FeedController.swift
//  instagramCloneApp
//
//  Created by Ashraf on 14/02/22.
//

import UIKit


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
        feedsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feedsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            feedsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        feedsCollectionView.dataSource = self
        feedsCollectionView.delegate = self
        feedsCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
