// ============================================================
// 尺规取等长线段
// ============================================================

#import "@preview/cetz:0.4.2"

#let render() = {
  v(1em)

  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let main-color = rgb("#00AEEF") // 题干主要图线色：青蓝
      let mark-color = rgb("#7A7D81") // 尺规痕迹色：深灰

      let c = (0, 0)
      let b = (-2, 0)
      let a = (-4.5, 0)
      let r = 2.0 // 线段 BC 的绝对绘图长度

      let angle-l = 65deg // 射线 l 的倾斜角
      let l-end = (3.5 * calc.cos(angle-l), 3.5 * calc.sin(angle-l))

      // D 点在射线 l 上，距离 C 点 为 r
      let d = (r * calc.cos(angle-l), r * calc.sin(angle-l))

      // 1. 画原图已知水平线段与射线
      line(a, c, stroke: 1.2pt + main-color)
      line(c, l-end, stroke: 1.2pt + main-color, name: "ray")

      // 标注 射线 l 的代号
      let l-label-pos = (3.0 * calc.cos(angle-l) - 0.25, 3.0 * calc.sin(angle-l) + 0.2)
      content(l-label-pos, text(fill: black, size: 13pt, style: "italic")[$l$])

      // 2. 画圆规作图痕迹 (以 C 为固定圆心，BC=2 为半径尺规半径)
      // 注意：CeTZ 的 arc() 第一个参数是弧线的物理起始点，不是圆心。
      // 为保证 C 始终是几何圆心，我们需要精确推算其实际出发坐标点。

      // 主虚线：从 55度 逆时针画到 180度(点B)
      let arc-main-start = (c.at(0) + r * calc.cos(55deg), c.at(1) + r * calc.sin(55deg))
      arc(arc-main-start, start: 55deg, stop: 180deg, radius: r, stroke: (
        paint: mark-color,
        thickness: 0.8pt,
        dash: "dashed",
      ))

      // 实线短切痕：在刚好的交点 D 处 (65度)，从 61度 逆时针画到 69度
      let arc-tick-start = (c.at(0) + r * calc.cos(61deg), c.at(1) + r * calc.sin(61deg))
      arc(arc-tick-start, start: 61deg, stop: 69deg, radius: r, stroke: 1.2pt + mark-color)

      // 3. 画各位置端点（圆点）
      let pt-radius = 0.07
      for pt in (a, b, c) {
        circle(pt, radius: pt-radius, fill: main-color, stroke: none)
      }
      // D点也使用主色调标注端点
      circle(d, radius: pt-radius, fill: main-color, stroke: none)

      // 4. 标注字母
      content((a.at(0), a.at(1) - 0.4), text(size: 14pt, style: "italic")[$A$])
      content((b.at(0), b.at(1) - 0.4), text(size: 14pt, style: "italic")[$B$])
      content((c.at(0) + 0.1, c.at(1) - 0.4), text(size: 14pt, style: "italic")[$C$])
      // 新作出的 D 点标注在它左上方偏离射线处以防重叠
      content((d.at(0) - 0.25, d.at(1) + 0.45), text(size: 14pt, style: "italic")[$D$])
    })
  ]

  v(1.5em)

  // 绘图原理与步骤
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与尺规作图步骤]
    #v(0.4em)

    - *测算几何比例*：根据原图的分布比例，设立点 $C$ 位于原点 $(0,0)$，观察到线段 $B C$ 占该长横线的大约较小半部分，而线段 $A B$ 略长。因而在代码层面设定线段 $B C=2$（推导 $B(-2,0)$），$A B=2.5$（推导 $A(-4.5,0)$）。射线 $l$ 呈大约 $65 degree$ 仰角向第一象限发射。
    - *截取等长线段法则*：为了“以点 $C$ 为端点...画一条线段 $C D$ 使其与 $B C$ 等长”，标准的圆规行为逻辑就是：将圆规针尖刺入点 $C$ 作为圆心，分规笔尖拉大至点 $B$，此时圆规间距即为要求的长度 $B C$。紧接着，以此固定半径挥动画弧，使其与射线 $l$ 产生交割，交点便为 $D$。
    - *代码复原强制作图痕迹*：为了满足“注意保留圆规作图痕迹”的特殊叮嘱，本设计调用了 `arc` 工具对过程进行了重演追踪。以 $C$ 为圆心，作了一条起始于 $180 degree$（出发自 $B$ 点处）、向右上跨越且扫过了 $65 degree$ 射线、最终落点于 $55 degree$ 的跨幅虚线半显影轨迹。又在交点 $D$ 的上下夹角域增加了一道更实在的硬朗短切弧，栩栩如生地重构了真实的尺规刀割表现力。
  ]
}
