// ============================================================
// 第20题 · 家庭电路绘制
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  
  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[20.]
  text(size: 11pt)[ 小明的新书房缺少了一盏用开关控制的照明灯和一个可连接电扇的插座，请在图中为小明设计一个完整的电路。]

  v(2.0em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let caption-color = rgb(88, 166, 216)
      let ans-color = black // 解答所画的线使用黑色，与题干一致

      // 坐标体系：
      // 火线 (y=1.2), 零线 (y=0)
      // 横向范围大致 -2 到 8
      
      // 1. 题干已知元素
      group(name: "original", {
        // 导线
        line((-0.5, 1.2), (7.5, 1.2), stroke: 1pt + black)
        content((-1.6, 1.2), text(size: 14pt, weight: "bold")[火线])
        
        line((-0.5, 0.0), (7.5, 0.0), stroke: 1pt + black)
        content((-1.6, 0.0), text(size: 14pt, weight: "bold")[零线])

        // 开关 (x=2.5)
        line((2.5, -0.6), (2.5, -1.2), stroke: 1pt + black) // 上引线段
        line((2.5, -1.8), (3.1, -0.6), stroke: 1pt + black) // 开关闸刀
        line((2.5, -1.8), (2.5, -3.5), stroke: 1pt + black) // 下引线段

        // 电灯 (x=0, y=-2.5)
        let lamp-r = 0.5
        circle((0.0, -2.5), radius: lamp-r, stroke: 1.2pt + black)
        // 灯泡内部的叉
        line((-lamp-r * 0.707, -2.5 + lamp-r * 0.707), (lamp-r * 0.707, -2.5 - lamp-r * 0.707), stroke: 1pt + black)
        line((-lamp-r * 0.707, -2.5 - lamp-r * 0.707), (lamp-r * 0.707, -2.5 + lamp-r * 0.707), stroke: 1pt + black)

        // 两孔插座 (x=5.5)
        rect((4.7, -3.1), (6.3, -1.8), stroke: 1.2pt + black)
        rect((5.1, -2.6), (5.3, -2.3), stroke: 1pt + black) // 左孔
        rect((5.7, -2.6), (5.9, -2.3), stroke: 1pt + black) // 右孔

        // 第 20 题 文字
        content((2.5, -4.2))[ #text(fill: caption-color, size: 14pt)[（第 20 题）] ]
      })

      // 2. 解答连线
      group(name: "answer", {
        // 规定连线样式
        let ans-stroke = 1.0pt + ans-color
        let dot-r = 0.08
        
        // （1）灯的连接：开关下引线 -> 灯底端；灯顶端 -> 零线
        line((2.5, -3.5), (0.0, -3.5), stroke: ans-stroke) // 开关到灯底端
        //line((2.5, -3.0), (0.0, -3.0), stroke: ans-stroke) 
        line((0, -3), (0, -3.5), stroke: 1pt + black)
        line((0.0, -2.0), (0.0, 0.0), stroke: ans-stroke)  // 灯顶端到零线
        circle((0.0, 0.0), radius: dot-r, fill: ans-color, stroke: none) // 连接点
        
        // （2）开关连接：开关顶端 -> 火线
        line((2.5, -0.6), (2.5, 1.2), stroke: ans-stroke)
        circle((2.5, 1.2), radius: dot-r, fill: ans-color, stroke: none) // 连接点

        // （3）插座连接：左孔 -> 零线，右孔 -> 火线
        // 从插座触点中心直接引出
        let s-left-x = 5.2
        let s-right-x = 5.8
        let s-contact-y = -2.45

        line((s-left-x, s-contact-y), (s-left-x, 0), stroke: ans-stroke)
        circle((s-left-x, 0.0), radius: dot-r, fill: ans-color, stroke: none) // 左孔到零线连接点

        line((s-right-x, s-contact-y), (s-right-x, 1.2), stroke: ans-stroke)
        circle((s-right-x, 1.2), radius: dot-r, fill: ans-color, stroke: none) // 右孔到火线连接点，跨过零线不画点
      })
    })
  ]

  v(1.8em)

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
    
    + *基本连线原则*：
      - *电灯与开关*：火线必须先经过开关，然后再连接到电灯的内部触点（通常画作一端）；电灯的另一端必须直接连接到零线。这样确保开关断开时电灯与火线隔离，保证更换的安全。
      - *两孔插座*：遵循“左零右火”的规程进行接线。
      - *交点规范*：相连的导线交叉处必须画实心圆点，相交叉但不相干的导线处不画圆点以示悬空跨越。
    + *绘制电灯路径*：从开关上方的垂线部分竖直向上画线跨越零线（不加点）连接到火线，画实心黑点表示连接。从开关下方的垂线处水平向左画直线，连接到电灯的正下方边界点（底端）；由电灯正上方边界点竖直向上画线连接到零线，并画上实心连接点。
    + *绘制插座路径*：从插座两个触点的中心直接引线。左侧触点竖直向上连接至零线，并在零线上画实心黑点；右侧触点竖直向上连接至火线，跨过零线时不在零线上画点，在火线上画实心黑点完成闭合。
  ]
}
