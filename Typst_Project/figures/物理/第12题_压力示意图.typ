// ============================================================
// 第12题 · 压力示意图（水平桌面）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[12.]
  text(size: 11pt)[如图所示，重为 10 N 的木块静止在水平桌面上。请在图中画出水平桌面所受压力的示意图。]

  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let ox = 0.0
      let oy = 0.0

      // 1. 绘制水平桌面
      // 线段长度取 5cm
      line((ox - 2.5, oy), (ox + 2.5, oy), stroke: 1pt + black)
      // 绘制桌面的阴影斜线（表示固体表面）
      for i in range(21) {
        let x = ox - 2.3 + i * 0.23
        line((x, oy), (x - 0.2, oy - 0.25), stroke: 0.5pt + black)
      }

      // 2. 绘制木块
      // 比例：宽度 1.6cm，高度 1.0cm
      let bw = 1.6
      let bh = 1.0
      rect((ox - bw / 2, oy), (ox + bw / 2, oy + bh), fill: none, stroke: 1pt + black)

      // 3. 绘制压力 F
      // 作用点：木块与桌面接触面的中点 (ox, oy)
      // 方向：垂直于支持面向下
      // 长度：设为 1.5cm 表示 10N
      line((ox, oy), (ox, oy - 1.5), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)

      // 4. 标注
      // 压力大小等于重力，标注 F = 10 N
      content((ox + 1, oy - 1.2))[ $F = 10"N"$ ]

      // 标注图名
      content((ox, oy - 1.2))[ #h(0pt) ] // 占位
      content((ox, oy - 2.2), text(size: 10pt, fill: blue.darken(20%))[（第 12 题图）])
    })
  ]

  v(1.2em)

  // --- 解析部分 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + rgb(31, 120, 180)),
    fill: rgb(245, 250, 255),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb(31, 120, 180), size: 10pt)[【解析】]
    #v(0.3em)
    #set text(size: 10pt)
    1. *力的分析*：木块静止在水平桌面上，受到重力和桌面对它的支持力。根据牛顿第三定律，木块对桌面产生一个压力。
    2. *三要素确定*：
      - *作用点*：压力是木块作用在桌面上的力，作用点应在接触面（桌面）上，通常画在接触面的中心。
      - *方向*：垂直于支持面并指向被压物体，即垂直桌面向下。
      - *大小*：在水平面上，压力的大小等于物体的重力，即 $F = G = 10"N"$。

    因此，从接触面中点开始，沿垂直向下的方向画一条带箭头的线段，并标注 $F=10"N"$。
  ]

  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + luma(180)),
    fill: luma(248),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *建立坐标系*：以桌面中心为原点 $(0, 0)$。
    + *绘制环境*：使用 `line` 函数绘制桌面水平线，通过循环绘制短斜线模拟阴影效果。
    + *绘制物体*：使用 `rect` 函数在原点上方绘制矩形表示木块，确保底部与桌面重合。
    + *绘制矢量*：确定压力的作用点为 $(0, 0)$，终点为 $(0, -1.5)$。使用 `line` 函数绘制带 `stealth` 箭头的线段，设置加粗 `stroke` 以突出受力。
    + *添加标注*：使用 `content` 函数在矢量末端附近添加数学公式标注力的大小。
  ]
}
