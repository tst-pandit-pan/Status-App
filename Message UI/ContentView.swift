//
//  ContentView.swift
//  Message UI
//
//  Created by Kavsoft on 25/03/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var index = 0
    @State var expand = false
    
    var body : some View{
        
        ZStack{
            
            VStack{
                
                Color.white
                Color("Color")
            }
            
            VStack{
                
                ZStack{
                    
                    Chats(expand: self.$expand).opacity(self.index == 0 ? 1 : 0)
                    
                    Groups().opacity(self.index == 1 ? 1 : 0)
                    
                    Settings().opacity(self.index == 2 ? 1 : 0)
                }
                
                BottomView(index: self.$index)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Chats : View {

    @Binding var expand : Bool
    
    var body : some View{
        
        VStack(spacing: 0){
            
            TopView(expand: self.$expand).zIndex(25)
            
            Centerview(expand: self.$expand).offset(y: -25)
        }
    }
}

struct Groups : View {
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack{
                
                Text("Group")
            }
            
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.white)
        .clipShape(shape())
        .padding(.bottom, 25)
    }
}

struct Settings : View {
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack{
                
                Text("Settings")
                
            }
            
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.white)
        .clipShape(shape())
        .padding(.bottom, 25)
    }
}

struct TopView : View {
    
    @State var search = ""
    @Binding var expand : Bool
    
    var body : some View{
        
        VStack(spacing: 22){
            
            if self.expand{
                
                HStack{
                    
                    Text("Messages")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("menu")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.black.opacity(0.4))
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 18){
                        
                        Button(action: {
                            
                        }) {
                            
                            Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("Color2"))
                            .padding(18)
                            
                        }.background(Color("Color2").opacity(0.5))
                        .clipShape(Circle())
                        
                        ForEach(1...7,id: \.self){i in
                            
                            Button(action: {
                                
                            }) {
                                
                                Image("p\(i)")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 60, height: 60)
                                
                            }
                        }
                    }
                }
                
            }
            
            HStack(spacing: 15){
                
                Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.black.opacity(0.3))
                
                TextField("Search", text: self.$search)
                
            }.padding()
            .background(Color.white)
            .cornerRadius(8)
            .padding(.bottom, 10)
            
        }.padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color("Color1"))
        .clipShape(shape())
        .animation(.default)
        
    }
}

struct Centerview : View {
    
    @Binding var expand : Bool
    
    var body : some View{
        
        List(data){i in
            
            if i.id == 0{
                
                cellView(data : i)
                .onAppear {
                        
                    self.expand = true
                }
                .onDisappear {
                    
                    self.expand = false
                }
            }
            else{
                
                cellView(data : i)
            }
            
        }
        .padding(.top, 20)
        .background(Color.white)
        .clipShape(shape())
    }
}

struct BottomView : View {
    
    @Binding var index : Int
    
    var body : some View{
        
        HStack{
            
            Button(action: {
                
                self.index = 0
                
            }) {
                
                Image(systemName: "message.fill")
                .resizable()
                .frame(width: 25, height: 25)
                    .foregroundColor(self.index == 0 ? Color.white : Color.white.opacity(0.5))
                .padding(.horizontal)
            }
            
            Spacer(minLength: 10)
            
            Button(action: {
                
                self.index = 1
                
            }) {
                
                Image("group")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(self.index == 1 ? Color.white : Color.white.opacity(0.5))
                .padding(.horizontal)
            }
            
            Spacer(minLength: 10)
            
            Button(action: {
                
                self.index = 2
                
            }) {
                
                Image("settings")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(self.index == 2 ? Color.white : Color.white.opacity(0.5))
                .padding(.horizontal)
            }
            
        }.padding(.horizontal, 30)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    }
}

struct cellView : View {
    
    var data : Msg
    
    var body : some View{
        
        HStack(spacing: 12){
            
            Image(data.img)
            .resizable()
            .frame(width: 55, height: 55)
            
            Image(data.img)
            .resizable()
            .frame(width: 10, height: 10)
            
            VStack(alignment: .leading, spacing: 12) {
            
                Text(data.name)
                
                Text(data.msg).font(.caption)
            }
            
            Spacer(minLength: 0)
            
            VStack{
                
                Text(data.date)
                
                Spacer()
            }
        }.padding(.vertical)
    }
}

struct shape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 30, height: 30))
        
        return Path(path.cgPath)
    }
}


struct Msg : Identifiable {
    
    var id : Int
    var name : String
    var msg : String
    var date : String
    var img : String
}

var data = [
    
    Msg(id: 0, name: "Brain", msg: "Hello!!!", date: "25/11/20",img: "p1"),
    Msg(id: 1, name: "John", msg: "How Are You ???", date: "22/11/20",img: "p2"),
    Msg(id: 2, name: "Ryan", msg: "New Tutorial From Kavsoft", date: "20/11/2022",img: "p3"),
    Msg(id: 3, name: "Emma", msg: "What does the fox say?", date: "04/11/2022",img: "p4"),
    Msg(id: 4, name: "Sam", msg: "SwiftUI Tutorials", date: "25/10/2022",img: "p5"),
    Msg(id: 5, name: "Alex", msg: "New Apple iPhone", date: "15/03/2022",img: "p6"),
    Msg(id: 6, name: "Nathan", msg: "Hey Guys!!!", date: "25/03/2022",img: "p7"),
    Msg(id: 7, name: "Julia", msg: "Hello!!!", date: "25/03/2022",img: "p1"),
    Msg(id: 8, name: "Watson", msg: "How Are You ???", date: "22/03/2022",img: "p2"),
    Msg(id: 9, name: "Kavuya", msg: "New Tutorial From Kavsoft", date: "20/03/2022",img: "p3"),
    Msg(id: 10, name: "Julie", msg: "Hey Everyone", date: "25/03/2022",img: "p4"),
    Msg(id: 11, name: "Lisa", msg: "SwiftUI Tutorials", date: "25/03/2022",img: "p5"),
    
]
