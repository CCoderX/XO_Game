//
//  ViewController.swift
//  XO_Game
//
//  Created by Mohamed Taher on 7/1/19.
//  Copyright © 2019 Mohamed Taher. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var gameLabel: UILabel!
    var indeces = [["-","-","-"],["-","-","-"],["-","-","-"]]
    var x_play = true
    var gameOver = false
    var gamesPlayed = 0
    @IBOutlet weak var gameTable: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func checkWin()->String{
        for i in indeces{
            if (i[0] == i[1] )&&(i[1] == i[2])&&(i[0] != "-"){//horizontal win
                gameOver = true
                return i[0] + " Win !"
            }
        }
        for i in 0...2{
            if (indeces[0][i] == indeces [1][i]) && (indeces[1][i] == indeces [2][i])&&(indeces [2][i] != "-"){
                gameOver = true
                return indeces[0][i] + " Win !"
            }
        }
        if ((indeces[0][0] == indeces[1][1]) && (indeces[1][1] == indeces[2][2])) || ((indeces[0][2] == indeces[1][1]) && indeces[1][1] == indeces [2][0]){
            if (indeces [1][1] != "-"){
                gameOver = true
                return indeces[1][1] + " Win !"
            }
        }
        return "Draw"
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.signLabel.text = self.indeces[Int(indexPath.row / 3)][indexPath.row % 3]
        if cell.signLabel.text == "X"{
            cell.backgroundColor = .green
        }
        else if cell.signLabel.text == "Y"{
            cell.backgroundColor = UIColor.red
        }
        else{
            cell.backgroundColor = UIColor.cyan
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8 // optional
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if gameOver{
            return
        }
        if indeces[Int(indexPath.row / 3)][indexPath.row % 3] != "-"{
            return
        }
        if x_play{
            indeces[Int(indexPath.row / 3)][indexPath.row % 3] = "X"
            gameLabel.text = "Y_Game"
        }
        else{
            indeces[Int(indexPath.row / 3)][indexPath.row % 3] = "Y"
            gameLabel.text = "X_Game"
        }
        checkWin()
        gamesPlayed += 1
        x_play = !x_play
        if gameOver || gamesPlayed == 9{
            gameLabel.text = "Game Over " + checkWin()
            //indeces = [["-","-","-"],["-","-","-"],["-","-","-"]]
            x_play = true
        }
        gameTable.reloadData()
      
    }
    @IBAction func reset(_ sender: Any) {
        gamesPlayed = 0
        gameOver = false
        gameLabel.text = "X_Game"
        indeces = [["-","-","-"],["-","-","-"],["-","-","-"]]
        gameTable.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: gameTable.frame.width/3.5, height: gameTable.frame.height/3.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

