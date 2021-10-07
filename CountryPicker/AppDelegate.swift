//
//  AppDelegate.swift
//  CountryPicker
//
//  Created by Sobhi Imad on 07/10/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("test commit")
        setupLanguage()
        return true
    }
    
    func setupLanguage() {
        if(LanguageManager.currentLanguageCode() == "ar")
        {
            
            LanguageManager .saveLanguage(by: 1)
            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            
            
        }else if LanguageManager.currentLanguageCode() == "he"{
            LanguageManager .saveLanguage(by: 2)
            UserDefaults.standard.set(["he"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
        else
        {
            LanguageManager .saveLanguage(by: 0)
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            UITextField.appearance().setLabelTextAlignment(Alignment: .left)
            UITextView.appearance().setLabelTextAlignment(Alignment: .left)
        }
        
        
        
        if LanguageManager.currentLanguageCode() == "ar" || LanguageManager.currentLanguageCode() == "he"{
            UIPageControl.appearance().semanticContentAttribute = .forceRightToLeft
            UIControl.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationController().view.semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationController().navigationBar.semanticContentAttribute = .forceRightToLeft
            UITabBarController().view.semanticContentAttribute  = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().setLabelTextAlignment(Alignment: .right)
            UITextView.appearance().setLabelTextAlignment(Alignment: .right)
            UISegmentedControl.appearance().semanticContentAttribute = .forceRightToLeft
            //            CosmosView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        LanguageManager.setupCurrentLanguage()
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

