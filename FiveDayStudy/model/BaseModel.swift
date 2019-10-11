//
//  BaseModel.swift
//  FiveDayStudy
//
//  Created by le tong on 2019/10/10.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    let name: String
    let group: String
    let date: String
    init(name: String, group: String, date: String) {
        self.name = name
        self.group = group
        self.date = date
    }
}

class CurrentModel: NSObject {
    var Array: [BaseModel] = []
    override init() {
        Array = [BaseModel.init(name: "chatroom_cover_page_1", group: "风景", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_2", group: "人物", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_3", group: "美食", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_4", group: "宠物", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_5", group: "风景", date: "2019-10-3"),
                 BaseModel.init(name: "chatroom_cover_page_6", group: "风景", date: "2019-10-3"),
                 BaseModel.init(name: "chatroom_cover_page_7", group: "人物", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_8", group: "人物", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_9", group: "风景", date: "2019-10-2"),
                 BaseModel.init(name: "chatroom_cover_page_10", group: "风景", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_11", group: "美食", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_12", group: "美食", date: "2019-10-1"),
                 BaseModel.init(name: "chatroom_cover_page_13", group: "美食", date: "2019-10-1"),
        ]
    }
}
