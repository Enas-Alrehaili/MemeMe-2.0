//
//  MemeCollectionVC.swift
//  Memeef
//
//  Created by Enas Alrehaili on 2019-10-25.
//  Copyright © 2019 Enas Alrehaili. All rights reserved.
//
import Foundation
import UIKit

class MemeCollectionVC: UICollectionViewController  {
    let kCollectionViewCellID = "MemeCollectionViewCell"
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    var memes : [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
        
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.MemeImageView?.image = meme.memedImage
        return cell
   }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let meme = memes[indexPath.row]
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let detailController = storyboard.instantiateViewController(withIdentifier: "detailController") as! MemeDetailsVC
        detailController.meme = meme
        self.navigationController?.pushViewController(detailController, animated: true)
       }
}
