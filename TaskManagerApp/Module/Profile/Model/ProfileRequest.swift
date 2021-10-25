//
//  ProfileRequest.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 11/10/21.
//

import Foundation

struct ProfileRequest: Encodable {
  let fullName: String
  let phone: String
  let birthday: String
  let gender: Int
  
  enum CodingKeys: String, CodingKey {
    case fullName = "name"
    case phone
    case birthday
    case gender
  }
}
