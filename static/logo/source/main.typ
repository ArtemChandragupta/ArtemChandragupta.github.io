#import "@preview/cetz:0.4.2"
#set page(
  fill: none,
  // fill: rgb("#282828"),
  width: 6cm,
  height: 6cm,
)
#set text(
  font: "STIX Two Math",
  size: 14pt,
  lang: "ru"
)
#figure(
  cetz.canvas({
    import cetz.draw: *

    scale(6)

    // circle((0,0), name: "circle", radius: .08)
    // line((0,0.05),(0,-0.05))
    // line((0.05,0),(-0.05,0))

    circle((0,0), name: "circle", radius: .22,stroke:none)
    content((name:"circle", anchor:   0deg), angle:-240deg, text(fill:rgb("#B8BB26"),size:6*14pt)[#sym.lambda])
    content((name:"circle", anchor:  60deg), angle:-180deg, text(fill:rgb("#83A598"),size:6*14pt)[#sym.lambda])
    content((name:"circle", anchor: 120deg), angle:-120deg, text(fill:rgb("#B8BB26"),size:6*14pt)[#sym.lambda])
    content((name:"circle", anchor: 180deg), angle: -60deg, text(fill:rgb("#83A598"),size:6*14pt)[#sym.lambda])
    content((name:"circle", anchor: 240deg), angle:   0deg, text(fill:rgb("#B8BB26"),size:6*14pt)[#sym.lambda])
    content((name:"circle", anchor: 300deg), angle:  60deg, text(fill:rgb("#83A598"),size:6*14pt)[#sym.lambda])
    content((-0.00,-0.005), emph(text(fill:red,size:28pt)[#sym.integral.cont]))
  })
)
