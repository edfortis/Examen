//
//  ViewControllerLiverpool.swift
//  Liverpool
//
//  Created by Eduardo Loyo Martinez on 1/3/19.
//  Copyright © 2019 Eduardo Loyo Martinez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewControllerLiverpool: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var total = 0
    var listaTodosProductos :JSON = JSON();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.listaTodosProductos = nil
        var url = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp?search-string=" + searchBar.text! + "&page-number=1"
        
        Alamofire.request(url).responseJSON{ (response) in
            switch response.result{
            case .success(let value) :
                self.listaTodosProductos = JSON(value)
                self.tableView.reloadData()
            case .failure(let error) :
                print(error)
            }
        }
        //print(listaTodosProductos)
        //lista productos
        
        
        print(self.listaTodosProductos["plpResults"]["records"][0]["productDisplayName"])
        //numero de resultados
       print(self.listaTodosProductos["plpResults"]["records"][0]["smImage"])
        
        print(listaTodosProductos["plpResults"]["records"].count)
        //print(listaTodosProductos)
        print(self.listaTodosProductos["plpResults"]["records"][0]["promoPrice"])
    }
    
    
    
}
extension UIImageView {
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode)
    }
}

extension ViewControllerLiverpool: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTodosProductos["plpResults"]["records"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProductoCell = tableView.dequeueReusableCell(withIdentifier: "celda") as! ProductoCell;

        cell.titulo.text = listaTodosProductos["plpResults"]["records"][indexPath.row]["productDisplayName"].string!
        cell.imagen.dowloadFromServer(link: self.listaTodosProductos["plpResults"]["records"][indexPath.row]["smImage"].string!)
        if let precio = self.listaTodosProductos["plpResults"]["records"][indexPath.row]["listPrice"].double{
           cell.precio.text = "$"+String(precio)
        }
        if let descuento = self.listaTodosProductos["plpResults"]["records"][indexPath.row]["promoPrice"].double{
            cell.descuento.text = "$"+String(descuento)
        }
        return cell
    }
    
    
    
    
}

