//
//  Home.swift
//  Home
//
//  Created by nyannyan0328 on 2021/09/11.
//

import SwiftUI

struct Home: View {
    @State var txt = ""
    @State var offset : CGFloat = 0
    @State var lastOffset : CGFloat = 0
    @GestureState var gestureOffset : CGFloat = 0
    var body: some View {
        ZStack{
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .blur(radius: getBlurRadius())
       
            }
            .ignoresSafeArea()
            GeometryReader{proxy in
                
                let height = proxy.frame(in: .global).height//view自体を上に持っていくのでglobal.H
                
                ZStack{
                        BlureView(style: .systemThinMaterialDark)
                        .clipShape(CustomShape(radi: 20, corner: [.topLeft,.topRight]))
                    
                    
                    VStack{
                        
                        VStack{
                            
                            
                            Capsule()
                                .fill(.white)
                                .frame(width : 70,height:5)
                                .padding(.top)
                            
                            
                            TextField("Serach", text: $txt)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .font(.system(size: 15, weight: .thin))
                                .background(BlureView(style: .systemThinMaterialDark))
                                .cornerRadius(8)
                                .padding(.top,10)
                            
                        }
                        .frame(height:100)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            
                            
                            bottomContent()
                                .padding(.bottom)
                                .padding(.bottom,offset == -((height - 100) / 3) ? ((height - 100) / 1.5) : 0)
                        }
                        
                    }
                    .padding(.horizontal)
                    .preferredColorScheme(.dark)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .offset(y: height - 100)//多分０が一番下(proxy.size.height)でそこから−１００
                .offset(y: -offset > 100 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                .gesture(
                    
                    DragGesture().updating($gestureOffset, body: { Value, out, _ in
                        out = Value.translation.height//上に持っていくのでH
                        onChanged()//onchangeはupdatingさせたときなのでここ
                    })
                        .onEnded({ value in
                            let maxH = height - 100//func作らないのgeoがローカルスコープだから
                            
                            withAnimation{
                                
                                
                                if -offset > 100 && -offset < maxH / 2{
                                    
                                    
                                    offset = -(maxH / 3)
                                    
                                }
                                else if -offset > maxH / 2{
                                    offset = -maxH
                                    
                                }
                                
                                else{
                                    
                                    offset = 0
                                }
                                
                                
                            }
                            
                            lastOffset = offset
                            
                            
                        })
                    
                )
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
        }
    }
    
    @ViewBuilder
    func bottomContent()->some View{
        
        VStack(spacing:20){
            
            HStack{
                
                
                Text("Favorites")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                
                Button {
                    
                } label: {
                    
                    Text("See All")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                }
                
            }
            .padding([.horizontal,.top],10)
            
            Divider()
                .background(.white)//back
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing:15){//全体のH
                    
                    
                    VStack(spacing: 15) {
                        
                        Button {
                            
                        } label: {
                            
                            Image(systemName: "house.fill")
                                .font(.title.bold())
                            
                            
                        }
                        
                        Text("Home")
                            .font(.callout.bold())
                    }
                    .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Button {
                            
                        } label: {
                            
                            Image(systemName:"gear")
                                .font(.title.bold())
                         }
                        
                        Text("Settings")
                            .font(.callout.bold())
                        
                        
                    }
                    .foregroundColor(.white)
                    .padding(.leading,5)
                    
                    
                }
                
            }
            .padding(.horizontal)
            .padding(.top,10)
            
            Divider()
                .background(.white)
            
            Text("Choise Image")
                .font(.title.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            Divider()
                .background(.white)
            
            
            ForEach(1...6,id:\.self){index in
                
                Image("p\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 20, height: 300)
                    .cornerRadius(20)
                
            }
            
        }
        
    }
    
    func onChanged(){
        
        DispatchQueue.main.async {
            
            self.offset = gestureOffset + lastOffset
        }
        
    }
    
    func getBlurRadius()->CGFloat{
        
        let progress = -offset / (UIScreen.main.bounds.height / 3)
        return progress * 30 <= 30 ? progress * 30 : 30
        
    }
}
