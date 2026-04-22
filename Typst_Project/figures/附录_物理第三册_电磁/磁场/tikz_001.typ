// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁现象的电本质~~磁性材料
// 原始文件：1.tex，行 112-125
// 类型：tikz   >=latex   无缩放(scale=1)
// 描述：悬挂通电线圈中的磁针（环形电流磁场示意）
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 天花板阴影线 pattern=north east lines ---
    // 原始: fill[pattern=north east lines](-1,1.8) rectangle (0,2)
    rect((-1, 1.8), (0, 2), fill: luma(230), stroke: none)
    for i in range(0, 10) {
      let x0 = -1 + float(i) * 0.1
      line((x0, 1.8), (calc.min(x0 + 0.2, 0), calc.min(1.8 + 0.2, 2)),
        stroke: 0.3pt + black)
    }
    // 底边线
    line((-1, 1.8), (0, 1.8), stroke: 0.4pt + black)

    // --- 线圈（两个椭圆，模拟前后面） ---
    // 原始: \draw(0,0)ellipse[x radius=1, y radius=.5]
    // 后面的椭圆
    arc((0, 0), start: 0deg, stop: 360deg,
      radius: (1, 0.5), anchor: "origin", stroke: 0.4pt + black)
    // 原始: \draw[fill=white](0,0.1)ellipse[x radius=1, y radius=.5]
    // 前面的椭圆，fill=white 遮挡后面
    arc((0, 0.1), start: 0deg, stop: 360deg,
      radius: (1, 0.5), anchor: "origin",
      stroke: 0.4pt + black, fill: white)

    // --- 悬挂线 ---
    // 原始: \draw(-.5,1.8)--(-.5,0)
    line((-0.5, 1.8), (-0.5, 0), stroke: 0.4pt + black)

    // --- 交叉标记 ---
    // 原始: \draw(-.6,-.1)--(-.4,0.1)
    line((-0.6, -0.1), (-0.4, 0.1), stroke: 0.4pt + black)

    // --- 磁针（竖直细条） ---
    // 原始: \draw[fill=white](-.05,0) rectangle (.05,1.5)
    rect((-0.05, 0), (0.05, 1.5), fill: white, stroke: 0.4pt + black)
    // 原始: \draw[fill=white](-.05,-.5) rectangle (.05,-1.5)
    rect((-0.05, -0.5), (0.05, -1.5), fill: white, stroke: 0.4pt + black)

    // --- 磁针端部椭圆 ---
    // 原始: \draw[fill=white](0,1.5)ellipse[x radius=.05, y radius=.025]
    arc((0, 1.5), start: 0deg, stop: 360deg,
      radius: (0.05, 0.025), anchor: "origin",
      stroke: 0.4pt + black, fill: white)
    // 原始: \draw[fill=white](0,-1.5)ellipse[x radius=.05, y radius=.025]
    arc((0, -1.5), start: 0deg, stop: 360deg,
      radius: (0.05, 0.025), anchor: "origin",
      stroke: 0.4pt + black, fill: white)

    // --- 电流方向箭头弧 ---
    // 原始: \draw[->](-.2,1.2) arc [start angle=-180, end angle=70, x radius=.2, y radius=.1]
    arc((-0.2, 1.2), start: -180deg, stop: 70deg,
      radius: (0.2, 0.1), anchor: "origin",
      stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
  })
}
