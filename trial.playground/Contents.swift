// String.

var b:String = "Hello World"

print(b)
b = "Now Watch me WHIP!!!"

var c:Int = 4
print(c)

let bg:Float = 565.34

var h:Int = c * 4

func hi(a:Float, b:Float) -> Float {
    print(a+b)
    return a*b
}

let bh = hi(a:11,b:2)
print(bh)

func mphmps(_ mph:Float) -> Float {
    let fph:Float = mph * 5280
    let fps:Float = fph / 3600
    let ips:Float = fps * 12
    let cps:Float = ips * 2.54
    let mps:Float = cps / 100
    return mps
}

print(mphmps(34.7))


struct MyStruct {
    
    // Vars and Constants //Properties
    var message:String = "Heyo"
    
    // Functions // Methods
    func sendChat() {
        print(message)
    }
}


