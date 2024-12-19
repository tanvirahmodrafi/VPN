//
//  Home.swift
//  X-VPN
//
//  Created by Tanvir on 29/11/2024.
//

import SwiftUI

struct Home: View {
    
    @State var isConnected = false
    //Current Server
    @State var currentServer: Server = servers.first!
    @State var changeServer = false
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    
                }label:{
                        Image(systemName: "circle.grid.cross")
                        .font(.title2)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.white.opacity(0), lineWidth: 1)
                        )
                    }
                
                
                Spacer()
                
                Button {
                    
                }label:{
                        Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.white.opacity(0), lineWidth: 1)
                        )
                    }
            }
            .overlay(
                Text(getTitle())
                    .foregroundColor(.white)
            )
            .foregroundColor(.white)
            
            //power Button
            PowerButton()
            // Status....
            VStack{
                Label{
                    Text(isConnected ? "Connected" : "Disconnected")
                        
                }icon:{
                    Image(systemName: isConnected ? "checkmark.shield" : "shield.slash")
                    
                }
                .font(.system(size: 18, weight: .semibold))
                .frame(height: 70)
                
                
                Spacer()
                
                HStack{
                    
                    HStack{
                        
                        Image(systemName: "arrow.down.to.line.circle")
                            .font(.title2)
                            .foregroundColor(.gray)
                            
                        VStack(alignment: .leading,spacing: 0){
                            Text("Download")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            Text("\(isConnected ? "60.0" : "0") KB/s")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    HStack{
                        
                        Image(systemName: "arrow.up.to.line.circle")
                            .font(.title2)
                            .foregroundColor(.gray)
                            
                        VStack(alignment: .leading,spacing: 0){
                            Text("Upload")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            Text("\(isConnected ? "30.5" : "0") KB/s")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(width: getRect().width - 120)
                .padding(.top,20)
            }
            .frame(height:154)
            
        }
        //.padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment:.top)
        .background(
            background()
        )
        // blur when server page shown
        .overlay(
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(changeServer ? 0.7 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(){
                        changeServer.toggle()
                    }
                }
        )
        
        .overlay(
            BottomSheet(),
            alignment: .bottom
        )
        .ignoresSafeArea(.container,edges: .bottom)
        
        .preferredColorScheme(.dark)
    }
    
    //Bottom Sheet
    @ViewBuilder
    func BottomSheet() -> some View {
        VStack(spacing : 0){
            
            //Current Server
            HStack{
                
                Image(currentServer.flag)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 6){
                    
                    Text(currentServer.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(isConnected ? "Currently Connected":
                        "Currently Selected")
                        .font(.caption2.bold())
                }
                
                Spacer(minLength: 10)
                
                //Change server Button
                Button{
                    withAnimation{
                        changeServer.toggle()
                    }
                }label: {
                    Text(changeServer ? "Exit" : "Change")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(width: 110 , height:45)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.white.opacity(0.27)
                                    , lineWidth: 2)
                        )
                        .foregroundColor(.white)
                }
            }
            .frame(height: 50)
            .padding(.horizontal,1)
            
            Divider()
                .padding(.top)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    //filtered server
                    // not showing connected one
                    ForEach(servers.filter{
                        $0.id != currentServer.id
                    }){server in
                        VStack(spacing: 12){
                            HStack{
                                VStack(alignment: .leading, spacing: 8){
                                    HStack{
                                        Image(server.flag)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                        
                                        Text(server.name)
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                    }
                                    
                                    Label {
                                        Text ("Available, Ping 992ms")
                                            .foregroundColor(.green)
                                            
                                    } icon: {
                                        Image(systemName: "checkmark")
                                            
                                    }
                                    .foregroundColor(.green)
                                    .font(.caption2)
                                    
                                    
                                }
                                
                                Spacer(minLength: 10)
                                
                                //Change server Button
                                Button{
                                    withAnimation{
                                        changeServer.toggle()
                                        currentServer = server
                                        isConnected = false
                                    }
                                }label: {
                                    Text("Change")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 100 , height:45)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(.white.opacity(0.25)
                                                    , lineWidth: 2)
                                        )
                                        .foregroundColor(.white)
                                }
                                Button{
                                    
                                }label:{
                                    Image (systemName: "square.and.arrow.up")
                                    .frame(width: 45 , height:45)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(.white.opacity(0.25)
                                                , lineWidth: 2)
                                    )
                                    .foregroundColor(.white)
                                }
                                
                            }
                            .frame(height: 50)
                            .padding(.horizontal,1)
                            
                            Divider()
                        }
                    }
                }
                .padding(.top,25)
                .padding(.bottom, getSafeArea().bottom)
            }
            .opacity(changeServer ? 1:0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: getRect().height/2.5, alignment: .top)
        .padding()
        .background(
            Color("BottomSheet")
                .clipShape(CustomCorners(radius: 35, corners:
                                            [.topLeft,.topRight]))
        )
        //showing only 50 pixels of heights.....
        // ............
        // change
        //.............
        .offset(y: changeServer ? 0 :(getRect().height / 3) - 50 +
            getSafeArea().bottom)
    }
    
    
    
    @ViewBuilder
    func background() -> some View {
        ZStack{
            
            LinearGradient(colors:[
                
                Color(.black),
                Color("BG1"),
                Color("BG2"),
                Color("BG3"),

            ],startPoint: .top, endPoint: .bottom)
        // Stars
            let stars : [CGPoint] = [
                CGPoint(x: 15, y: 190),
                CGPoint(x: 145, y: 250),
                CGPoint(x: 20, y: 350),
                CGPoint(x: 310, y: 400),
                CGPoint(x: 260, y: 500),
                
                CGPoint(x: getRect().width - 30, y: 600),
            ]
            
            ForEach(stars,id: \.x){ star in
                
                Circle()
                    .fill(.white.opacity(0.5))
                    .frame(width: 5, height: 5)
                    .position(star)
            }
            
        // Mars
            Image ("Earth")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .scaleEffect(isConnected ? 1 : 2 )
                .position(x:50, y:240)//no offset using position
                .opacity(1.8)
            
        // Globe at bottom
            Image("Globe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width, height: getRect().width)
                .scaleEffect(isConnected ? 2.2 : 1.6)
                .offset(y:250)
            //moving to bottom
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
            .ignoresSafeArea()
    }
    func getTitle() -> AttributedString {
        var str = AttributedString("X-VPN")
        if let range  = str.range(of: "X-") {
            str[range].font = .system(size: 24 , weight: .light )
        }
        
        if let range  = str.range(of: "VPN") {
            str[range].font = .system(size: 24 , weight: .black )
        }
        return str
    }
    
    
    
    
    
    
    
    //viewBuilder
    @ViewBuilder
    func PowerButton() -> some View {
        Button{
            withAnimation{
                isConnected.toggle()
            }
        }label:{
            ZStack{
                Image(systemName: "power")
                    .font(.system(size: 65, weight: .medium))
                    .foregroundColor(isConnected ? .white : Color("Power"))
                
                //scaling down image and showing Status...
                
                    .scaleEffect(isConnected ? 0.8 : 1)
                    .offset(y : isConnected ? -30 : 0)
                Text("DISCONNECT")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isConnected ? 1 : 0)
                
            }
            
            
                .frame(width: 190, height: 190)
                .background(
                    ZStack{
                        Circle()
                            .trim(from: isConnected ? 0:0.3 ,to: isConnected ? 1:0.5)
                            .stroke(
                                LinearGradient(colors:[
                                   Color("Ring1"),
                                   Color("Ring2"),
                                   Color("Ring3"),
                                ],startPoint: .leading, endPoint: .trailing),
                                style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                            )
                            .shadow(color: Color("Ring1"), radius: 5, x: 1, y: -5)
                        
                        Circle()
                            .trim(from: isConnected ? 0:0.3 ,to: isConnected ? 1: 0.5)
                            .stroke(
                                LinearGradient(colors:[
                                   Color("Ring3"),
                                   Color("Ring2"),
                                   Color("Ring1"),
                                ],startPoint: .leading, endPoint: .trailing),
                                style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                            )
                            .shadow(color: Color("Ring1"), radius: 5, x: 1, y: -5)
                            .rotationEffect(.init(degrees: 180))
                        
                        //inner ring
                        Circle()
                            .stroke(
                                Color("Ring1")
                                    .opacity(0.05),
                                lineWidth:11
                            )
                        //toggling shadow when button is clicked
                        
                            .shadow(color: Color("Ring1").opacity(isConnected ? 0.4 :0), radius: 5, x: 1, y: -5)
                    }
                )
        }
        .padding(.top,130)
    }
    
}

#Preview {
    Home()
}
extension View{
    
    func getRect()-> CGRect{
        UIScreen.main.bounds
    }
    
    func getSafeArea()-> UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first
            as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        return safeArea
    }
}
