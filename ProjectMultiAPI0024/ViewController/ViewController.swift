//
//  ViewController.swift
//  ProjectMultiAPI0024
//
//  Created by macbook on 09/02/22.
//  Copyright © 2022 sudza. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var getImg: [PhotosModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()

    }

    //Mark: - collectionview methode
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! PhotoCollectionVC
        let obj = getImg[indexPath.item]
        cell.getImages.sd_setImage(with: URL(string: obj.thumbnailUrl), completed: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = getImg[indexPath.item]
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsInfoVC")as! DetailsInfoVC
        vc.album = obj
        vc.imgID = obj.albumId
        vc.urlTake = obj.url
        vc.takeTitle = obj.title

        navigationController?.pushViewController(vc, animated: true)

    }
    //Mark: - get photos
    func getPhotos(){
        let photosUrl = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: photosUrl!) { (data, response, error) in
            if error == nil {
                do {
                    self.getImg = try JSONDecoder().decode([PhotosModel].self, from: data!)
                    DispatchQueue.main.async {
                        self.myCollectionView.reloadData()
                    }

                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
   
}

