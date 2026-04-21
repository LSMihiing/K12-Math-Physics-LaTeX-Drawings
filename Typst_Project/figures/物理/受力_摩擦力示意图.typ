// ============================================================
// 摩擦力受力示意图
// ============================================================

#import "@preview/cetz:0.4.2"
#import "../../lib/styles.typ": problem-title, solution, center-figure

#let render() = {
  problem-title("15", "摩擦力的受力示意图")

  text(size: 11pt)[
    如图所示，一铁块放在水平地面上，请画出当条形磁体靠近铁块时，铁块所受摩擦力的示意图。
  ]

  v(1.5em)

  center-figure[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      // 1. 画水平地面（带阴影）
      line((0, 0), (9, 0), stroke: 1.2pt)
      for i in range(46) {
        let x = i * 0.2
        line((x, 0), (x - 0.15, -0.2), stroke: 0.5pt)
      }

      // 2. 画铁块
      let bx = 1.0
      let bw = 1.5
      let bh = 1.0
      rect((bx, 0), (bx + bw, bh), stroke: 1pt, fill: white)
      // 铁块上方文字
      content((bx + bw/2, bh + 0.25), text(size: 10pt)[铁块])
      
      // 摩擦力的作用点 (贴着地面，处于铁块底边中心)
      let fx = bx + bw/2
      let fy = 0
      circle((fx, fy), radius: 0.05, fill: black)

      // 3. 画条形磁体
      let mx = 4.2
      let mw = 4.0
      let mh = 0.6
      // 左侧 N极（填充深灰色阴影）
      rect((mx, 0), (mx + mw/2, mh), stroke: 1pt, fill: luma(100))
      content((mx + mw/4, mh/2), text(fill: white, size: 11pt, weight: "bold")[N])
      
      // 右侧 S极（不填充留白）
      rect((mx + mw/2, 0), (mx + mw, mh), stroke: 1pt, fill: white)
      content((mx + 3*mw/4, mh/2), text(size: 11pt, weight: "bold", fill: black)[S])

      // 4. 画摩擦力示意图（黑实线）
      let force_len = 1.8 // 力箭头长度
      line((fx, fy), (fx - force_len, fy), 
           mark: (end: "stealth", fill: black), 
           stroke: 1.2pt + black)
           
      // 标注符号 f
      content((fx - force_len/2 - 0.5 , fy + 0.35), text(size: 11pt, style: "italic")[$f$])
    })
  ]

  v(1.5em)
  
  solution[
    *【题目分析】*
    在水平地面上的铁块受到条形磁体的磁力吸引，因而有着相对地面向右滑动（或运动）的趋势。在这个过程中，铁块受到的摩擦力是阻碍它相对地面向右滑动的阻力，因此摩擦力的方向必定是水平向左的。摩擦力的作用点可画在铁块的几何中心（重心）位置处。
    
    *【绘图步骤】*
    1. 绘制水平地面（带有等距倾斜的短线段），并在地面上绘制一个方框表示“铁块”，上方标注说明文字。
    2. 在铁块右方的水平地面上绘制一个狭长的矩形作为条形磁体。左半边用灰色或斜线阴影填充作为“N”极，右边留白作为“S”极，并在框内标注 N、S。
    3. 找到铁块底部中心，画一个实心小圆点表示受力作用点贴着地面。
    4. 从铁块底部中心位置起，沿地面的水平方向向左引出一条带有箭头的实线段（使用 "stealth" 箭头），在线的上方标注字母 $f$。

    *【绘图原理与细节】*
    1. *坐标系映射*：建立相对于画布基础水平原点 (y=0) 的绘图坐标，地面线固定为 `(0,0)` 到 `(9,0)`。利用范围遍历生成斜向阴影纹理，表示固定地面。
    2. *基础几何构成*：铁块和磁铁均采用 `rect` 绘制。为保证对比度，N端通过 `luma(100)`进行暗色填充，内部文字设为白色。
    3. *受力要素叠加*：在贴着地面的铁块底面中心 `(fx, fy)` 使用 `line` 与 `stealth` 箭头样式绘制摩擦力的实线箭头，确保其方向和受力点表达准确。
  ]
}
