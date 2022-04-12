//
//  ContentView.swift
//  APTracker
//
//  Created by Matteo Visotto on 04/04/22.
//

import SwiftUI
import FacebookCore
import FacebookLogin
import GoogleSignIn

struct ContentView: View {
    @State var tutorialAlreadySeen: Bool = PreferenceManager.shared.getTutorialAlreadySeen();
    
    var body: some View {
        if (tutorialAlreadySeen) {
            MainView()
        } else {
            TutorialView($tutorialAlreadySeen)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppState.shared)
    }
}
