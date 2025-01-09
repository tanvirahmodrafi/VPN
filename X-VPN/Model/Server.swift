//
//  Servers.swift
//  X-VPN
//
//  Created by Tanvir on 30/11/2024.
//

import SwiftUI

struct Server: Identifiable {
    let id = UUID().uuidString
    let name: String
    let flag: String
    
}
var servers = [
    Server(name: "United States", flag: "us"),
    Server(name: "Singapore", flag: "sg"),
    Server(name: "India", flag: "in"),
    Server(name: "Bangladesh", flag: "bd"),
    Server(name: "China", flag: "cn"),
    Server(name: "Russia", flag: "ru"),
    Server(name: "Japan", flag: "jp"),
    
]
