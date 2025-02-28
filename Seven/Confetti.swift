//
//  Confetti.swift
//  Seven
//
//  Created by HPro2 on 2/20/25.
//

import UIKit

class Confetti: UIView {
    var spawner: CAEmitterLayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopConfetti() {
        spawner.birthRate = 0 
    }
    
    func startConfetti() {
        spawner = CAEmitterLayer()
        spawner.emitterPosition = CGPoint(x: frame.width / 2.0, y: 0)
        spawner.emitterSize = CGSize(width: frame.width, height: 1.0)
        spawner.emitterShape = .line
        var cells = [CAEmitterCell]()
        cells.append(makeConfetti(color: .red, image: UIImage(named: "confetti")!))
        cells.append(makeConfetti(color: .green, image: UIImage(named: "confetti")!))
        cells.append(makeConfetti(color: .yellow, image: UIImage(named: "confetti")!))
        cells.append(makeConfetti(color: .blue, image: UIImage(named: "confetti")!))
        cells.append(makeConfetti(color: .systemPink, image: UIImage(named: "confetti")!))
        cells.append(makeConfetti(color: .purple, image: UIImage(named: "confetti")!))
        cells.append(makeConfetti(color: .red, image: UIImage(named: "diamond")!))
        cells.append(makeConfetti(color: .green, image: UIImage(named: "diamond")!))
        cells.append(makeConfetti(color: .yellow, image: UIImage(named: "diamond")!))
        cells.append(makeConfetti(color: .blue, image: UIImage(named: "diamond")!))
        cells.append(makeConfetti(color: .systemPink, image: UIImage(named: "diamond")!))
        cells.append(makeConfetti(color: .purple, image: UIImage(named: "diamond")!))
        cells.append(makeConfetti(color: .red, image: UIImage(named: "oval")!))
        cells.append(makeConfetti(color: .green, image: UIImage(named: "oval")!))
        cells.append(makeConfetti(color: .yellow, image: UIImage(named: "oval")!))
        cells.append(makeConfetti(color: .blue, image: UIImage(named: "oval")!))
        cells.append(makeConfetti(color: .systemPink, image: UIImage(named: "oval")!))
        cells.append(makeConfetti(color: .purple, image: UIImage(named: "oval")!))
        cells.append(makeConfetti(color: .red, image: UIImage(named: "star")!))
        cells.append(makeConfetti(color: .green, image: UIImage(named: "star")!))
        cells.append(makeConfetti(color: .yellow, image: UIImage(named: "star")!))
        cells.append(makeConfetti(color: .blue, image: UIImage(named: "star")!))
        cells.append(makeConfetti(color: .systemPink, image: UIImage(named: "star")!))
        cells.append(makeConfetti(color: .purple, image: UIImage(named: "star")!))
        cells.append(makeConfetti(color: .red, image: UIImage(named: "triangle")!))
        cells.append(makeConfetti(color: .green, image: UIImage(named: "triangle")!))
        cells.append(makeConfetti(color: .yellow, image: UIImage(named: "triangle")!))
        cells.append(makeConfetti(color: .blue, image: UIImage(named: "triangle")!))
        cells.append(makeConfetti(color: .systemPink, image: UIImage(named: "triangle")!))
        cells.append(makeConfetti(color: .purple, image: UIImage(named: "triangle")!))
        spawner.emitterCells = cells
        layer.addSublayer(spawner)
    }
    
    func makeConfetti(color: UIColor, image: UIImage) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        confetti.contents = image.cgImage
        confetti.birthRate = 4.0
        confetti.lifetime = 10.0
        confetti.lifetimeRange = 0.42
        confetti.color = color.cgColor
        confetti.velocity = 200
        confetti.velocityRange = 42
        confetti.spin = 0.42
        confetti.spinRange = 0.42
        confetti.scale = 0.65
        confetti.scaleSpeed = -0.042
        confetti.emissionRange = CGFloat.pi
        confetti.emissionLongitude = CGFloat.pi
        return confetti
    }
}
