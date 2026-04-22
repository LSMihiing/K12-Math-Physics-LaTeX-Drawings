// 3.tex:1630-1647 三相四线制：Y-Y连接
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    // 发电机侧（Y型3绕组）
    draw-inductor((0, 0), (0, 2), coils: 3)
    draw-inductor((0, 0), (-2, -1), coils: 3)
    draw-inductor((0, 0), (2, -1), coils: 3)
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
    content((-0.3, 0.1), text(size: 5pt)[$O$])
    content((-0.3, 2), text(size: 5pt)[$A$])
    content((-2.3, -1), text(size: 5pt)[$C$])
    content((2.3, -1), text(size: 5pt)[$B$])
    // 负载侧（Y型3电阻）
    draw-resistor((5, 0), (5, 2), label: $1$)
    draw-resistor((5, 0), (3, -1), label: $3$)
    draw-resistor((5, 0), (7, -1), label: $2$)
    circle((5, 0), radius: 0.05, fill: black, stroke: none)
    content((5.3, 0.1), text(size: 5pt)[$O'$])
    // 端线
    line((0, 2), (5, 2), stroke: w)
    line((2, -1), (2, -1.5), stroke: w)
    line((2, -1.5), (7, -1.5), stroke: w)
    line((7, -1.5), (7, -1), stroke: w)
    line((-2, -1), (-2, -2), stroke: w)
    line((-2, -2), (3, -2), stroke: w)
    line((3, -2), (3, -1), stroke: w)
    // 中性线
    line((0, 0), (5, 0), stroke: w)
  })
}
