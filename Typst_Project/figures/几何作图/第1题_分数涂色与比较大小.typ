// ============================================================
// 第1题 · 先按照分数涂色，再比较每组分数的大小
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 公共参数与样式
// ==========================================
#let grid-color = rgb("#4FC3F7") // 浅青蓝色线框
#let grid-stroke = 0.8pt + grid-color
#let grid-dash = (paint: grid-color, thickness: 0.8pt, dash: (2.5pt, 2pt))
#let fill-color = rgb("#005DB9") // 深蓝色涂填

#let text-sz = 14pt
#let cmp-sz = 13pt
#let y-txt = -1.6 // 分数字体下沉量

// ==========================================
// 此三组比较画布区
// ==========================================

// 第一组：圆形组
#let figure-1 = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  let r = 1.6 // 圆半径稍微撑饱满一点

  // 图一：1/4
  group(name: "c1", {
    let dx = 1.5
    let dy = 1.5
    // 画 4等分虚线 (十字交叉)
    line((dx - r, dy), (dx + r, dy), stroke: grid-dash)
    line((dx, dy - r), (dx, dy + r), stroke: grid-dash)
    
    // 涂色 1 份（左上象限）
    let start-pt = (dx + r * calc.cos(90deg), dy + r * calc.sin(90deg))
    arc(start-pt, start: 90deg, stop: 180deg, radius: r, mode: "PIE", fill: fill-color, stroke: none)
    
    // 画外框轮廓
    circle((dx, dy), radius: r, stroke: grid-stroke)
  })

  // 图二：1/6
  group(name: "c2", {
    let dx = 5.5
    let dy = 1.5
    // 画 6等分虚线 (按 30度 90度 150度方向的全局长线)
    for angle in (90deg, 30deg, 150deg) {
      line(
        (dx + r * calc.cos(angle), dy + r * calc.sin(angle)),
        (dx + r * calc.cos(angle + 180deg), dy + r * calc.sin(angle + 180deg)),
        stroke: grid-dash,
      )
    }
    // 涂色 1 份（提取右上角 30度~90度方位）
    let start-pt = (dx + r * calc.cos(30deg), dy + r * calc.sin(30deg))
    arc(start-pt, start: 30deg, stop: 90deg, radius: r, mode: "PIE", fill: fill-color, stroke: none)
    
    // 画外框轮廓
    circle((dx, dy), radius: r, stroke: grid-stroke)
  })

  // 分数、比较符标注
  content((1.5, y-txt), [#text(size: text-sz)[$frac(1, 4)$]])
  circle((3.5, y-txt), radius: 0.5, stroke: 0.8pt + luma(100))
  content((3.5, y-txt), [#text(size: cmp-sz)[$>$]])
  content((5.5, y-txt), [#text(size: text-sz)[$frac(1, 6)$]])
})

// 第二组：等边三角形组
#let figure-2 = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  let r = 1.8 // 三角形外围接圆半径

  // 图一：2/6
  group(name: "t1", {
    let dx = 1.5
    let dy = 1.2
    
    let a = (dx + 0, dy + r)
    let b = (dx - r * calc.cos(30deg), dy - r * calc.sin(30deg))
    let c = (dx + r * calc.cos(30deg), dy - r * calc.sin(30deg))
    
    let bc_mid = (dx, dy - r * calc.sin(30deg))
    let ac_mid = (dx + r * calc.cos(30deg) / 2, dy + (r - r * calc.sin(30deg)) / 2)
    let ab_mid = (dx - r * calc.cos(30deg) / 2, dy + (r - r * calc.sin(30deg)) / 2)
    
    // 中位线打底
    line(a, bc_mid, stroke: grid-dash)
    line(b, ac_mid, stroke: grid-dash)
    line(c, ab_mid, stroke: grid-dash)
    
    // 涂色 2 份：连接重心与顶部及两旁中点构成的钻石型小块
    let o = (dx, dy)
    line(o, a, ab_mid, close: true, fill: fill-color, stroke: none)
    line(o, a, ac_mid, close: true, fill: fill-color, stroke: none)
    
    // 三角形外框
    line(a, b, c, close: true, stroke: grid-stroke)
  })

  // 图二：1/6
  group(name: "t2", {
    let dx = 5.5
    let dy = 1.2
    
    let a = (dx + 0, dy + r)
    let b = (dx - r * calc.cos(30deg), dy - r * calc.sin(30deg))
    let c = (dx + r * calc.cos(30deg), dy - r * calc.sin(30deg))
    
    let bc_mid = (dx, dy - r * calc.sin(30deg))
    let ac_mid = (dx + r * calc.cos(30deg) / 2, dy + (r - r * calc.sin(30deg)) / 2)
    let ab_mid = (dx - r * calc.cos(30deg) / 2, dy + (r - r * calc.sin(30deg)) / 2)
    
    // 中位线打底
    line(a, bc_mid, stroke: grid-dash)
    line(b, ac_mid, stroke: grid-dash)
    line(c, ab_mid, stroke: grid-dash)
    
    // 涂色仅 1 份：重心与顶部和右侧中点构成的小三角
    let o = (dx, dy)
    line(o, a, ac_mid, close: true, fill: fill-color, stroke: none)
    
    // 三角形外框
    line(a, b, c, close: true, stroke: grid-stroke)
  })

  // 分数、比较符标注
  content((1.5, y-txt), [#text(size: text-sz)[$frac(2, 6)$]])
  circle((3.5, y-txt), radius: 0.5, stroke: 0.8pt + luma(100))
  content((3.5, y-txt), [#text(size: cmp-sz)[$>$]])
  content((5.5, y-txt), [#text(size: text-sz)[$frac(1, 6)$]])
})

// 第三组：正方形九宫格组
#let figure-3 = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  let w = 3 // 矩阵外框全局尺寸
  let third = w / 3 // 单格尺度
  
  // 图一：5/9 
  group(name: "sq1", {
    let dx = 0
    let dy = 0
    // 画基础网格（2纵2横虚线）
    for i in (1, 2) {
      line((dx, dy + i * third), (dx + w, dy + i * third), stroke: grid-dash)
      line((dx + i * third, dy), (dx + i * third, dy + w), stroke: grid-dash)
    }
    // 填涂 5 格：首行填满3格，次行填2格
    rect((dx, dy + 2 * third), (dx + w, dy + w), fill: fill-color, stroke: none)
    rect((dx, dy + 1 * third), (dx + 2 * third, dy + 2 * third), fill: fill-color, stroke: none)
    
    // 正方形包围边框
    rect((dx, dy), (dx + w, dy + w), stroke: grid-stroke)
  })

  // 图二：4/9
  group(name: "sq2", {
    let dx = 4
    let dy = 0
    // 画基础网格（2纵2横虚线）
    for i in (1, 2) {
      line((dx, dy + i * third), (dx + w, dy + i * third), stroke: grid-dash)
      line((dx + i * third, dy), (dx + i * third, dy + w), stroke: grid-dash)
    }
    // 填涂 4 格：首行填满3格，次行填1格
    rect((dx, dy + 2 * third), (dx + w, dy + w), fill: fill-color, stroke: none)
    rect((dx, dy + 1 * third), (dx + 1 * third, dy + 2 * third), fill: fill-color, stroke: none)
    
    // 正方形包围边框
    rect((dx, dy), (dx + w, dy + w), stroke: grid-stroke)
  })

  // 分数、比较符标注
  content((1.5, y-txt), [#text(size: text-sz)[$frac(5, 9)$]])
  circle((3.5, y-txt), radius: 0.5, stroke: 0.8pt + luma(100))
  content((3.5, y-txt), [#text(size: cmp-sz)[$>$]])
  content((5.5, y-txt), [#text(size: text-sz)[$frac(4, 9)$]])
})

// ==========================================
// 输出渲染主函数
// ==========================================
#let render() = {
  v(1em)

  // 1. 图形展示画布区
  align(center)[
    // 使用并列网格布局等距一字排开三个画板
    #grid(
      columns: 3,
      column-gutter: 2.5em,
      figure-1, figure-2, figure-3,
    )
  ]

  v(1.5em)

  // 2. 详细绘图原理解析
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与大小比较步骤]
    #v(0.4em)

    - *分步着色思想（做分子设计）*：
      第一组：将同样的圆形分成了 $4$ 份和 $6$ 份，图一为其涂装 $1$ 个象限扇形块，图二为其涂装 $1$ 个三十度扇形极角区块。
      第二组：等分后拥有 6 个单元三角形，图一沿顶点对称着色 $2$ 份构造“全等四边形”，图二单色敷印 $1$ 份构成“对勾小三角形”。
      第三组：标准的九宫格，左边取满一栏加两格等于 $5$，右边满一栏加一格等于 $4$。

    - *视觉推导大于与小于比较*：
      通过 CeTZ 画布几何级的严丝合缝对比，对于分母相等的数值：由于份数一样，取的分子份数越多整体值也就越大（如 $2/6 > 1/6$；$5/9 > 4/9$）。而分子相同的情况时，图块被分割的越碎小，单份的值越小（如 $1/4 > 1/6$）。

    - *参数实现与排版*：
      这套绘图体系里分别使用了圆方程投影计算交线、三角函数映射重心求作三线合一交点、二维循环栅格嵌套等算法精确还原了图形。外部以 `grid(columns: 3)` 并用固定的 $2.5$em gutter 将三族对比画板实现了教辅规格的无断点平行横排对齐。使用单星号包裹文本以避免产生过往冗余的 Markdown Warning。
  ]
}
