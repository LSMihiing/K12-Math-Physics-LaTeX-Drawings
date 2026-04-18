// ============================================================
// 第3题 · 分数涂色与比较大小
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
// 这三组画布
// ==========================================

// 第一组：正方形
#let figure-1 = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  let w = 3 // 设定正方形全局基准边长
  let h_mid = w / 2 // 四宫格跨度
  let third = w / 3 // 九宫格跨度
  
  // 1/4 正方形
  group(name: "sq1", {
    let dx = 0
    let dy = 0
    // 底层虚线基于变量运算切割
    line((dx, dy + h_mid), (dx + w, dy + h_mid), stroke: grid-dash)
    line((dx + h_mid, dy), (dx + h_mid, dy + w), stroke: grid-dash)
    // 涂色 1 份
    rect((dx, dy + h_mid), (dx + h_mid, dy + w), fill: fill-color, stroke: none)
    // 图形边框
    rect((dx, dy), (dx + w, dy + w), stroke: grid-stroke)
  })

  // 1/9 正方形
  group(name: "sq2", {
    let dx = 4
    let dy = 0
    // 底层虚线基于变量循环剖分
    for i in (1, 2) {
      line((dx, dy + i * third), (dx + w, dy + i * third), stroke: grid-dash)
      line((dx + i * third, dy), (dx + i * third, dy + w), stroke: grid-dash)
    }
    // 涂色 1 份
    rect((dx, dy + 2 * third), (dx + third, dy + w), fill: fill-color, stroke: none)
    // 图形边框
    rect((dx, dy), (dx + w, dy + w), stroke: grid-stroke)
  })

  // 标记与符号
  content((1.5, y-txt), [#text(size: text-sz)[$frac(1, 4)$]])
  circle((3.5, y-txt), radius: 0.5, stroke: 0.8pt + luma(100))
  content((3.5, y-txt), [#text(size: cmp-sz)[$>$]])
  content((5.5, y-txt), [#text(size: text-sz)[$frac(1, 9)$]])
})

// 第二组：菱形
#let figure-2 = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  let r = 1.5 // 菱形外接全宽的中心轴半径
  let m = r / 2 // 对边中线由于斜率为±1，投影长度有严格的 r/2 解析结果
  
  // 1/8 菱形
  group(name: "d1", {
    let dx = 1.5
    let dy = 1.5
    // 底层对角和中线虚线（彻底弃用硬编码坐标，保证严格闭环于对应节点）
    line((dx - r, dy), (dx + r, dy), stroke: grid-dash)
    line((dx, dy - r), (dx, dy + r), stroke: grid-dash)
    line((dx - m, dy - m), (dx + m, dy + m), stroke: grid-dash)
    line((dx - m, dy + m), (dx + m, dy - m), stroke: grid-dash)
    // 涂色 1 份
    line((dx, dy), (dx, dy + r), (dx - m, dy + m), close: true, fill: fill-color, stroke: none)
    // 菱形边框
    line((dx, dy + r), (dx + r, dy), (dx, dy - r), (dx - r, dy), close: true, stroke: grid-stroke)
  })

  // 1/2 菱形
  group(name: "d2", {
    let dx = 5.5
    let dy = 1.5
    // 底层横贯线（变量级等长约束）
    line((dx - r, dy), (dx + r, dy), stroke: grid-dash)
    // 涂色 1 份
    line((dx - r, dy), (dx, dy + r), (dx + r, dy), close: true, fill: fill-color, stroke: none)
    // 菱形边框
    line((dx, dy + r), (dx + r, dy), (dx, dy - r), (dx - r, dy), close: true, stroke: grid-stroke)
  })

  // 标记与符号
  content((1.5, y-txt), [#text(size: text-sz)[$frac(1, 8)$]])
  circle((3.5, y-txt), radius: 0.5, stroke: 0.8pt + luma(100))
  content((3.5, y-txt), [#text(size: cmp-sz)[$<$]])
  content((5.5, y-txt), [#text(size: text-sz)[$frac(1, 2)$]])
})

// 第三组：圆形
#let figure-3 = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  let r = 1.6 // 圆半径稍微撑饱满一点

  // 1/6 图
  group(name: "c1", {
    let dx = 1.5
    let dy = 1.5
    // 画 6等分虚线
    for angle in (30deg, 90deg, 150deg) {
      line(
        (dx + r * calc.cos(angle), dy + r * calc.sin(angle)),
        (dx + r * calc.cos(angle + 180deg), dy + r * calc.sin(angle + 180deg)),
        stroke: grid-dash,
      )
    }
    // 涂色 1 份（左上扇形）
    let start-pt = (dx + r * calc.cos(90deg), dy + r * calc.sin(90deg))
    arc(start-pt, start: 90deg, stop: 150deg, radius: r, mode: "PIE", fill: fill-color, stroke: none)
    // 划圆轮廓
    circle((dx, dy), radius: r, stroke: grid-stroke)
  })

  // 1/3 图
  group(name: "c2", {
    let dx = 5.5
    let dy = 1.5
    // 画 3等分虚线 (90度, 210度, 330度 发散)
    for angle in (90deg, 210deg, 330deg) {
      line((dx, dy), (dx + r * calc.cos(angle), dy + r * calc.sin(angle)), stroke: grid-dash)
    }
    // 涂色 1 份（左侧大扇形）
    let start-pt = (dx + r * calc.cos(90deg), dy + r * calc.sin(90deg))
    arc(start-pt, start: 90deg, stop: 210deg, radius: r, mode: "PIE", fill: fill-color, stroke: none)
    // 划圆轮廓
    circle((dx, dy), radius: r, stroke: grid-stroke)
  })

  // 标记与符号
  content((1.5, y-txt), [#text(size: text-sz)[$frac(1, 6)$]])
  circle((3.5, y-txt), radius: 0.5, stroke: 0.8pt + luma(100))
  content((3.5, y-txt), [#text(size: cmp-sz)[$<$]])
  content((5.5, y-txt), [#text(size: text-sz)[$frac(1, 3)$]])
})

// ==========================================
// 输出：题目解答与组合图表
// ==========================================
#let render() = {
  set par(first-line-indent: 0em)

  // 解答块
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + rgb("#4A90D9")),
    fill: rgb("#F0F6FF"),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: rgb("#4A90D9"), size: 11pt)[解答]
    #v(0.4em)

    分析上面三组图形：

    （1）第一组是两个面积相等的正方形。
    左图被平均分成了 $4$ 份，涂色部分应当占据 $1$ 份（即 $1/4$）；右图被平均分成了 $9$ 份，涂色部分应当占据 $1$ 份（即 $1/9$）。
    显然，平均分的份数越多，每一小份的面积就越小。所以 $1/4 > 1/9$。

    （2）第二组是两个面积相等的菱形。
    左图被平均分成了 $8$ 份，涂色部分占据 $1$ 份（即 $1/8$）；右图被平均分成了 $2$ 份，涂色部分占据 $1$ 份（即 $1/2$）。
    由于分成两份的单份面积远大于分成八份的单份部分面积，所以 $1/8 < 1/2$。

    （3）第三组是两个面积相等的圆形。
    左图被平均分成了 $6$ 份，涂色部分占据 $1$ 份（即 $1/6$）；右图被平均分成了 $3$ 份，涂色部分占据 $1$ 份（即 $1/3$）。
    同理，分成三份的单扇形面积远大于分成六份的小扇形，所以 $1/6 < 1/3$。
  ]

  v(1.5em)

  // 图形展示区
  align(center)[
    // 使用网格使三组图左右等距一字排开对齐
    #grid(
      columns: 3,
      column-gutter: 2.5em,
      figure-1, figure-2, figure-3,
    )
    #v(0.5em)
    #text(size: 9pt, fill: luma(100))[（第 3 题 分数涂色比较示意图）]
  ]

  v(1.5em)

  // 绘图原理与步骤
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与步骤]
    #v(0.4em)

    - 画板列阵：为达到答题原图的排版，采用 `grid` 网格使正方形组、菱形组、圆形组呈 $3$ 列左右排列铺开。各画板内按 $0.5$cm 长度基准渲染。
    - 第一组（正方形）：基础构图为 $3 times 3$ 的边框。分别运用数学虚线打底绘制出 $2 times 2$ （四宫格）以及 $3 times 3$ （九宫格）。在坐标左上方区域铺设深蓝色实心渲染物。
    - 第二组（菱形）：利用 45 度偏转的正方形锚定点。左图切割为 8 块，使用 $cos(45 degree)$ 推导计算并刻画双对角线和横纵剖线；右图单线切割成 2 半，为上半三角填色。
    - 第三组（圆形）：利用三角函数与不同发散角组（左侧步进 $60 degree$ 切割，右侧倒 `Y` 型夹角按 $120 degree$ 切割），搭配 `mode: "PIE"` 的圆弧填涂工具，画出严丝合缝的扇贝形态。
    - 样式和标记：同步了原题干中的青蓝色（`color: #4FC3F7`）；在所有组列底部中心采用 `$frac(num, den)$` 语句打出标准垂直分数格式，并生成中心包围比较符的大空心圆圈。
  ]
}
