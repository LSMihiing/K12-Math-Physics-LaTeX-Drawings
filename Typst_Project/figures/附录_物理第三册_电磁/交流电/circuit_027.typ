// 3.tex:1337-1356 桥式整流：变压器+4二极管+R
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    // AC源+一次线圈（bumps朝右）
    draw-ac-source(-3, -1, 1)
    line((-3, 1), (-1.75, 1), stroke: w)
    draw-inductor((-1.75, 1), (-1.75, -1), coils: 4)
    line((-1.75, -1), (-3, -1), stroke: w)
    // 铁芯
    draw-core(-1.5, -0.4, 0.4)
    // 二次线圈（bumps朝左，mirror）
    line((1, -1), (1, -1.5), stroke: w)
    line((1, -1.5), (-1.25, -1.5), stroke: w)
    draw-inductor((-1.25, -1.5), (-1.25, 1.5), coils: 5, mirror: true)
    line((-1.25, 1.5), (1, 1.5), stroke: w)
    line((1, 1.5), (1, 1), stroke: w)
    // 桥式二极管
    draw-diode((0, 0), (1, 1))
    draw-diode((1, 1), (2, 0))
    draw-diode((0, 0), (1, -1))
    draw-diode((1, -1), (2, 0))
    // 节点
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
    circle((2, 0), radius: 0.05, fill: black, stroke: none)
    circle((1, 1), radius: 0.05, fill: black, stroke: none)
    circle((1, -1), radius: 0.05, fill: black, stroke: none)
    // R
    line((2, 0), (3, 0), stroke: w)
    draw-resistor((3, 0), (3, -2), label: $R$)
    line((3, -2), (0, -2), stroke: w)
    line((0, -2), (0, 0), stroke: w)
    // 标签
    content((1.5, 1.1), text(size: 6pt)[$D_1$])
    content((1.5, -1.1), text(size: 6pt)[$D_2$])
    content((0.5, -1.1), text(size: 6pt)[$D_3$])
    content((0.5, 1.1), text(size: 6pt)[$D_4$])
    content((3.25, -0.5), text(size: 6pt)[$+$])
    content((3.25, -1.5), text(size: 6pt)[$-$])
    content((-1.1, 0.5), text(size: 6pt)[$a$])
    content((-1.1, -0.5), text(size: 6pt)[$b$])
  })
}
