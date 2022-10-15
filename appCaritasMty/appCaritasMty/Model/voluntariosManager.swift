//
//  voluntariosManager.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 14/10/22.
//

import UIKit

struct voluntariosManager{
    
    func fetchVoluntarios(completionHandler:@escaping ([horasValidadasVoluntario]) -> Void){
        
        var listVoluntarios = [horasValidadasVoluntario]()
        
        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin/horasVal") else {return}
        
        let group = DispatchGroup()
        group.enter()
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil || data == nil {
                print("error")
            }
            else{
                if let responseText = String.init(data: data!, encoding: .ascii){
                    let jsonData = responseText.data(using: .utf8)!
                    listVoluntarios = try! JSONDecoder().decode([horasValidadasVoluntario].self, from: jsonData)
                    completionHandler(listVoluntarios)
                }
            }
        })
        
        task.resume()
    }
    



    
}
