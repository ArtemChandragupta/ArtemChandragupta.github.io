#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import fletcher.shapes: pill, parallelogram, diamond, hexagon, brace

#let v_stroke = rgb("#282828")

#set page(fill: rgb("#EBDBB2"))
#set text(size:11pt, fill: v_stroke)

#figure(
  diagram(
    node-stroke: v_stroke,
    edge-stroke: v_stroke,

    node((0,1), corner-radius: 10pt, [
      Исходные данные $ [C] $ 
    ]),
    edge("=="),

    node((0,2), shape: parallelogram.with(angle: 30deg), name: <P2>, [
      $"задаем "[p_2], [phi], [psi] $
    ]),
    edge("=="),
  
    node((0,3), name:<I>, [
      *Первичный расчет* \
      #diagram(edge-stroke: v_stroke,
      $ (G_"опт", [C]) edge(->, text(#0.8em, f_"пер")) & [I] $
      )
    ] ),
    edge(<P2>,<I>,"=="),
    edge("=="),

    node((0,5), name: <S>, [
      *Расчет по ступеням* \
      #diagram(edge-stroke: v_stroke,
      $ (G_"опт", [C], [I], [p_2], [phi], [psi]) edge(->, text(#0.8em, f_"ступ")) & [S] $
      )
    ]),
    edge("=="),

    node((0,6), shape: parallelogram.with(angle: 30deg), name: <F>, [
      $"задаем " alpha_1 "и " beta_2^* $
    ]),
    edge("=="),

    node((0,7), name: <RR>, [
      *Расчет обратной закрутки* \
      #diagram(edge-stroke: v_stroke,
      $ (G_"опт", [C], [I], [S], F, rho_k, alpha_1, beta_2^*) edge(->, text(#0.8em, f_"зак")) & [R] $
      )
    ]),
    edge("=="),

    node((0,9), corner-radius: 10pt, [
      Профилирование РК и СА\
      Проверка конфузорности РК и СА\
    ]),


  ),
)

Хахахахах sdfsfasfsadfasdffasf
