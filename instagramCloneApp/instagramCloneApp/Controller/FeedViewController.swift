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
        feedsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
//  MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
//    MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 200)
    }
    
}
