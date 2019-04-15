//
//  StateEnumeration.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/15/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import Foundation
enum State {
    case unlock
    case lockDown
    case letCatsInOnly
    case letCatsOutOnly
    
    func toString() ->String {
    var output = ""
        if self == State.unlock {
            output = "Unlock"
        } else if self == State.lockDown {
            output = "Lock Down"
        } else if self == State.letCatsInOnly {
            output = "Let Cats In Only"
        } else {
            output = "Let Cats Out Only"
        }
        return output
    }
}
