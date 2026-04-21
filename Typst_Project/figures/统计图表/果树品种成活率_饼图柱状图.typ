// ============================================================
// 果树品种成活率统计（饼图 + 柱状图）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[4. ]
  text(size: 11pt)[某生态示范园要对 1 号、2 号、3 号、4 号四个品种共 500 株果树幼苗进行成活试验，从中选出成活率高的品种进行推广。通过试验得知，3 号果树幼苗成活率为 89.6%。试验员把试验数据绘制成下列两幅统计图（部分信息未给出）：]
  
  v(1.5em)

  // --- 绘图区域 ---
  grid(
    columns: (1.2fr, 1.5fr),
    gutter: 20pt,
    // 1. 饼图
    align(center + bottom)[
      #cetz.canvas(length: 1cm, {
        import cetz.draw: *
        let r = 1.8

        // 使用真正的扇形填充方式绘制标准扇形统计图。
        let sectors = (
          (
            start: -18deg,
            stop: 90deg,
            label-angle: 36deg,
            label-radius: r * 0.62,
            text: [1 号\ 30%],
          ),
          (
            start: -90deg,
            stop: -18deg,
            label-angle: -54deg,
            label-radius: r * 0.68,
            text: [2 号\ 20%],
          ),
          (
            start: 180deg,
            stop: 270deg,
            label-angle: 225deg,
            label-radius: r * 0.62,
            text: [3 号\ 25%],
          ),
          (
            start: 90deg,
            stop: 180deg,
            label-angle: 135deg,
            label-radius: r * 0.62,
            text: [4 号\ 25%],
          ),
        )

        for sector in sectors {
          let start-point = (
            r * calc.cos(sector.start),
            r * calc.sin(sector.start),
          )

          arc(
            start-point,
            start: sector.start,
            stop: sector.stop,
            radius: r,
            mode: "PIE",
            fill: white,
            stroke: 1pt + black,
          )

          content(
            (
              sector.label-radius * calc.cos(sector.label-angle),
              sector.label-radius * calc.sin(sector.label-angle),
            ),
            align(center)[#text(size: 8pt)[#sector.text]],
          )
        }
        
        content((0, -r - 0.8), text(size: 9pt, weight: "bold")[500 株幼苗中各品种幼苗数\ 所占百分比统计图])
      })
    ],
    // 2. 柱状图
    align(center + bottom)[
      #cetz.canvas(length: 1cm, {
        import cetz.draw: *
        
        let w = 6.0
        let h = 4.0
        let sx = 1.2
        let sy = h / 150
        
        // 坐标轴
        line((0, 0), (w, 0), mark: (end: "stealth", fill: black)) // X轴
        line((0, 0), (0, h + 0.5), mark: (end: "stealth", fill: black)) // Y轴
        
        // 刻度与网格线
        for y in (50, 100, 150) {
          let yp = y * sy
          line((-0.1, yp), (0, yp), stroke: 0.5pt + black)
          content((-0.4, yp), text(size: 8pt)[#y])
        }
        content((-0.2, -0.2), text(size: 8pt)[0])
        content((-0.8, h + 0.8), text(size: 9pt)[成活数/株])
        content((w - 0.2, -0.4), text(size: 9pt)[品种])
        
        // 绘制柱状图 (1号: 135, 2号: 85, 3号: 112, 4号: 117)
        let bar-data = (135, 85, 112, 117)
        let bar-w = 0.5
        
        for (i, val) in bar-data.enumerate() {
          let x = (i + 1) * sx
          let yp = val * sy
          
          // 3号原本缺失，在解答中补全，这里用虚线边框区分或直接实线绘制
          let stroke-style = if i == 2 { 1pt + blue } else { 1pt + black }
          let fill-color = if i == 2 { blue.lighten(80%) } else { luma(200) }
          
          rect((x - bar-w/2, 0), (x + bar-w/2, yp), fill: fill-color, stroke: stroke-style)
          content((x, yp + 0.3), text(size: 8pt, fill: if i == 2 { blue.darken(20%) } else { black })[#val])
          content((x, -0.4), text(size: 9pt)[#{i+1}号])
        }
        
        content((w/2, -1.5), text(size: 9pt, weight: "bold")[各品种幼苗成活数统计图])
      })
    ]
  )

  v(2.5em)

  // --- 解答部分 ---
  let answer-style(body) = text(fill: blue.darken(20%), weight: "bold", body)
  
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + rgb(31, 120, 180)),
    fill: rgb(245, 250, 255),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb(31, 120, 180), size: 10pt)[【解析与解答】]
    #v(0.3em)
    #set text(size: 10pt)
    
    （1）由饼图可知，2 号幼苗所占百分比为：$1 - 30% - 25% - 25% = 20%$。\
    试验所用的 2 号果树幼苗的数量是：$500 times 20% = $ #answer-style[100] 株。

    （2）3 号果树幼苗的总数为：$500 times 25% = 125$ 株。\
    已知其成活率为 89.6%，则 3 号果树幼苗的成活数为：$125 times 89.6% = $ #answer-style[112] 株。\
    *（统计图补全见上方蓝色柱状部分）*

    （3）各品种成活率计算如下：\
    - 1 号成活率：$135 / (500 times 30%) = 135 / 150 = 90%$；\
    - 2 号成活率：$85 / (500 times 20%) = 85 / 100 = 85%$；\
    - 3 号成活率：#answer-style[89.6%]（已知）；\
    - 4 号成活率：$117 / (500 times 25%) = 117 / 125 = 93.6%$。\
    因为 $93.6% > 90% > 89.6% > 85%$，所以应选 #answer-style[4 号] 品种进行推广。
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

    + *统计图关联*：通过饼图百分比计算出各品种基数（150, 100, 125, 125），结合成活率数据补全柱状图缺失值（3号为 112）。
    + *饼图绘制*：按各品种所占百分比换算圆心角，依次绘制 4 个标准扇形，并将标签放在对应扇形的中部位置。
    + *柱状图绘制*：
      - 建立标准直角坐标系，Y 轴按 50 为间距设置刻度。
      - 使用 `rect` 绘制柱体，填充色采用灰色（luma 200）。
      - 为区分补全部分，3 号柱体使用蓝色边框和浅蓝填充，并在顶部标注计算结果 112。
    + *布局对齐*：使用 `grid` 容器将两幅统计图水平并排，下方居中放置图名。
  ]
}
