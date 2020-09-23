//
//  CourseList.swift
//  DesignCode
//
//  Created by James Allan on 9/22/20.
//

import SwiftUI

struct CourseList: View {
    
    @State var show = false
    @State var show2 = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 30) {
                CourseView(show: $show)
                GeometryReader { geo in
                    CourseView(show: $show2)
                        .offset(y: self.show2 ? -geo.frame(in: .global).minY : 0)
                }
                .frame(height: show2 ? screen.height : 280)
                .frame(width: show2 ? .infinity : screen.width - 60)
            }
            .frame(width: screen.width)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    
    @Binding var show: Bool

    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Now that we have the basic full-screen card animation, we'll animate some new content underneath. Additionally, we'll implement a close button that will dismiss the full view")
                
                Text("About this City")
                    .font(.title).bold()
                
                Text("To follow this course, you'll need to download the source files so that you can compare your progress against mine. In the package, you'll find the design files, the final app and an Xcode project for each section of the course.")
                
                Text("To add animation, move the pre-existing .animation modifier to the parent stack. Also, move the edgesIgnoringSafearea modifier after .animation. Now, to solve the issue of the card taking up the whole space, change the value of maxHeight to.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                
                HStack(alignment: .top){
                    
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("SwiftUI Advanced")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text("20 Sections")
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: #imageLiteral(resourceName: "Logo1"))
                            .opacity(show ? 0 : 1)
                        
                        Image(systemName: "xmark")
                            .font(.system( size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.black)
                    .clipShape(Circle())
                    .opacity(show ? 1 : 0)
                    
                }
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "Card5"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.show.toggle()
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)


    }
}
