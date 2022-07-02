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

struct iPadContentView: View {
    @State var tutorialAlreadySeen: Bool
    
    init(tutorialToSee: Bool) {
        if (!tutorialToSee) {
            self.tutorialAlreadySeen = PreferenceManager.shared.getTutorialAlreadySeen();
        } else {
            self.tutorialAlreadySeen = !tutorialToSee
        }
    }
    
    var body: some View {
        if (tutorialAlreadySeen) {
            iPadMainView()
        } else {
            TutorialView($tutorialAlreadySeen)
        }
    }
}

struct iPadContentView_Previews: PreviewProvider {
    static var previews: some View {
        iPadContentView(tutorialToSee: false).environmentObject(AppState.shared)
    }
}

