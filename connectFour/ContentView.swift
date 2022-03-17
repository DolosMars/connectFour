//
//  ContentView.swift
//  connectFour
//

import SwiftUI

struct ContentView: View {
    @State var gameData = Array(repeating: 0, count: 42)//0:white 1:red 2:yellow
    @State private var state = 1 // 1:red 2:yellow
    @State private var changeState = true
    @State private var input = -1
    @State private var score = 0
    @State private var tempInput = -1
    @State private var rangeUp = -1
    @State private var rangeDown = -1
    @State private var redRemaining = 21
    @State private var yellowRemaining = 21
    @State private var setDisable = false
    @State private var redWin = false
    @State private var yellowWin = false
    @State private var redScore = 0
    @State private var yellowScore = 0
    @State private var draw = false
    
    //can put the chess
    func check(i:Int)
    {
        if(gameData[i+35] == 0)
        {
            input = i+35
            changeState = true
        }
        else if (gameData[i+28] == 0)
        {
            input = i+28
            changeState = true
        }
        else if (gameData[i+21] == 0)
        {
            input = i+21
            changeState = true
        }
        else if (gameData[i+14] == 0)
        {
            input = i+14
            changeState = true
        }
        else if(gameData[i+7] == 0)
        {
            input = i+7
            changeState = true
        }
        else if(gameData[i] == 0)
        {
            input = i
            changeState = true
        }
        else{
            print("You can't do that!")
            input = -1
            changeState = false
        }
        
        if (changeState){
            
            if (state == 1){
                gameData[input] = 1
                redRemaining -= 1
            }else if (state == 2){
                gameData[input] = 2
                yellowRemaining -= 1
            }
            checkHorizontal(input: input)
            checkVertical(input: input)
            checkRightSlash(input: input)
            checkLeftSlash(input: input)
            
            if (state == 1){
                state = 2
            }else if(state == 2){
                state = 1
            }
            
            if (redRemaining == 0 && yellowRemaining == 0)
            {
                draw = true
            }
            
        }
        
        
    }
    
    func checkHorizontal(input:Int) {
        score = 0
        tempInput = input
        rangeDown = tempInput
        rangeUp = tempInput
        
        if (tempInput < 41 && tempInput > 0){
            
            while(gameData[tempInput] == gameData[tempInput+1])
            {
                score += 1
                tempInput += 1
                rangeDown += 1
                if (tempInput >= 41 || tempInput % 7 == 6)
                {
                    break
                }
            }
            
            tempInput = input
            
            while(gameData[tempInput] == gameData[tempInput-1]){
                score += 1
                tempInput -= 1
                rangeUp -= 1
                if (tempInput <= 0 || tempInput % 7 == 0)
                {
                    break
                }
            }
            
            
        }else if (tempInput == 0)
        {
            for i in 0...2
            {
                if(gameData[i] == gameData[i+1])
                {
                    score += 1
                }
            }
            rangeUp = 0
            rangeDown = 3
            
        }else if(tempInput == 41){
            for i in 38...40{
                if(gameData[i] == gameData[i+1])
                {
                    score += 1
                }
            }
            rangeUp = 38
            rangeDown = 41
        }
        if (score >= 3)
        {
            for i in rangeUp...rangeDown{
                gameData[i] = 3
            }
            setDisable = true
            whoIsWinner()
        }
    }
    
    func checkVertical(input:Int) {
        
        score = 0
        tempInput = input
        rangeUp = tempInput
        rangeDown = tempInput
        
        if (tempInput < 35){
            while(gameData[tempInput] == gameData[tempInput+7])
            {
                score += 1
                tempInput += 7
                rangeDown += 7
                if (tempInput >= 35)
                {
                    break
                }
            }
        }else{
            rangeDown = tempInput
        }
        
        tempInput = input
        if (tempInput > 6){
            while(gameData[tempInput] == gameData[tempInput-7]){
                score += 1
                tempInput -= 7
                rangeUp -= 7
                if (tempInput <= 6)
                {
                    break
                }
            }
        }else{
            rangeUp = tempInput
        }
        if (score >= 3)
        {
            for i in stride(from: rangeUp, to: rangeDown+1, by: 7) {
                gameData[i] = 3
            }
            setDisable = true
            whoIsWinner()
        }
    }
    
    fileprivate func whoIsWinner() {
        if (state == 1){
            redWin = true
            redScore += 1
        }else if(state == 2){
            yellowWin = true
            yellowScore += 1
        }
    }
    
    func checkRightSlash(input:Int) {
        score = 0
        tempInput = input
        
        rangeDown = tempInput
        if (tempInput < 35){
            while(gameData[tempInput] == gameData[tempInput+6]){
                score += 1
                tempInput += 6
                rangeUp += 6
                if (tempInput % 7 == 0 || tempInput >= 35)
                {
                    break
                }
            }
        }
        if (score >= 3)
        {
            for i in stride(from: rangeDown, to: rangeUp+1, by: 6) {
                gameData[i] = 3
            }
            
            setDisable = true
            
            whoIsWinner()
        }
    }
    
    func checkLeftSlash(input:Int) {
        score = 0
        tempInput = input
        
        rangeDown = tempInput
        if (tempInput < 33){
            while(gameData[tempInput] == gameData[tempInput+8]){
                score += 1
                tempInput += 8
                rangeUp += 8
                if (tempInput % 7 == 6 || tempInput >= 33)
                {
                    break
                }
            }
        }
        if (score >= 3)
        {
            for i in stride(from: rangeDown, to: rangeUp+1, by: 8) {
                gameData[i] = 3
            }
            setDisable = true
            whoIsWinner()
        }
    }
    var body: some View {
        ZStack{
            ZStack{
                upView()
                
                //redRemaining
                Text("\(redRemaining)")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x:-44,y:-215)
                    .foregroundColor(.white)
                
                //yellowRemaining
                Text("\(yellowRemaining)")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x:44,y:-215)
                    .foregroundColor(.white)
                
                //Score
                Text("\(redScore)  :  \(yellowScore)")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(y:-270)
                
                //WhosTurnColor
                Circle()
                    .foregroundColor( redRemaining==yellowRemaining ? .red: .yellow )
                    .frame(width: 50, height: 50)
                    .offset(y:220)
                
                //RestartButton
                Button {
                    gameData = Array(repeating: 0, count: 42)
                    redRemaining = 21
                    yellowRemaining = 21
                    state = 1
                    setDisable = false
                    redWin = false
                    yellowWin = false
                    redScore = 0
                    yellowScore = 0
                    draw = false
                    
                } label:{
                    VStack{
                        Text("Restart")
                            .foregroundColor(.black)
                        
                        Image(systemName: "gobackward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                        
                    }
                }.offset(x:-100,y:205)
                
                //NextRroundButton
                Button{
                    gameData = Array(repeating: 0, count: 42)
                    redRemaining = 21
                    yellowRemaining = 21
                    state = 1
                    setDisable = false
                    redWin = false
                    yellowWin = false
                    draw = false
                    
                } label:{
                    VStack{
                        HStack{
                            Text("Next")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                        Text("Round")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                        
                        
                        Image(systemName: "chevron.forward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                        
                    }
                    
                }.offset(x:100,y:197)
                
                Group{
                    
                    //redWin
                    Text("Win")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .offset(x:-110,y:-238)
                        .font(.system(size: 20))
                        .opacity( redWin ? 1 : 0 )
                    
                    //yellowWin
                    Text("Win")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .offset(x:110,y:-238)
                        .font(.system(size: 20))
                        .opacity( yellowWin ? 1 : 0 )
                    
                    //DrawTextLeftTop
                    Text("Draw")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .offset(x:-110,y:-238)
                        .font(.system(size: 20))
                        .opacity( draw ? 1 : 0 )
                    
                    //DrawTextRightTop
                    Text("Draw")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .offset(x:110,y:-238)
                        .font(.system(size: 20))
                        .opacity( draw ? 1 : 0 )
                    
                    
                }
                
            }
            
            //chessBoardBlue
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 270, height: 240)
                .foregroundColor(.blue)
                .opacity(0.9)
                .offset(y:10)
            
            
            HStack{
                ForEach(0 ..< 7){i in
                    VStack{
                        //putUrChessButton
                        Button {
                            check(i: i)
                        } label:{
                            
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundColor(.black)
                                .opacity(1)
                                .offset(y:-15)
                            
                        }.disabled(setDisable ? true : false)
                        
                        ForEach(0 ..< 6){ j in
                            if (gameData[7*j+i] == 0)
                            {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 30)
                            }
                            else if(gameData[7*j+i] == 1)
                            {
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                            }
                            else if (gameData[7*j+i] == 2)
                            {
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 30, height: 30)
                            }
                            else if (gameData[7*j+i] == 3)
                            {
                                //winnerColor
                                Circle()
                                    .foregroundColor(redRemaining==yellowRemaining ?.yellow : .red)
                                    .frame(width: 30, height: 30)
                                    .opacity(0.5)
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct upView: View {
    var body: some View {
        
        Group{
            
            //topRightBlack
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 165, height: 150)
                .offset(x:90,y:-230)
            
            //topLeftBlack
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 165, height: 150)
                .offset(x:-90,y:-230)
            
            //player2 PlaceWhite
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .frame(width: 130, height: 30)
                .offset(x:90,y:-177)
            
            //player1 PlaceWhite
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .frame(width: 130, height: 30)
                .offset(x:-90,y:-177)
        }
        
        
        Group{
            //Player1Text
            Text("Player 1")
                .fontWeight(.bold)
                .offset(x:-90,y:-177)
            
            //Player2Text
            Text("Player 2")
                .fontWeight(.bold)
                .offset(x:90,y:-177)
        }
        
        
        Group{
            
            //topLeftCircleRed
            Circle()
                .foregroundColor(.red)
                .frame(width: 80, height: 80)
                .offset(x:-110,y:-240)
                .opacity(0.9)
            
            //topRightCircleYellow
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 80, height: 80)
                .offset(x:110,y:-240)
                .opacity(0.9)
        }
        
        //playerTurnPlace
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(.black)
            .frame(width: 100, height: 30)
            .offset(y:165)
        
        //playerTurnText
        Text("PLAYER TURN")
            .font(.system(size: 13))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .offset(y:165)
        
        //scorePlace
        RoundedRectangle(cornerRadius: 40)
            .frame(width: 130, height: 50)
            .offset(x:0,y:-270)
            .foregroundColor(.white)
        
        
        
        
    }
}
