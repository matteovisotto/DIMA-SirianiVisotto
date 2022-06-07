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
    @State var tutorialAlreadySeen: Bool = PreferenceManager.shared.getTutorialAlreadySeen();
    
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
        iPadContentView().environmentObject(AppState.shared)
    }
}

