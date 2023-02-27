//
//  StarView.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI

struct StarView: View {
    
    @State var starRating: Double = 0.0
    
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 80.0, height: 80.0)
            Text(starRating.limit1SigFig() ?? "n/a")
                .foregroundColor(.yellow)
        }
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView()
    }
}
