// ============================================================
// 电路图绘制（电动机+滑动变阻器）
// ============================================================
//
// 题目：请用笔画线代替导线把图(a)所示的实物连接起来，
//       要求滑动变阻器的滑片向左移动时，电动机的转动速度变大，
//       并在图(b)的虚线框内画出对应的电路图。
//
// 电路分析：
// ────────────────
// 元件：电源（电池组）、开关 S、电动机 M、滑动变阻器 R
// 连接方式：串联电路
// 滑片左移 → 速度变大 → 电流增大 → 接入电阻减小
// → 需连接滑动变阻器的左端接线柱和滑片接线柱
//
// 电路图布局（矩形回路）：
//     ┌──S──────┐
//     │          │
//     E          M
//     │          │
//     └────R─────┘
// ────────────────

#import "@preview/cetz:0.4.2"

// ==========================================
// 电路图
// ==========================================
#let circuit-diagram = cetz.canvas(length: 0.8cm, {
  import cetz.draw: *

  // 电路主色
  let wire-stroke = 0.8pt + black
  let symbol-stroke = 1pt + black

  // --- 矩形回路坐标 ---
  // 左下 (0,0)，右下 (6,0)，右上 (6,4)，左上 (0,4)
  let x-left = 0
  let x-right = 6
  let y-bottom = 0
  let y-top = 4

  // ===== 顶边：开关 S =====
  // 开关位于顶边中部，x = 2 到 x = 4
  let sw-x1 = 2
  let sw-x2 = 4
  // 左上角 → 开关左端
  line((x-left, y-top), (sw-x1, y-top), stroke: wire-stroke)
  // 开关符号：斜线闸刀（无圆点）
  line((sw-x1, y-top), (sw-x2 - 0.2, y-top + 0.5), stroke: symbol-stroke) // 闸刀
  // 开关右端 → 右上角
  line((sw-x2, y-top), (x-right, y-top), stroke: wire-stroke)
  // 标签 S
  content(((sw-x1 + sw-x2) / 2, y-top + 0.8))[#text(size: 10pt)[$S$]]

  // ===== 左边：电源（简化两线形式） =====
  let bat-mid = 2.0
  let bat-gap = 0.25
  let bat-top-y = bat-mid + bat-gap / 2 // 长线（正极）
  let bat-bot-y = bat-mid - bat-gap / 2 // 短线（负极）
  // 左上角 → 电源正极
  line((x-left, y-top), (x-left, bat-top-y), stroke: wire-stroke)
  // 电源符号：一长一短两条横线
  line((x-left - 0.4, bat-top-y), (x-left + 0.4, bat-top-y), stroke: 1.5pt + black) // 长线（正极）
  line((x-left - 0.2, bat-bot-y), (x-left + 0.2, bat-bot-y), stroke: 1.5pt + black) // 短线（负极）
  // 电源下端 → 左下角
  line((x-left, bat-bot-y), (x-left, y-bottom), stroke: wire-stroke)
  // 正负极标签
  content((x-left - 0.6, bat-top-y + 0.1))[#text(size: 8pt)[$+$]]
  content((x-left - 0.6, bat-bot-y - 0.1))[#text(size: 8pt)[$-$]]

  // ===== 右边：电动机 M =====
  // 电动机位于右边中部，圆形符号
  let motor-y = 2
  let motor-r = 0.5
  // 右上角 → 电动机上端
  line((x-right, y-top), (x-right, motor-y + motor-r), stroke: wire-stroke)
  // 电动机符号：圆 + M
  circle((x-right, motor-y), radius: motor-r, stroke: symbol-stroke)
  content((x-right, motor-y))[#text(size: 10pt, weight: "bold")[$M$]]
  // 电动机下端 → 右下角
  line((x-right, motor-y - motor-r), (x-right, y-bottom), stroke: wire-stroke)

  // ===== 底边：滑动变阻器 R =====
  // 变阻器位于底边中部，x = 1.5 到 x = 4.5
  // 滑片从上方接入电路（T 形接法）
  let rh-x1 = 1.5
  let rh-x2 = 4.5
  let rh-h = 0.4
  let rh-y-top = y-bottom + rh-h / 2
  let rh-y-bot = y-bottom - rh-h / 2
  // 左下角 → 变阻器左端
  line((x-left, y-bottom), (rh-x1, y-bottom), stroke: wire-stroke)
  // 变阻器符号：矩形
  rect(
    (rh-x1, rh-y-bot),
    (rh-x2, rh-y-top),
    stroke: symbol-stroke,
  )
  // 变阻器右端 → 右下角
  line((rh-x2, y-bottom), (x-right, y-bottom), stroke: wire-stroke)
  // 滑片：从矩形顶部中央引出竖线，带箭头指向矩形，表示接入电路
  let arrow-x = (rh-x1 + rh-x2) / 2
  line(
    (arrow-x, y-bottom + 1.0),
    (arrow-x, rh-y-top),
    stroke: symbol-stroke,
    mark: (end: "stealth", fill: black, scale: 0.5),
  )
  line(
    (arrow-x + 0.01, rh-y-top + 0.83),
    (-arrow-x + 3.5, rh-y-top + 0.84),
    stroke: symbol-stroke,
    //mark: (end: "stealth", fill: black, scale: 0.5),
  )
  line(
    (-arrow-x + 3.5, 0),
    (-arrow-x + 3.5, 1.05),
    stroke: symbol-stroke,
    //mark: (end: "stealth", fill: black, scale: 0.5),
  )
  // 标签 R
  content(((rh-x1 + rh-x2) / 2, rh-y-bot - 0.5))[#text(size: 10pt)[$R$]]
})


// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[9.]
  text(
    size: 11pt,
  )[请用笔画线代替导线把图（a）所示的实物连接起来，要求滑动变阻器的滑片向左移动时，电动机的转动速度变大，并在图（b）的虚线框内画出对应的电路图。]

  v(1em)

  // --- 电路图答案 ---
  align(center)[
    #circuit-diagram
    #v(0.2em)
    #text(size: 9pt, fill: luma(100))[（第 9 题 · 电路图）]
  ]

  v(1em)

  // --- 解答 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + rgb("#4A90D9")),
    fill: rgb("#F0F6FF"),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb("#4A90D9"), size: 11pt)[解答]
    #v(0.4em)

    *电路连接分析：*

    #v(0.2em)
    - 电源（电池组）、开关 $S$、电动机 $M$、滑动变阻器 $R$ 四个元件#strong[串联]。
    - 滑片向左移动时电动机速度变大 → 电流增大 → 接入电阻减小。
    - 因此滑动变阻器需连接#strong[左端接线柱]和#strong[滑片接线柱]（使左移时有效电阻丝长度缩短）。

    #v(0.3em)
    *电路图说明：*

    #v(0.2em)
    - 矩形回路布局：顶边放开关 $S$，左边放电源，右边放电动机 $M$，底边放滑动变阻器 $R$。
    - 电流方向：电源正极 → 开关 → 电动机 → 变阻器 → 电源负极。
  ]

  v(1em)

  // --- 绘图原理与步骤 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与步骤]
    #v(0.4em)

    #text(weight: "bold")[电路拓扑]
    #v(0.2em)
    - 串联电路：电源 → 开关 S → 电动机 M → 滑动变阻器 R → 回到电源。
    - 矩形回路坐标：左下 $(0,0)$、右下 $(6,0)$、右上 $(6,4)$、左上 $(0,4)$。

    #v(0.4em)
    #text(weight: "bold")[元件符号]
    #v(0.2em)
    - *电源*：左边中部，一长一短两条横线，上方为正极。
    - *开关 S*：顶边中部，斜线闸刀（无圆点）。
    - *电动机 M*：右边中部，圆形 + 内部字母 M。
    - *变阻器 R*：底边中部，矩形 + 上方滑片箭头。

    #v(0.4em)
    #text(weight: "bold")[绘制参数]
    #v(0.2em)
    - `canvas length = 0.8cm`，线宽 `0.8pt`（导线）/ `1pt`（符号）。
    - 电动机圆半径 `0.5`，变阻器矩形高 `0.4`。
  ]
}
