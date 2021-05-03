//
//  HomeView.swift
//  Giftstory
//
//  Created by Khalid Asad on 2021-05-02.
//

import SwiftUI

struct HomeView: View {
    
    @State var show = false
    
    var body: some View {
        NavigationView {
            LoginView(viewModel: .init())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
