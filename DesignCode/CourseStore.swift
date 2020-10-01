//
//  CourseStore.swift
//  DesignCode
//
//  Created by James Allan on 9/26/20.
//

import SwiftUI
import Contentful
import Combine

let spaceID = "bdieecma94rk"
let accessToken = "5ojoBUFxJm1SwgLmdHCVFv3vyyAz_bOH5c24kWBsY9s"
let client = Client(spaceId: spaceID, accessToken: accessToken)


func getArray(id: String, completion: @escaping ([Entry]) -> ()) {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}


class CourseStore: ObservableObject {
    
    @Published var courses: [Course] = courseData
    
    init() {
        let colors = [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
        getArray(id: "course") { (items) in
            
            items.forEach { (item) in
                self.courses.append(Course(
                                        title: item.fields["title"] as! String,
                                        subtitle: item.fields["subtitle"] as! String,
                                        image: (item.fields.linkedAsset(at: "image")?.url ?? URL(string: ""))!,
                                        logo: #imageLiteral(resourceName: "Logo1"),
                                        color: colors.randomElement()!,
                                        show: false))
                
            }
            
        }
    }
    
}
