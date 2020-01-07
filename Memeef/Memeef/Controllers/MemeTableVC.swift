//
//  MemeTableVC.swift
//  Memeef
//
//  Created by Enas Alrehaili on 2019-10-25.
//  Copyright © 2019 Enas Alrehaili. All rights reserved.
//

import UIKit

class MemeTableVC: UITableViewController  {
    var memes : [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    // number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    // cell for row at index path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID")!
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text =  "\(meme.topText)...\(meme.bottomText)"
        return cell

    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let meme = memes[indexPath.row]
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "detailController")as! MemeDetailsVC
        detailsVC.meme = meme
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

