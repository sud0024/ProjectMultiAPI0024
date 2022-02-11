//
//  DetailsInfoVC.swift
//  ProjectMultiAPI0024
//
//  Created by macbook on 09/02/22.
//  Copyright © 2022 sudza. All rights reserved.
//

import UIKit

class DetailsInfoVC: UIViewController {
    var album:PhotosModel?
    var photoAlbum: AlbumModel?
    var getData:UserDetailModel?
    var users:AlbumModel?
    var getCommit:CommentsModel?
    var comment:CommentsModel?


    var userName:String?
    var urlTake:String?
    var imgID:Int?
    var takeTitle:String?
    var myComments: [CommentsModel] = []
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var photoImages: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoImages.sd_setImage(with: URL(string: urlTake!), completed: nil)
        getphotosDetails()
        getCommentsOnPhotos(id: (album?.id)!)
    }
    //Mark: - get id, title from albumId
    func getphotosDetails(){
        let photoModel:AlbumModel?
        let photosUrl = URL(string: "https://jsonplaceholder.typicode.com/albums/\(String(describing: album!.albumId))")
        URLSession.shared.dataTask(with: photosUrl!) { (data, response, error) in
            if error == nil {
                do {
                    self.photoAlbum = try JSONDecoder().decode(AlbumModel.self, from: data!)
                    //call userget func
                    self.getUserDetails(id: (self.photoAlbum?.id)!)
                    DispatchQueue.main.async {
                        self.lblTitle.text = "\("Title:", self.album!.title)"
                        self.lblId.text = "\("ID:", self.album!.id)"
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    }
    //Mark: - get user details from UserId
    func getUserDetails(id: Int){
        print("userId", id)
        var users:AlbumModel?
        var getData:UserDetailModel?
        let userUrl = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")
        URLSession.shared.dataTask(with: userUrl!) { (data, response, error) in
            if error == nil {
                do {
                    self.getData = try JSONDecoder().decode(UserDetailModel.self, from: data!)

                    DispatchQueue.main.async {
                        self.lblName.text = "\("Name", self.getData!.name)"
                        self.lblComments.text = "\("Email", self.getData!.email)"


                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            }.resume()
    
    }
    //Mark: - getting comments on photos
    func getCommentsOnPhotos(id:Int) {
        print("PostID", id)
        let urlCom = URL(string: "https://jsonplaceholder.typicode.com/photos/\(album!.id)/comments")
        URLSession.shared.dataTask(with: urlCom!) { (data, response, error) in
            if error == nil {
                do {
                    self.myComments = try JSONDecoder().decode([CommentsModel].self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.lblEmail.text = "\("No.Of Comments", self.comment?.body)"
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            }.resume()
        
    }
    
    
    }

