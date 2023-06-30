//
//  ViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 22/06/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabs()
    }
    
    func setTabs() {
        let charactersStoryboard = UIStoryboard(name: "Characters", bundle: nil)
        let charactersVC = charactersStoryboard.instantiateViewController(withIdentifier: "CharactersNavigation")
        
        let locationsStoryboard = UIStoryboard(name: "Locations", bundle: nil)
        let locationsVC = locationsStoryboard.instantiateViewController(withIdentifier: "LocationsNavigation")
        
        let episodesStoryboard = UIStoryboard(name: "Episodes", bundle: nil)
        let episodesVC = episodesStoryboard.instantiateViewController(withIdentifier: "EpisodesNavigation")
        
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsVC = settingsStoryboard.instantiateViewController(withIdentifier: "SettingsNavigation")
        
        setViewControllers([charactersVC, locationsVC, episodesVC, settingsVC], animated: true)
    }

}

