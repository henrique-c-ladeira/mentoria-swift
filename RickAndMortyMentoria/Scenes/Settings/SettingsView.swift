//
//  SettingsView.swift
//  RickAndMortyMentoria
//
//  Created by Henrique Ladeira on 01/02/24.
//

import SwiftUI

struct SettingsView: View {
    let options: [SettingsOption] = [
        SettingsOption(title: "Rate App", image: "star.fill", backgroundColor: .blue),
        SettingsOption(title: "Contact Us", image:  "paperplane", backgroundColor: .green),
        SettingsOption(title: "Terms of Service", image: "doc", backgroundColor: .red),
        SettingsOption(title: "Privacy Policy", image: "lock", backgroundColor: .yellow),
        SettingsOption(title: "API Reference", image: "list.clipboard", backgroundColor: .orange),
        SettingsOption(title: "View App Code", image: "hammer.fill", backgroundColor: .pink),
    ]
    
    var body: some View {
        List(options) { option in
            HStack {
                Image(systemName: option.image)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .background(option.backgroundColor)
                    .cornerRadius(8)
                                
                Text(option.title)
                    .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.bottom, 3)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        return SettingsView()
    }
}
