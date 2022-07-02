//
//  ViewController.swift
//  Catch the Kenny
//
//  Created by Macbook Pro on 1.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var hideTimer = Timer()
    
    var score = 0
    var counter = 5
    var hakanArray=[UIImageView()] //görselleri dizi içerisine alabilmek için bi dizi tanımladık.
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var hakan: UIImageView!
    @IBOutlet weak var hakan2: UIImageView!
    @IBOutlet weak var hakan3: UIImageView!
    @IBOutlet weak var hakan4: UIImageView!
    @IBOutlet weak var hakan5: UIImageView!
    @IBOutlet weak var hakan6: UIImageView!
    @IBOutlet weak var hakan7: UIImageView!
    @IBOutlet weak var hakan8: UIImageView!
    @IBOutlet weak var hakan9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(geriyeSay), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideHakan), userInfo: nil, repeats: true)
       
      
        scoreLabel.text = String ("Score: \(scoreLabel)")
        
        //highscore check
        
        let storedHighscore = UserDefaults.standard.object(forKey: "Highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highScoreLabel.text = "Score: \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int {
            
             highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        hakan.isUserInteractionEnabled = true
        hakan2.isUserInteractionEnabled = true
        hakan3.isUserInteractionEnabled = true
        hakan4.isUserInteractionEnabled = true
        hakan5.isUserInteractionEnabled = true
        hakan6.isUserInteractionEnabled = true
        hakan7.isUserInteractionEnabled = true
        hakan8.isUserInteractionEnabled = true
        hakan9.isUserInteractionEnabled = true
        
       

        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        hakan.addGestureRecognizer(gestureRecognizer1)
        hakan2.addGestureRecognizer(gestureRecognizer2)
        hakan3.addGestureRecognizer(gestureRecognizer3)
        hakan4.addGestureRecognizer(gestureRecognizer4)
        hakan5.addGestureRecognizer(gestureRecognizer5)
        hakan6.addGestureRecognizer(gestureRecognizer6)
        hakan7.addGestureRecognizer(gestureRecognizer7)
        hakan8.addGestureRecognizer(gestureRecognizer8)
        hakan9.addGestureRecognizer(gestureRecognizer9)
        
        hakanArray=[hakan,hakan2,hakan3,hakan4,hakan5,hakan6,hakan7,hakan8,hakan9] //görselleri bi dizi içine aldık.
        
        hideHakan()

    }
    
    @objc func hideHakan(){  //görselleri gizlemek için fonksiyon yazdık
        for hkn in hakanArray{   // hakanArray dizisindeki elemanları alıp hkn adlı değişkene yazıyoruz.
            hkn.isHidden = true  //hkn adlı değişkene gelen elemanları gizledik.
           
        }
        
        let random = Int(arc4random_uniform(UInt32(hakanArray.count-1))) //arc4random hakanArray'in eleman sayısı aralığında random eleman üretir. arc4random integer döndürmediği için random değişkenine atadık ve başına int koyduk.
        hakanArray[random].isHidden = false
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = String ("Score: \(score)")

    }
    
    @objc func geriyeSay(){
        
        
       
        if counter == 1 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time is Over"
            
            for hkn in hakanArray{   // hakanArray dizisindeki elemanları alıp hkn adlı değişkene yazıyoruz.
                hkn.isHidden = true  //hkn adlı değişkene gelen elemanları gizledik.
               
            }
            
            //Highscore (yapmamız gereken kontrol: zaman bitince score'a bak highscore ile karşılaştır eğer score daha büyükse highscore ile değiştir daha küçükse hiç bişey yapma)
            
            if self.score>self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "Highscore")
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let ok_Button = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:nil)
            
            
            //counter ı sıfırlıyoruz ve timerları baştan başlatıyoruz
            let again_Button = UIAlertAction(title: "Again", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0 //neden başlarında self var? çünkü geriyeSay function içerisindeyiz, bu scope da score kullanma başına self koy ne olduğunu bileyim diyor, yani en başta tanımladığımız score'u kullanabilmek için böyle yazdık.
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.geriyeSay), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideHakan), userInfo: nil, repeats: true)
            }
            alert.addAction(ok_Button)
            alert.addAction(again_Button)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        counter -= 1
        timeLabel.text="Time: \(counter)"
        
    }
    

}

