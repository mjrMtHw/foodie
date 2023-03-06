//
//  StarView.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI

class StarViewVM: ObservableObject {
    
    @Published var starRating: Double
    init(starRating: Double) {
        self.starRating = starRating
    }
}

struct StarView: View {
    
    @ObservedObject var model: StarViewVM
    
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 80.0, height: 80.0)
            Text(model.starRating.limit1SigFig() ?? "n/a")
                .foregroundColor(.yellow)
        }
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView(model: StarViewVM(starRating: Double(5)))
    }
}
