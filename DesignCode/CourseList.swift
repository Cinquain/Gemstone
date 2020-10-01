//
//  CourseList.swift
//  DesignCode
//
//  Created by James Allan on 9/22/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(Double(activeView.height / 500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
               
            }
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("Secret Spots")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(store.courses.indices, id: \.self) { index in
                        GeometryReader { geo in
                            CourseView(
                                show: $store.courses[index].show,
                                course: self.store.courses[index],
                                active: $active, index: index,
                                activeIndex: $activeIndex, activeView: $activeView
                            )
                            .offset(y: self.store.courses[index].show ? -geo.frame(in: .global).minY : 0)
                            .opacity(self.activeIndex != index && self.active ? 0 : 1)
                            .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                            .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(width: self.store.courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.store.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .statusBar(hidden: active ? true : false)
                .animation(.linear)
            }
        }
    }


struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CourseList()
        }
    }
}

struct CourseView: View {
    
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    

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
            .background(Color("background2"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
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
                        Image(uiImage: course.logo)
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
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(
                show ?
                DragGesture().onChanged { value in
                    guard value.translation.height < 300 else {return}
                    guard value.translation.height > 0 else {return}
                    
                        self.activeView = value.translation
                    
                }
                .onEnded { value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                    }
                    self.activeView = .zero
                }
                : nil
            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            
            if show {
//                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex)
//                    .background(Color.white)
//                    .animation(nil)
            }
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(
            Angle(degrees: Double(self.activeView.height / 10)),
            axis: (x: 0, y: 10, z: 0)
        )
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ?
            DragGesture().onChanged { value in
                guard value.translation.height < 300 else {return}
                guard value.translation.height > 0 else {return}
                
                    self.activeView = value.translation
                
            }
            .onEnded { value in
                if self.activeView.height > 50 {
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                }
                self.activeView = .zero
            }
            : nil
        )
        .edgesIgnoringSafeArea(.all)


    }
}



struct Course: Identifiable {
    
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "The Magic Garden", subtitle: "Philly", image: URL(string: "https://drive.google.com/file/d/1icMVh5jOxuO2OSVgiKMFCzZadE5tpZa_/view?usp=sharing")!, logo: #imageLiteral(resourceName: "Card5"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "The Ideal Palace", subtitle: "Philly", image: URL(string: "https://drive.google.com/file/d/0B2j-KZb_V-zNMEZ4LVdEdng4MFU/view?usp=sharing")!, logo: #imageLiteral(resourceName: "Card5"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "Graffi Pier", subtitle: "Philly", image: URL(string: "https://drive.google.com/file/d/1agoBmcBawesAra1M8OEIOlmXRuIVks5i/view?usp=sharing")!, logo: #imageLiteral(resourceName: "Card5"), color: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), show: false),Course(title: "The Magic Garden", subtitle: "Philly", image: URL(string: "https://drive.google.com/file/d/0B2j-KZb_V-zNWHdzZ0VtckVMVkk/view?usp=sharing")!, logo: #imageLiteral(resourceName: "Card5"), color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), show: false)
]

