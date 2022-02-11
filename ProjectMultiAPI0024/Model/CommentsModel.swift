//
//  CommentsModel.swift
//  ProjectMultiAPI0024
//
//  Created by macbook on 10/02/22.
//  Copyright © 2022 sudza. All rights reserved.
//

import Foundation
struct CommentsModel: Decodable {
    let postId, id: Int
    let name, email, body: String
    
}
