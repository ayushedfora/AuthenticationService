//
//  NavigationRouter.swift
//  AuthenticationApp
//
//  Created by Ayush Pawar on 09/09/23.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    static let shared: Router = Router()
}
