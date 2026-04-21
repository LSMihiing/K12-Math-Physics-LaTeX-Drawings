// ============================================================
// 压力示意图（水平面、竖直面、斜面）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[5.]
  text(size: 11pt)[请在下列各图中作出小物块对支持面压力的示意图。]

  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      // ==================== 甲 ====================
      group(name: "jia", {
        let ox = 0.0
        let oy = 0.0

        // 地面
        line((ox - 2.0, oy), (ox + 2.0, oy), stroke: 1pt + black)
        for i in range(25) {
          let x = ox - 1.8 + i * 0.15
          line((x, oy), (x - 0.15, oy - 0.2), stroke: 0.5pt + black)
        }

        // 物块
        let bw = 1.4
        let bh = 1.0
        rect((ox - bw / 2, oy), (ox + bw / 2, oy + bh), fill: rgb(255, 255, 255), stroke: 1pt + black)

        // 压力 F
        line((ox, oy), (ox, oy - 1.5), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((ox + 0.3, oy - 1.3))[ $F$ ]

        // 标号
        content((ox, oy - 2.4))[ 甲 ]
      })

      // ==================== 乙 ====================
      group(name: "yi", {
        let ox = 5.5
        let oy = 0.5

        // 墙面
        line((ox, oy - 2.0), (ox, oy + 2.0), stroke: 1pt + black)
        for i in range(25) {
          let y = oy - 1.8 + i * 0.15
          line((ox, y), (ox - 0.2, y - 0.15), stroke: 0.5pt + black)
        }

        // 物块
        let bw = 1.0
        let bh = 1.4
        rect((ox, oy - bh / 2), (ox + bw, oy + bh / 2), fill: rgb(255, 255, 255), stroke: 1pt + black)

        // 原图受力 F
        line((ox + bw + 1.2, oy), (ox + bw, oy), mark: (end: "stealth", fill: black), stroke: 0.8pt + black)
        content((ox + bw + 1.6, oy))[ $F$ ]

        // 压力 F
        line((ox, oy), (ox - 1.5, oy), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((ox - 1.0, oy + 0.3))[ $F$ ]

        // 标号
        content((ox + 0.5, oy - 2.9))[ 乙 ]
      })

      // ==================== 丙 ====================
      group(name: "bing", {
        let ox = 11.0
        let oy = -1.5

        let basew = 4.0
        let h = 2.2
        // 斜面底座
        line((ox - 1.5, oy), (ox + basew - 1.5, oy), (ox + basew - 1.5, oy + h), close: true, stroke: 1pt + black)

        let dx = basew
        let dy = h
        let len = calc.sqrt(dx * dx + dy * dy)
        let ux = dx / len
        let uy = dy / len
        let nx = -uy
        let ny = ux

        let cx = ox - 1.5 + len * 0.4 * ux
        let cy = oy + len * 0.4 * uy

        let bw = 1.4
        let bh = 1.0

        let b_bl_x = cx - bw / 2 * ux
        let b_bl_y = cy - bw / 2 * uy
        let b_br_x = cx + bw / 2 * ux
        let b_br_y = cy + bw / 2 * uy
        // 物块
        line(
          (b_bl_x, b_bl_y),
          (b_br_x, b_br_y),
          (b_br_x + bh * nx, b_br_y + bh * ny),
          (b_bl_x + bh * nx, b_bl_y + bh * ny),
          close: true,
          fill: rgb(255, 255, 255),
          stroke: 1pt + black,
        )

        // 压力力 F
        let flex = 1.5
        line((cx, cy), (cx - flex * nx, cy - flex * ny), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
        content((cx - flex * nx + 0.3, cy - flex * ny - 0.2))[ $F$ ]

        // 标号
        content((ox + basew / 2 - 1.5, oy - 0.9))[ 丙 ]
      })
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
    力是物体对物体的作用。压力是垂直作用在物体表面上的力。
    压力的作用点在被压物体的表面上，也就是支持面上；方向垂直于支持面，并指向被压物体。

    （1）图甲中，物块放在水平面上，支持面是水平面，压力的方向垂直于水平面向下，作用点画在接触面的中心。

    （2）图乙中，物块被外力 $F$ 压在竖直墙面上，支持面是竖直墙面，压力的方向垂直于竖直墙面向左，作用点画在接触面的中心。

    （3）图丙中，物块放在斜面上，支持面是斜面，压力的方向垂直于斜面向下，作用点画在接触面的中心。
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

    + *基准坐标*：在一张画布中平移绘制三个图，基准横坐标依次偏移（例如甲在 x=0，乙在 x=5.5，丙在 x=11.0）。
    + *图甲绘制（水平面）*：绘制水平直线与阴影短线表示地面；在地面上方绘制矩形物块；从物块与地面接触面的中点处（作用点）画一个垂直向下的箭头表示压力，并标上字母 $F$。
    + *图乙绘制（竖直墙面）*：绘制竖直直线与阴影短线表示墙面；在墙面右侧绘制矩形物块，并在物块右侧绘制向左的水平已知外力 $F$；从物块与墙面接触面的中点处（作用点）画一个垂直向左的箭头表示压力，同样标上字母 $F$（为保持整洁此处的压力也可标记为 $F$）。
    + *图丙绘制（斜面）*：通过三点坐标闭合绘制直角三角形以表示斜面；根据斜面的宽高参数几何计算出法向量和单位切向量，利用向量平移法在斜面上生成倾斜矩形物块的四个顶点并绘制相连；从物块与斜面接触面的中点处，沿着法向量的反方向（即垂直于斜面指向斜面内部向下）画出一个箭头表示压力，标上字母 $F$。
  ]
}
