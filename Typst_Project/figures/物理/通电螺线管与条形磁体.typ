// ============================================================
// 通电螺线管、条形磁体与小磁针判极
// 题目分析 + 绘图 + 维护说明
// ============================================================

#import "@preview/cetz:0.4.2"

#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)

  text(weight: "bold", size: 12pt, fill: rgb(90, 160, 210))[12.]
  text(size: 11pt)[如图所示，开关闭合后，在条形磁体和通电螺线管的共同作用下，小磁针在图中位置处于静止状态。请你根据条形磁体的极性标出小磁针和通电螺线管的 N、S 极，以及电源的正、负极。]

  v(1.2em)

  // --- 题目分析 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + luma(180)),
    fill: luma(248),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[题目分析]
    #v(0.3em)
    #set text(size: 9pt)

    + *读图信息*：题图右侧条形磁体已经给出极性，左端是 N 极、右端是 S 极；左侧是通电螺线管，下方接有电源和开关；中间上方的小磁针静止时与水平方向一致，说明该处合磁场方向也是水平的。
    + *先判断小磁针指向*：小磁针所在位置在条形磁体左侧、靠近条形磁体的 N 极。条形磁体外部磁场方向总是从 N 极指向 S 极，因此在该位置磁场方向应当大致向左。故小磁针静止时，N 极应指向左，S 极应指向右。
    + *再判断螺线管磁极*：小磁针右端若为 S 极，则它左端必须是 N 极。为了使小磁针保持图示方向，螺线管在小磁针处提供的磁场方向也应向左。螺线管右端靠近小磁针，若该端是 S 极，则其外部附近磁场方向指向 S 极，恰好向左。因此螺线管应为“左 N 右 S”。
    + *最后判断电源正负*：由安培定则，螺线管要形成“左 N 右 S”，电流应从螺线管右端流入、从左端流出。结合图中导线连接关系可知：电流从电源右端出发，经开关进入螺线管右端，再由左端回到电源左端，所以电源右端为正极，左端为负极。
  ]

  v(1.5em)

  // --- 绘图 ---
  align(center)[
    #cetz.canvas(length: 0.95cm, {
      import cetz.draw: *

      let caption-color = rgb(88, 166, 216)
      let ans-color = black
      let base-stroke = 1.1pt + black
      let ans-stroke = 1.0pt + ans-color

      // ========================================================
      // 坐标说明（尽量按原题图片比例布置）
      // - 左侧为通电螺线管及电路
      // - 中上为小磁针
      // - 右侧为已知极性的条形磁体
      // ========================================================

      // ---------------- 原题图形 ----------------
      group(name: "original", {
        // ===== 1. 通电螺线管外框 =====
        // 按题图比例画成长条矩形，并在内部叠加螺线绕组
        let sol-x1 = 0.0
        let sol-x2 = 5.8
        let sol-y1 = -0.2
        let sol-y2 = 0.8
        rect((sol-x1, sol-y1), (sol-x2, sol-y2), stroke: 1.15pt + black)

        // ===== 2. 螺线管绕线 =====
        // 题图中可见线圈在前侧表现为一组由左上向右下的斜线，
        // 上、下边缘各露出半个圆弧。这里用重复折线模拟原图观感。
        let top-y = sol-y2 + 0.12
        let bottom-y = sol-y1 - 0.12

        // 第1匝
        arc((0.65, 0.68), start: 180deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)
        line((0.81, 0.68), (1.28, -0.28), stroke: base-stroke)
        arc((1.42, -0.28), start: 0deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)

        // 第2匝
        arc((1.78, 0.68), start: 180deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)
        line((1.94, 0.68), (2.41, -0.28), stroke: base-stroke)
        arc((2.55, -0.28), start: 0deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)

        // 第3匝
        arc((2.91, 0.68), start: 180deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)
        line((3.07, 0.68), (3.54, -0.28), stroke: base-stroke)
        arc((3.68, -0.28), start: 0deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)

        // 第4匝
        arc((4.04, 0.68), start: 180deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)
        line((4.20, 0.68), (4.67, -0.28), stroke: base-stroke)
        arc((4.81, -0.28), start: 0deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)

        // 第5匝靠近右端，保留与题图接近的上半弧
        arc((5.13, 0.68), start: 180deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)

        // ===== 3. 外接导线、电源和开关 =====
        // 左引线：从螺线管下方引出到电源左端
        line((0.55, sol-y1), (0.55, -1.55), stroke: base-stroke)
        line((0.55, -1.55), (1.15, -1.55), stroke: base-stroke)

        // 电源框：与原图相同采用小矩形框加“电源”文字
        rect((1.15, -2.05), (3.05, -1.15), stroke: 1.15pt + black)
        content((2.10, -1.60), text(size: 11pt)[电源])

        // 右侧导线与开关
        line((3.05, -1.55), (4.60, -1.55), stroke: base-stroke)
        line((4.82, -1.55), (5.18, -1.55), stroke: base-stroke)
        content((4.58, -1.92), text(size: 10pt)[S])
        line((5.25, -1.55), (5.25, 0.80), stroke: base-stroke)

        // ===== 4. 小磁针 =====
        // 题图中为水平菱形，中间有一条竖分界线。
        let needle-cx = 7.45
        let needle-cy = 1.25
        let needle-l = 0.82
        let needle-h = 0.24
        line((needle-cx - needle-l, needle-cy), (needle-cx, needle-cy + needle-h), (needle-cx + needle-l, needle-cy), (needle-cx, needle-cy - needle-h), close: true, stroke: 1.0pt + black)
        line((needle-cx, needle-cy + needle-h), (needle-cx, needle-cy - needle-h), stroke: 1.0pt + black)

        // ===== 5. 条形磁体 =====
        // 右侧磁体按原图画成长方形，中间用竖线分隔，并保留题图已给出的 N、S 极。
        let mag-x1 = 9.15
        let mag-x2 = 12.35
        let mag-y1 = -0.15
        let mag-y2 = 0.90
        rect((mag-x1, mag-y1), (mag-x2, mag-y2), stroke: 1.2pt + black)
        line((10.80, mag-y1), (10.80, mag-y2), stroke: 1.2pt + black)
        content((9.65, 0.36), text(size: 11pt)[N])
        content((11.90, 0.36), text(size: 11pt)[S])

        // 题号说明，颜色与既有题目风格一致
        content((6.20, -3.35))[ #text(fill: caption-color, size: 15pt)[（第 12 题）] ]
      })

      // ---------------- 解答标注 ----------------
      group(name: "answer", {
        // 1. 给小磁针补全极性：由静止方向可知左端是 N，右端是 S。
        content((7.02, 1.25), text(size: 10pt, fill: ans-color)[N])
        content((7.88, 1.25), text(size: 10pt, fill: ans-color)[S])

        // 2. 给通电螺线管补全极性：左端 N，右端 S。
        content((0.30, 0.30), text(size: 10pt, fill: ans-color)[N])
        content((5.48, 0.30), text(size: 10pt, fill: ans-color)[S])

        // 3. 给电源补全正负极：左负右正。
        // 按电流方向判断：右端流出为正，左端流入为负。
        content((1.38, -1.15), text(size: 11pt, fill: ans-color)[−])
        content((2.82, -1.15), text(size: 11pt, fill: ans-color)[+])
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

    + *构图原则*：按题图原有结构分成三部分绘制：左侧电路与螺线管、中上方小磁针、右侧条形磁体。各部分位置关系保持与题图一致，使“螺线管—小磁针—条形磁体”沿同一水平区域展开。
    + *磁性判断原则*：条形磁体左端已知为 N 极，因此其左侧外部磁场方向向左；小磁针静止时 N 极必须沿磁场方向，故小磁针取“左 N 右 S”；要与这一指向一致，螺线管靠近小磁针的一端应为 S 极，所以螺线管为“左 N 右 S”。
    + *电源判定原则*：用安培定则由螺线管极性反推电流方向，再由外电路中“电流从电源正极流出、从负极流回”确定电源右端为正极、左端为负极。
    + *具体绘制步骤*：先画螺线管外框、绕线、导线、电源框、开关、小磁针和条形磁体；再保留题图已知的条形磁体 N、S；最后补写答案标注：小磁针左 N 右 S、螺线管左 N 右 S、电源左负右正。
  ]
}