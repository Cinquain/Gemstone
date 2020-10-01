//
//  CourseDetail.swift
//  DesignCode
//
//  Created by James Allan on 9/24/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    
    var course: Course
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var body: some View {
        
        ScrollView {
            VStack {
                VStack {
                    
                    HStack(alignment: .top){
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(course.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            Text(course.subtitle)
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        ZStack {
                           
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system( size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                            }
                        }
                        
                        
                    }
                    Spacer()
                    WebImage(url: course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                .padding(show ? 30 : 20)
                .padding(.top, show ? 30 : 0)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Now that we have the basic full-screen card animation, we'll animate some new content underneath. Additionally, we'll implement a close button that will dismiss the full view")
                    
                    Text("About this City")
                        .font(.title).bold()
                    
                    Text("To follow this course, you'll need to download the source files so that you can compare your progress against mine. In the package, you'll find the design files, the final app and an Xcode project for each section of the course.")
                    
                    Text("To add animation, move the pre-existing .animation modifier to the parent stack. Also, move the edgesIgnoringSafearea modifier after .animation. Now, to solve the issue of the card taking up the whole space, change the value of maxHeight to.")
                }
                .padding(30)
                
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: courseData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
    }
}
