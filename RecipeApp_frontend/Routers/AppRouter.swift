//
//  AppRouter.swift
//  RoutersDemo
//
//  Created by Itay Amzaleg on 10/03/2024.
//

import Foundation
import Observation


@Observable class AppRouter {
    //MARK: - App states
    var presentedSheet: PresentedSheet?
    var selectedTab: MainTabView.Tab = .a
    
    //MARK: - Routers
    var homeRouter = HomeRouter()
    var recipesRouter = RecipesRouter()
    var planRouter = PlanRouter()
    var settingRouter = SettingRouter()
}
