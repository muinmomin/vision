//
//  Pipe.swift
//  AR Portal
//
//  Created by Mike Choi on 11/18/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation

struct Pipe {
    let company : String
    let depth : Int
    let date : String
    let phone : String
    
    static let pipe1 = Pipe(company: "Brazos Valley Sewer Drain Services", depth: 10, date: "1998.03.31", phone: "979-774-1291")
    static let pipe2 = Pipe(company: "CC Electric", depth: 15, date: "1998.03.31", phone: "713-229-4123")
    static let pipeDict = ["pipe1" : pipe1, "pipe2" : pipe2]
}




