// ============================================================
// 压力示意图（斜面受压）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[13.]
  text(size: 11pt)[如图所示，画出物体 A 受到的物体 B 对它的压力的示意图。]

  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let ox = 0.0
      let oy = 0.0

      // 1. 绘制斜面体 A
      // 设置基准尺寸：底宽 3.5cm, 高 2.0cm
      let aw = 3.5
      let ah = 2.0
      // 顶点：左下 (0,0), 右下 (aw, 0), 左上 (0, ah)
      line((ox, oy), (ox + aw, oy), (ox, oy + ah), close: true, stroke: 1pt + black)
      // 绘制右下角角弧 (表示斜面倾角)
      {
        let r = 0.35 // 进一步减小半径，匹配原图风格
        // 注意：本项目环境中 calc.atan2 的参数顺序为 (x, y)
        let angle = calc.atan2(aw, ah)
        let start_a = 180deg
        let end_a = 180deg - angle
        let steps = 15
        for i in range(steps) {
          let a1 = start_a + i * (end_a - start_a) / steps
          let a2 = start_a + (i + 1) * (end_a - start_a) / steps
          line(
            (ox + aw + r * calc.cos(a1), oy + r * calc.sin(a1)),
            (ox + aw + r * calc.cos(a2), oy + r * calc.sin(a2)),
            stroke: 0.5pt + black,
          )
        }
      }
      content((ox + 0.4, oy + 0.5), [A])

      // 2. 绘制物块 B
      // 计算斜面参数
      let dx = aw
      let dy = -ah
      let d_len = calc.sqrt(dx * dx + dy * dy)
      let ux = dx / d_len // 斜面方向单位向量 x
      let uy = dy / d_len // 斜面方向单位向量 y
      let nx = -uy // 法方向单位向量 x (垂直斜面向外)
      let ny = ux // 法方向单位向量 y (垂直斜面向外)

      // 物块 B 的位置：位于斜面中点附近
      let mid_dist = d_len * 0.45
      let cx = ox + mid_dist * ux
      let cy = oy + ah + mid_dist * uy

      // 物块 B 的尺寸
      let bw = 1.2
      let bh = 0.8

      // 计算物块四个顶点
      let p1 = (cx - bw / 2 * ux, cy - bw / 2 * uy)
      let p2 = (cx + bw / 2 * ux, cy + bw / 2 * uy)
      let p3 = (p2.at(0) + bh * nx, p2.at(1) + bh * ny)
      let p4 = (p1.at(0) + bh * nx, p1.at(1) + bh * ny)

      line(p1, p2, p3, p4, close: true, fill: none, stroke: 1pt + black)
      content((cx + 0.5 * nx, cy + 0.5 * ny), [B])

      // 3. 绘制压力 F
      // 作用点：接触面中点 (cx, cy)
      // 方向：垂直于斜面向下 (即 -n 方向)
      let f_len = 1.3
      line((cx, cy), (cx - f_len * nx, cy - f_len * ny), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)

      // 4. 标注
      content((cx - f_len * nx + 0.5, cy - f_len * ny + 0.2))[ $F$ ]

      // 画直角符号（压力垂直于斜面）
      let r_size = 0.2
      line(
        (cx - r_size * ux, cy - r_size * uy),
        (cx - r_size * ux - r_size * nx, cy - r_size * uy - r_size * ny),
        (cx - r_size * nx, cy - r_size * ny),
        stroke: 0.5pt + black,
      )

      // 标注图名
      content((ox + aw / 2, oy - 1.2), text(size: 10pt, fill: blue.darken(20%))[（第 13 题图）])
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
    1. *压力的定义*：压力是垂直作用在物体表面上的力。本题要求画出物体 B 对物体 A 的压力。
    2. *三要素确定*：
      - *作用点*：压力作用在物体 A 的表面（即斜面）上。绘图时画在 B 与 A 接触面的中点。
      - *方向*：垂直于接触面（斜面），并指向被压物体 A。即垂直于斜面向下。
      - *大小*：题目未给出具体数值，用线段长度表示即可，标上字母 $F$。

    绘图时，先确定接触面中点，沿垂直于斜面向下的方向画出带箭头的线段。
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

    + *构建斜面几何*：利用斜面底宽 $w$ 和高度 $h$ 计算斜面的斜率及单位向量 $arrow(u)$（沿斜面）和 $arrow(n)$（垂直斜面）。
    + *绘制斜面体 A*：连接 $(0,0), (w, 0), (0, h)$ 闭合路径，形成直角三角形。
    + *绘制物块 B*：在斜面上取一点作为接触面中点，利用向量合成计算矩形 B 的四个顶点坐标：$P plus.minus w_B / 2 arrow(u)$ 为底边，再沿 $arrow(n)$ 方向平移 $h_B$ 得到顶边。
    + *绘制压力矢量*：从接触面中点开始，沿 $-arrow(n)$ 方向（即垂直斜面向下）绘制矢量线段。
    + *添加辅助线*：在压力起始处绘制由 $arrow(u)$ 和 $arrow(n)$ 组成的局部折线，表示垂直符号（直角标记）。
    + *文本标注*：在相应位置标注物体名称 A、B 及力符号 $F$。
  ]
}
