//
//  PhotosModel.swift
//  ProjectMultiAPI0024
//
//  Created by macbook on 09/02/22.
//  Copyright © 2022 sudza. All rights reserved.
//

import Foundation
struct PhotosModel:Codable {
    var albumId:Int = 0
    var id:Int = 0
    var title:String = ""
    var url:String = ""
    var thumbnailUrl:String = ""
    
}
struct AlbumModel:Codable {
    var userId:Int = 0
    var id:Int = 0
    var title:String = ""    
}
