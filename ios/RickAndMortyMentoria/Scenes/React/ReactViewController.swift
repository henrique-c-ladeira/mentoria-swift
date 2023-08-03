//
//  ReactViewController.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 02/08/23.
//

import UIKit
import React


class ReactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
          let mockData:NSDictionary = ["scores":
              [
                  ["name":"Alex", "value":"42"],
                  ["name":"Joel", "value":"10"]
              ]
          ]

          let rootView = RCTRootView(
              bundleURL: jsCodeLocation,
              moduleName: "RNHighScores",
              initialProperties: mockData as [NSObject : AnyObject],
              launchOptions: nil
          )
          view = rootView
    }
}
