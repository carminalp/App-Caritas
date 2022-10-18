//
//  voluntariosManager.swift
//  appCaritasMty
//
//  Created by Geraldine Torres on 14/10/22.
//

import UIKit


struct voluntariosManager{
    
    /*
     
     Autora: GERALDINE TORRES
     
     Esta función lo que hace es traer a todos los voluntarios registrados en la base de datos.
     
     :condiciones: Para que la funcione, es importante que
            * Si hay datos, entonces guarda todos los datos de tipo horasValidadasVoluntario en el arreglo listVoluntarios.
     
            * Si no hay datos, entonces imprime "error".
     
     :param: un arreglo de tipo horasValidadasVoluntario
     
     :returns: @escaping closure que regresa el arreglo de listVoluntarios
     
     
     */
    
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
    
    func getNombresVoluntarios() -> [String] {
        var nombresVoluntarios = [String] ()
        var listVoluntarios = [horasValidadasVoluntario]()

        guard let url = URL(string: "https://equipo02.tc2007b.tec.mx:10210/admin/horasVal") else {
            return []
        }

        let group = DispatchGroup()
        group.enter()

        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil || data == nil {

                print("error")
            }
            else{
                if let responseText = String.init(data: data!, encoding: .ascii){
                    let decoder = JSONDecoder()
                    let jsonData = responseText.data(using: .utf8)!

                    listVoluntarios = try! decoder.decode([horasValidadasVoluntario].self, from: jsonData)

                    if(!listVoluntarios.isEmpty){
                        listVoluntarios.forEach{ i in
                            nombresVoluntarios.append(i.Nombre)
                        }
                    }
                }
            }
        })

        task.resume()

        return nombresVoluntarios
    }


    
}
