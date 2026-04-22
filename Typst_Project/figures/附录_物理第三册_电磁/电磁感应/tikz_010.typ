// 来源：2.tex:430-436  法拉第电磁感应定律 — 椭圆线圈倾斜+虚线
// 无缩放  ☉符号（\Sun宏 → ⊙）
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    // 虚线对角线
    line((-2, 2), (2, -2),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // ⊙ 符号（太阳符号 = 磁场方向出纸面）
    // 左上
    circle((-2.15, 2.15), radius: 0.2, stroke: 0.4pt + black)
    circle((-2.15, 2.15), radius: 0.04, fill: black, stroke: none)
    // 右下
    circle((2.15, -2.15), radius: 0.2, stroke: 0.4pt + black)
    circle((2.15, -2.15), radius: 0.04, fill: black, stroke: none)

    // 外椭圆 (白色填充遮挡虚线)
    arc((0, 0), start: 0deg, stop: 360deg,
      radius: (2.1, 2.1 * 0.4), anchor: "origin",
      stroke: 0.4pt + black, fill: white)
    // 内椭圆
    arc((0, 0), start: 0deg, stop: 360deg,
      radius: (2, 0.8), anchor: "origin",
      stroke: 0.4pt + black, fill: white)

    // 虚线从左上到原点（上层）
    line((-2, 2), (0, 0),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
  })
}
