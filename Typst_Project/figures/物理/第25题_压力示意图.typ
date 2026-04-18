// ============================================================
// 第25题 · 压力示意图（物块 A 对斜面）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[25.]
  text(size: 11pt)[如图所示，小木块 A 静止在粗糙斜面上，请画出它对斜面压力的示意图。]
  
  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let ox = 0.0
      let oy = 0.0
      
      // 1. 绘制斜面体
      let aw = 4.0
      let ah = 2.0
      // 顶点：(0,0), (aw, 0), (0, ah)
      line((ox, oy), (ox + aw, oy), (ox, oy + ah), close: true, stroke: 1pt + black)
      
      // 2. 绘制物块 A
      // 计算斜面参数
      let dx = aw
      let dy = -ah
      let d_len = calc.sqrt(dx*dx + dy*dy)
      let ux = dx / d_len
      let uy = dy / d_len
      // 法方向单位向量 (垂直斜面向外)
      // 注意：本项目中 atan2 顺序为 (x, y)，这里直接用向量旋转
      let nx = -uy
      let ny = ux
      
      // 物块 A 中心
      let mid_dist = d_len * 0.45
      let cx = ox + mid_dist * ux
      let cy = oy + ah + mid_dist * uy
      
      // 物块 A 尺寸
      let bw = 1.0
      let bh = 0.7
      
      // 顶点坐标
      let p1 = (cx - bw/2 * ux, cy - bw/2 * uy)
      let p2 = (cx + bw/2 * ux, cy + bw/2 * uy)
      let p3 = (p2.at(0) + bh * nx, p2.at(1) + bh * ny)
      let p4 = (p1.at(0) + bh * nx, p1.at(1) + bh * ny)
      
      line(p1, p2, p3, p4, close: true, fill: none, stroke: 1pt + black)
      content((cx + 0.4 * nx, cy + 0.4 * ny), [A])
      
      // 3. 绘制压力 F
      // 作用点：接触面中点 (cx, cy)
      // 方向：垂直于斜面向下 (即 -n 方向)
      let f_len = 1.2
      line((cx, cy), (cx - f_len * nx, cy - f_len * ny), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
      
      // 4. 标注
      content((cx - f_len * nx + 0.4, cy - f_len * ny + 0.1))[ $F$ ]
      
      // 直角符号
      let r_size = 0.2
      line(
        (cx - r_size * ux, cy - r_size * uy),
        (cx - r_size * ux - r_size * nx, cy - r_size * uy - r_size * ny),
        (cx - r_size * nx, cy - r_size * ny),
        stroke: 0.5pt + black
      )

      // 标注图名
      content((ox + aw/2, oy - 1.2), text(size: 10pt, fill: blue.darken(20%))[（第 25 题图）])
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
    1. *压力的定义*：压力是垂直作用在物体表面上的力。本题要求画出物体 A 对斜面的压力。
    2. *三要素确定*：
       - *作用点*：压力作用在受力物体（斜面）上，作用点画在接触面的中心。
       - *方向*：垂直于接触面（斜面），并指向受力物体内部。
       - *大小*：用字母 $F$ 表示。

    绘图时，从接触面中点开始，沿垂直于斜面向下的方向画一条带箭头的线段，并标注 $F$。
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

    + *构建斜面*：使用 `line` 函数绘制一个直角三角形，直角位于左下角，定义斜面斜率。
    + *绘制物块*：根据斜面单位向量和法向量，计算矩形物块 A 的四个顶点坐标并绘制。
    + *确定作用点*：作用点位于物块与斜面接触线的中点。
    + *绘制压力矢量*：从作用点出发，沿法向量的反方向（垂直斜面向下）绘制带箭头的线段。
    + *添加标注*：绘制直角标记符号以表示垂直关系，并标注物体名称 A 和力符号 $F$。
  ]
}
