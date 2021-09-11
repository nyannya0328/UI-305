//
//  ContentView.swift
//  Shared
//
//  Created by nyannyan0328 on 2021/09/11.
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

struct TextShimer : View{

    var title : String

    @State var Ani = false

    var body: some View{

        ZStack{

            Text(title)
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(.white)


            HStack(spacing:0){

                ForEach(0..<title.count,id:\.self){index in


                    Text(String(title[title.index(title.startIndex,offsetBy : index)]))
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(RandomColor())


                }





            }

            .mask(

            Rectangle()
                .fill(

                    LinearGradient(gradient: .init(colors: [.red,.green]), startPoint: .top, endPoint: .trailing)

                )

                .rotationEffect(.init(degrees: 80))
                .padding(20)
                .offset(x: -250)
                .offset(x: Ani ? 500 : 0)

            )


                .onAppear(perform: {


                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)){


                    Ani.toggle()

                }


            })








        }



    }

    func RandomColor()->Color{

        let color = UIColor.init(displayP3Red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)

        return Color(color)


    }


}

struct CustomShape : Shape{
    
    var radi : CGFloat
    var corner : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
    }
}
