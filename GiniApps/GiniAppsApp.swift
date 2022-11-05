//
//  GiniAppsApp.swift
//  GiniApps
//
//  Created by Aviram on 2/11/22.
//

import SwiftUI

@main
struct GiniAppsApp: App {

    var body: some Scene {

        WindowGroup {
            ImagesTableView(model: ImagesTableViewModel())
        }
    }
}



    


