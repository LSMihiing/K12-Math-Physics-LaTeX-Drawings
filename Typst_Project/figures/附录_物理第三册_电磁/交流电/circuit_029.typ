// 3.tex:1403-1412 滤波：变压器+D+R+C
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *
    // AC源+一次线圈（bumps朝右）
    draw-ac-source(-3, -1, 1)
    line((-3, 1), (-2, 1), stroke: w)
    draw-inductor((-2, 1), (-2, -1), coils: 4)
    line((-2, -1), (-3, -1), stroke: w)
    // 铁芯
    draw-core(-1.6, -0.5, 0.5)
    // 二次线圈（bumps朝左，mirror）
    draw-inductor((-1.25, -1.2), (-1.25, 1.2), coils: 5, mirror: true)
    // D二极管
    draw-diode((-0.5, 1.2), (0.5, 1.2))
    content((0, 1.65), text(size: 6pt)[$D$])
    // R
    draw-resistor((2, 1.2), (2, -1.2), label: $R$)
    // 回路
    line((-1.25, 1.2), (-0.5, 1.2), stroke: w)
    line((0.5, 1.2), (2, 1.2), stroke: w)
    line((2, -1.2), (-1.25, -1.2), stroke: w)
    // C
    circle((0.8, 1.2), radius: 0.04, fill: black, stroke: none)
    circle((0.8, -1.2), radius: 0.04, fill: black, stroke: none)
    draw-capacitor((0.8, 1.2), (0.8, -1.2))
    content((1.15, 0), text(size: 6pt)[$C$])
  })
}
