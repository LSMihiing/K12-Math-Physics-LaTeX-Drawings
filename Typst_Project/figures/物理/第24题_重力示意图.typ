// ============================================================
// 第24题 · 重力示意图（足球）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[24.]
  text(size: 11pt)[如图所示为空中飞行的足球，请画出足球所受重力的示意图。]
  
  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let ox = 0.0
      let oy = 0.0
      
      // 1. 绘制虚线轨迹 (仅保留上升部分的左半边)
      // 轨迹穿过球心，但球体填充为白色以遮挡背景线
      bezier((ox - 1.8, oy - 1.2), (ox + 0.8, oy + 0.5), (ox - 0.4, oy + 0.5), stroke: (dash: "dashed", paint: luma(100)))
      
      // 2. 绘制足球 (空心白球，遮挡轨迹)
      // 位于轨迹路径上，遮挡其经过球心部分
      let ball_pos = (ox, oy + 0.2)
      circle(ball_pos, radius: 0.35, fill: white, stroke: 1pt + black)
      
      // 3. 绘制重力 G
      // 作用点：重心（球心）
      // 方向：竖直向下
      let g_len = 1.5
      line(ball_pos, (ball_pos.at(0), ball_pos.at(1) - g_len), mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
      
      // 4. 标注
      content((ball_pos.at(0) + 0.4, ball_pos.at(1) - g_len + 0.3))[ $G$ ]
      
      // 标注图名
      content((ox, oy - 1.8), text(size: 10pt, fill: blue.darken(20%))[（第 24 题图）])
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
    1. *力的分析*：足球在空中飞行时，若忽略空气阻力，只受到重力的作用。
    2. *三要素确定*：
       - *作用点*：重力的作用点在物体的重心，对于形状规则、质量分布均匀的足球，重心在球心。
       - *方向*：重力的方向始终是竖直向下的。
       - *大小*：题目未给出质量，用字母 $G$ 表示即可。

    绘图时，从球心开始，沿竖直向下的方向画一条带箭头的线段，并标上字母 $G$。
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

    + *绘制轨迹*：使用 `bezier` 函数绘制一段虚线曲线，模拟足球的飞行路径。
    + *绘制物体*：在曲线上方选定一点作为球心，使用 `circle` 函数绘制圆表示足球。
    + *绘制受力*：确定作用点为球心坐标，利用 `line` 函数向下方绘制垂直于水平线的矢量箭头。
    + *添加标注*：在箭头末端附近使用 `content` 函数标注力符号 $G$。
  ]
}
