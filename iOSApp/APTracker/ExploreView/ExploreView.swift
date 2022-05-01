//
//  ExploreView.swift
//  APTracker
//
//  Created by Matteo Visotto on 01/05/22.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel: ExploreViewModel = ExploreViewModel()
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea(.all)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
