// ============================================================
// 第2题 · 课后延时服务统计（饼图 + 补全柱状图）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[2. ]
  text(size: 11pt)[某校为落实“课后延时服务”要求，准备开设课后延时服务项目，为了了解全校 1 500 名学生对五门兴趣活动课的选择意向，李老师做了以下工作：① 整理数据并绘制统计图，② 抽取 100 名学生作为调查对象，③ 结合统计图分析数据并得出结论，④ 收集 100 名学生对五门课程选择意向的相关数据。]
  
  v(1.5em)

  // --- 绘图区域 ---
  grid(
    columns: (1.5fr, 1.2fr),
    gutter: 20pt,
    // 1. 柱状图
    align(center + bottom)[
      #cetz.canvas(length: 1cm, {
        import cetz.draw: *
        
        let w = 7.0
        let h = 4.0
        let sx = 1.2
        let sy = h / 40
        
        // 网格线 (横向)
        for y in (5, 10, 15, 20, 25, 30, 35, 40) {
          line((0, y * sy), (w - 0.5, y * sy), stroke: (paint: luma(200), dash: "dashed", thickness: 0.5pt))
          content((-0.4, y * sy), text(size: 8pt)[#y])
        }
        
        // 坐标轴
        line((0, 0), (w, 0), mark: (end: "stealth", fill: black)) // X轴
        line((0, 0), (0, h + 0.5), mark: (end: "stealth", fill: black)) // Y轴
        content((-0.2, -0.2), text(size: 8pt)[0])
        content((-0.8, h + 0.5), text(size: 9pt)[人数])
        content((w - 0.2, -0.4), text(size: 9pt)[项目])
        
        // 绘制柱状图 (乒乓球: 40, 素描: 10, 书法: 25, 篮球: 20, 足球: 5)
        let bar-data = (("乒乓球", 40), ("素描", 10), ("书法", 25), ("篮球", 20), ("足球", 5))
        let bar-w = 0.5
        
        for (i, item) in bar-data.enumerate() {
          let (name, val) = item
          let x = (i + 1) * sx
          let yp = val * sy
          
          // 篮球为缺失补全部分，使用深灰色区分
          let fill-color = if name == "篮球" { luma(100) } else { luma(220) }
          let stroke-style = if name == "篮球" { 1.2pt + black } else { 0.8pt + black }
          
          rect((x - bar-w/2, 0), (x + bar-w/2, yp), fill: fill-color, stroke: stroke-style)
          content((x, yp + 0.3), text(size: 8pt, weight: if name == "篮球" { "bold" } else { "regular" })[#val])
          
          // X轴标签，较长文字垂直显示或缩小
          content((x, -0.4), text(size: 8pt)[#name])
        }
        
        //content((w/2, -1.2), text(size: 9pt, weight: "bold")[各品种幼苗成活数统计图])
      })
    ],
    // 2. 饼图
    align(center + bottom)[
      #cetz.canvas(length: 1cm, {
        import cetz.draw: *
        let r = 1.8
        
        // 比例：乒乓球 40%, 素描 10%, 书法 25%, 篮球 20%, 足球 5%
        // 使用 merge-path 避开 arc mode:"pie" 的 bug
        
        // 1. 乒乓球 (40% = 144deg)
        merge-path(fill: white, stroke: 1pt + black, {
          line((0,0), (160deg, r))
          arc((0,0), radius: r, start: 160deg, delta: 144deg)
          line((304deg, r), (0,0), close: true)
        })
        content((232deg, r * 0.6), text(size: 8pt)[乒乓球])
        
        // 2. 素描 (10% = 36deg)
        merge-path(fill: white, stroke: 1pt + black, {
          line((0,0), (124deg, r))
          arc((0,0), radius: r, start: 124deg, delta: 36deg)
          line((160deg, r), (0,0), close: true)
        })
        content((142deg, r * 0.7), text(size: 8pt)[素描])

        // 3. 书法 (25% = 90deg)
        merge-path(fill: white, stroke: 1pt + black, {
          line((0,0), (34deg, r))
          arc((0,0), radius: r, start: 34deg, delta: 90deg)
          line((124deg, r), (0,0), close: true)
        })
        content((79deg, r * 0.6), text(size: 8pt)[书法\ 25%])

        // 4. 足球 (5% = 18deg)
        merge-path(fill: white, stroke: 1pt + black, {
          line((0,0), (16deg, r))
          arc((0,0), radius: r, start: 16deg, delta: 18deg)
          line((34deg, r), (0,0), close: true)
        })
        content((25deg, r * 1.2), text(size: 8pt)[足球])

        // 5. 篮球 (20% = 72deg)
        merge-path(fill: white, stroke: 1pt + black, {
          line((0,0), (304deg, r))
          arc((0,0), radius: r, start: 304deg, delta: 72deg)
          line((16deg, r), (0,0), close: true)
        })
        content((340deg, r * 0.6), text(size: 8pt)[篮球\ 20%])
        
      })
    ]
  )

  v(1.5em)
  align(center)[#text(size: 10pt, fill: luma(100))[（第 2 题图）]]
  v(1.5em)

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
    
    （1）数据统计的一般步骤为：抽取样本、收集数据、整理数据、分析数据。故正确排序为：#answer-style[②④①③] 。

    （2）为了使调查结果具有代表性，应采取全校范围内的随机抽样。故选 #answer-style[D] 。

    （3）由饼图可知，篮球占 20%，则篮球人数为 $100 times 20\% = 20$ 人。条形统计图补全见上图深色柱。 \
    “素描”人数为 10 人，占比 $10 / 100 = 10\%$，对应的圆心角度数为：$360^o times 10\% = $ #answer-style[$36^o$] 。

    （4）估计全校想参加“素描”活动课的人数为：$1500 times 10\% = $ #answer-style[150] 人。

    （5）看法示例：喜欢体育类（乒乓球、篮球、足球）的学生人数较多，占总人数的 65%，学校可以适当增加体育类器材和场地的投入。
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

    + *数据对应*：根据总人数 100 和饼图百分比，确定缺失项“篮球”的人数为 20，并作为补全目标。
    + *柱状图细节*：
      - 设置 Y 轴刻度 0-40，每隔 5 单位绘制虚线水平网格。
      - 补全的“篮球”柱体使用深灰色（luma 100）填充并加粗边框以示区别。
    + *饼图构造*：
      - 使用 `merge-path` 封装 `line` 和 `arc` 手动绘制各扇区，规避 CeTZ 原生 `pie` 模式的渲染 Bug。
      - 根据比例精确计算起始角度（如乒乓球占 144°，篮球占 72° 等）。
    + *排版布局*：利用 `grid` 将条形图与扇形图并列，并添加统一的图名标注。
  ]
}
