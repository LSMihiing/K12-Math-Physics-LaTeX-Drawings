// ============================================================
// 课外活动扇形统计图
// ============================================================
#import "@preview/cetz:0.4.2"

#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[3. ]
  text(size: 11pt)[八年级(3)班 48 人参加课外活动(每人一项), 16人打篮球, 8人打乒乓球, 4人跳绳, 12人打排球, 其余人参加长跑.

(1) 求参加各项活动人数占总人数的百分比;

(2) 在如图所示的十二等份的圆周上, 用扇形统计图表示学生参加课外活动的情况.]
  v(1.5em)

  // --- 绘图区域 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *
      
      let r = 2.5
      
      // 原题图形：十二等份圆
      circle((0,0), radius: r, stroke: 0.5pt)
      for i in range(12) {
        let a = i * 30deg
        circle((r * calc.cos(a), r * calc.sin(a)), radius: 1pt, fill: black)
      }
      circle((0,0), radius: 1pt, fill: black)
      
      // 扇形统计图绘制 (蓝色答案)
      let angles = (
        (name: "打篮球", count: 4, label: "33.3%"),
        (name: "打排球", count: 3, label: "25%"),
        (name: "打乒乓球", count: 2, label: "16.7%"),
        (name: "长跑", count: 2, label: "16.7%"),
        (name: "跳绳", count: 1, label: "8.3%")
      )

      let current-angle = 90deg // 从正上方开始
      for item in angles {
        let angle-span = item.count * 30deg
        let end-angle = current-angle - angle-span
        
        // 绘制分割线
        line((0,0), (r * calc.cos(current-angle), r * calc.sin(current-angle)), stroke: 0.8pt + rgb(31, 120, 180))
        
        // 标注文字
        let mid-angle = current-angle - angle-span / 2
        content((r * 0.6 * calc.cos(mid-angle), r * 0.6 * calc.sin(mid-angle)), text(size: 9pt, fill: rgb(31, 120, 180), align(center)[#item.name\ #item.label]))
        
        current-angle = end-angle
      }
    })
  ]
  v(1em)

  // --- 解答部分 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + rgb(31, 120, 180)), fill: rgb(245, 250, 255), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb(31, 120, 180), size: 10pt)[【解析与解答】]
    #v(0.3em)
    #set text(size: 10pt)
    
    (1) 参加长跑的人数为：$48 - 16 - 8 - 4 - 12 = 8$ (人).
    
    各项活动人数占总人数的百分比分别为：
    - 打篮球：$16/48 times 100% approx 33.3%$
    - 打乒乓球：$8/48 times 100% approx 16.7%$
    - 跳绳：$4/48 times 100% approx 8.3%$
    - 打排球：$12/48 times 100% = 25%$
    - 长跑：$8/48 times 100% approx 16.7%$
    
    (2) 如图所示，圆被等分为 12 份，每份代表 $1/12$，即 $48 times 1/12 = 4$ 人。
    - 打篮球 16 人，占 4 份；
    - 打排球 12 人，占 3 份；
    - 打乒乓球 8 人，占 2 份；
    - 长跑 8 人，占 2 份；
    - 跳绳 4 人，占 1 份。
    
    以此划分扇形并标注名称及百分比即可。
  ]
  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + luma(180)), fill: luma(248), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)
    
    + *绘制基础圆周与等分点*：使用 `circle` 绘制外圆，利用 `calc.cos` 和 `calc.sin` 结合 30° ($360°/12$) 的步长，在圆周上绘制 12 个等分点。
    + *计算各活动扇形份数*：根据各项活动人数与每份代表的人数（4人）之比，计算得出各扇形所占的份数（4、2、1、3、2）。
    + *绘制扇形分割线与标注*：利用极坐标思想计算每个扇形的起始和结束角度，使用 `line` 从圆心连线至对应的圆周点，最后在各扇形角度中分线的 $0.6R$ 处居中放置文本标注。
  ]
}
