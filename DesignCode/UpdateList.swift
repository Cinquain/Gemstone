//
//  UpdateList.swift
//  DesignCode
//
//  Created by James Allan on 9/20/20.
//

import SwiftUI

struct UpdateList: View {
    var body: some View {
        
        NavigationView {
            List(updateData) { update in
                NavigationLink(destination: UpdateDetail(update: update)) {
                    
                    HStack {
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing, 4)
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(update.text)
                                .lineLimit(2)
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            
                            Text(update.date)
                                .lineLimit(2)
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        }
                    }
                    .padding(.vertical, 8)
                    
                }
            }
            .navigationBarTitle(Text("Updates"))
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}


struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}


let updateData = [
    Update(image: "Card1", title: "Wesley", text: "Gemone", date: "Jan 1"),
    Update(image: "Card2", title: "Famous", text: "Precious", date: "Dec 1"),
    Update(image: "Card3", title: "Engineering", text: "Ambitious", date: "Feb 1"),
    Update(image: "Card4", title: "Foreman", text: "Fire", date: "June 1"),
    Update(image: "Card5", title: "Playground", text: "Easy going", date: "Oct 1")
]


