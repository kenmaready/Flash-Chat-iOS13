//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Ken Maready on 7/6/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation

struct K {
    static let Title = "⚡️FlashChat"

    struct Segues {
        static let RegisterToChat = "RegisterToChat"
        static let LoginToChat = "LoginToChat"
    }
    
    struct Cells {
        static let Identifier = "ReusableCell"
        static let NibName = "MessageCell"
    }
    
    struct BrandColors {
        static let Purple = "BrandPurple"
        static let LightPurple = "BrandLightPurple"
        static let Blue = "BrandBlue"
        static let LightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let CollectionName = "messages"
        static let SenderField = "sender"
        static let BodyField = "body"
        static let DateField = "date"
    }
}
