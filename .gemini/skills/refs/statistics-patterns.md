# 统计图表绘图模式参考

## 一、折线统计图

### 方格网参数设计

```typst
// 定义网格参数
let sx = 1.2          // 列宽（X 方向每单位长度）
let sy = 1.0          // 行高（Y 方向每单位长度）
let ncols = 7         // 列数（数据点个数）
let nrows = 6         // 行数（Y 轴刻度数）

// 坐标映射
// X(第 i 个数据点, i=0..n-1) = i × sx + sx/2  （列中心）
// Y(数值 T)                  = T / 刻度步长 × sy
```

### 方格网绘制

```typst
let w = ncols * sx
let ht = nrows * sy

// 水平线（外框粗，内部细）
for j in range(nrows + 1) {
  let stk = if j == 0 or j == nrows { 0.7pt + black } else { 0.3pt + black }
  line((0, j * sy), (w, j * sy), stroke: stk)
}
// 竖直线
for i in range(ncols + 1) {
  let stk = if i == 0 or i == ncols { 0.7pt + black } else { 0.3pt + black }
  line((i * sx, 0), (i * sx, ht), stroke: stk)
}
```

### 折线绘制（区分系列）

```typst
// 系列 A：实线 + 实心圆
for i in range(ncols - 1) {
  let x1 = i * sx + sx / 2
  let y1 = data-a.at(i) / 5      // 按比例映射
  let x2 = (i + 1) * sx + sx / 2
  let y2 = data-a.at(i + 1) / 5
  line((x1, y1), (x2, y2), stroke: 0.8pt + black)
}
for i in range(ncols) {
  circle((i * sx + sx/2, data-a.at(i)/5), radius: 2pt, fill: black, stroke: none)
}

// 系列 B：虚线 + 空心圆
for i in range(ncols - 1) {
  line((x1, y1), (x2, y2), stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
}
for i in range(ncols) {
  circle((x, y), radius: 2.5pt, fill: white, stroke: 0.8pt + black)
}
```

### 数据值标注

```typst
// 系列 A 标在点下方，系列 B 标在点上方（避免重叠）
content((x, y - 0.4))[#text(size: 6.5pt)[#value]]   // 下方
content((x, y + 0.4))[#text(size: 6.5pt)[#value]]   // 上方
```

### 图例

```typst
line((3.0, ht + 0.7), (3.8, ht + 0.7), stroke: 0.8pt + black)
content((4.3, ht + 0.7))[#text(size: 8pt)[北京]]
line((5.0, ht + 0.7), (5.8, ht + 0.7), 
  stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
content((6.3, ht + 0.7))[#text(size: 8pt)[南京]]
```

---

## 二、柱状图 / 直方图

### 柱状图基本结构

```typst
let bar-data = (("乒乓球", 40), ("素描", 10), ("书法", 25), ("篮球", 20), ("足球", 5))
let bar-w = 0.5

for (i, item) in bar-data.enumerate() {
  let (name, val) = item
  let x = (i + 1) * sx
  let yp = val * sy
  
  // 补全部分用深色区分
  let fill-color = if name == "篮球" { luma(100) } else { luma(220) }
  
  rect((x - bar-w/2, 0), (x + bar-w/2, yp), fill: fill-color, stroke: 0.8pt + black)
  content((x, yp + 0.3), text(size: 8pt)[#val])  // 数值标注
  content((x, -0.4), text(size: 8pt)[#name])       // X轴标签
}
```

### 水平参考虚线

```typst
for y in (5, 10, 15, 20, 25, 30, 35, 40) {
  line((0, y * sy), (w, y * sy), stroke: (paint: luma(200), dash: "dashed", thickness: 0.5pt))
  content((-0.4, y * sy), text(size: 8pt)[#y])
}
```

### 断裂号（心电图样式，表示省略不连续刻度）

```typst
let ex = 0.2  // 断裂号位置
line((ex, 0), (ex + 0.05, 0), (ex + 0.1, 0.3), (ex + 0.2, -0.3), 
     (ex + 0.25, 0), (ex + 0.3, 0), stroke: 0.8pt + black)
```

### 直方图补全的高亮

```typst
// 补全部分用蓝色边框 + 浅色填充
(70, 10, blue.lighten(80%), blue)  // (score, count, fill, stroke)

// 数值标注在补全柱上方
content(((x_start + x_end) / 2, y_h + 0.3), text(fill: blue, weight: "bold")[10])
```

---

## 三、饼图（扇形统计图）

### 扇形绘制

```typst
let r = 1.8
let sectors = (
  (start: 160deg, stop: 304deg, label-angle: 232deg, label-radius: r * 0.6, text: [乒乓球]),
  (start: 124deg, stop: 160deg, label-angle: 142deg, label-radius: r * 0.7, text: [素描]),
  // ...
)

for sector in sectors {
  let start-point = (r * calc.cos(sector.start), r * calc.sin(sector.start))
  arc(start-point, start: sector.start, stop: sector.stop, radius: r,
      mode: "PIE", fill: white, stroke: 1pt + black)
  
  content((
    sector.label-radius * calc.cos(sector.label-angle),
    sector.label-radius * calc.sin(sector.label-angle),
  ), align(center)[#text(size: 8pt)[#sector.text]])
}
```

> **注意**：小扇形（如"足球"5%）的标签要增大 `label-radius`（如 `r * 1.2`），将标签外移避免拥挤。

### 百分比到角度

```typst
// 百分比 → 圆心角
let angle = 360deg * percentage / 100
```

---

## 四、柱状图 + 饼图并排布局

```typst
grid(
  columns: (1.5fr, 1.2fr),
  gutter: 20pt,
  align(center + bottom)[#柱状图canvas],
  align(center + bottom)[#饼图canvas],
)
```

---

## 五、数据表格（Typst 原生表格）

```typst
align(center)[
  #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: center + horizon,
    stroke: 0.5pt + black,
    inset: 6pt,
    table.cell(rowspan: 2)[城 市],
    table.cell(colspan: 7)[最高气温/℃],
    [2日], [3日], ...,
    [北京], [15], [15], ...,
    [南京], [25], [21], ...,
  )
]
```
