//
//  ViewController.swift
//  firebase01
//
//  Created by Nitish Chauhan on 07/12/18.
//  Copyright © 2018 Nitish Chauhan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    var refArtist: DatabaseReference!
    
    
    @IBOutlet weak var nametxt: UITextField!
    
    
    @IBOutlet weak var genretxt: UITextField!
    @IBOutlet weak var labelmessage: UILabel!
    
    
    
    @IBOutlet weak var tblArtist: UITableView!
    
    var artistList = [Vishalsingh]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let artist = artistList[indexPath.row]
        
        let alertController = UIAlertController(title:artist.name, message: "Give new values to update artist" , preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update", style:.default){(_) in
            
            let id = artist.id
            let name = alertController.textFields?[0].text
            let genre = alertController.textFields?[1].text
            
            self.updateArtist(id: id!, name: name!, genre: genre!)
        }
        let deleteAction = UIAlertAction(title: "Delete", style:.default){(_) in
            self.deleteArtist(id: artist.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = artist.name
        }
        alertController.addTextField{(textField) in
            textField.text = artist.genre
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateArtist(id: String, name: String, genre: String){
        
        let artist = [
            "id": id,
            "artistName": name,
            "artistGenre": genre
            ]
        refArtist.child(id).setValue(artist)
        labelmessage.text = "Artist Updated"
        
        
    }
    
    func deleteArtist(id: String){
        
        refArtist.child(id).setValue(nil)
    }
public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! viewControllerTableViewCell
        
        
        let artist : Vishalsingh
        artist = artistList[indexPath.row]
        
        cell.lblname.text = artist.name
        cell.lblgenre.text = artist.genre
        
        return cell
    }
    
    
    
    @IBAction func addbtn(_ sender: UIButton) {
    addArtist()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refArtist = Database.database().reference().child("artists");
        
        refArtist.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0 {
               self.artistList.removeAll()
                
                for artists in snapshot.children.allObjects as! [DataSnapshot]{
                    let artistsObject = artists.value as? [String: AnyObject]
                    let artistName = artistsObject?["artistName"]
                    let artistGenre = artistsObject?["artistGenre"]
                    let artistId = artistsObject?["id"]
                    
                    let artist = Vishalsingh(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String?)
                    
                    self.artistList.append(artist)
                    
                }
                
                self.tblArtist.reloadData()
            }
        })
    }
    
    func addArtist() {
        let key = refArtist.childByAutoId().key
        
        let artist = ["id":key,
                      "artistName": nametxt.text! as String,
                      "artistGenre": genretxt.text! as String
        ]
            
            //updating the artist using the key of the artist
            refArtist.child(key!).setValue(artist)
            
            //displaying message
            labelmessage.text = "Artist Updated"
        }
        // Do any additional setup after loading the view, typically from a nib.





}
