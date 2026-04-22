# 物理题绘图模式参考

## 一、受力示意图

### 核心原则

1. 所有力从物体**重心**出发
2. 力的箭头使用 `mark: (end: "stealth", fill: black)`
3. 线宽 `1.2pt`，比原题线条略粗以突出力
4. 力的标签放在箭头末端附近

### 斜面上的物体

```typst
// 1. 绘制斜面三角形
let aw = 4.0   // 斜面底边
let ah = 2.0   // 斜面高度
line((ox, oy), (ox + aw, oy), (ox, oy + ah), close: true, stroke: 1pt + black)

// 2. 计算斜面方向向量（单位化）
let dx = aw
let dy = -ah
let d_len = calc.sqrt(dx * dx + dy * dy)
let ux = dx / d_len       // 沿斜面向下
let uy = dy / d_len
let nx = -uy               // 垂直斜面向外（法向量）
let ny = ux

// 3. 物块在斜面上的位置（沿斜面中间偏上）
let mid_dist = d_len * 0.45
let cx = ox + mid_dist * ux
let cy = oy + ah + mid_dist * uy

// 4. 物块（平行四边形，沿斜面方向）
let bw = 1.0  // 沿斜面方向宽度
let bh = 0.8  // 垂直斜面方向高度
let p1 = (cx - bw/2 * ux, cy - bw/2 * uy)
let p2 = (cx + bw/2 * ux, cy + bw/2 * uy)
let p3 = (p2.at(0) + bh * nx, p2.at(1) + bh * ny)
let p4 = (p1.at(0) + bh * nx, p1.at(1) + bh * ny)
line(p1, p2, p3, p4, close: true, stroke: 1pt + black)

// 5. 重心
let cg_x = cx + bh/2 * nx
let cg_y = cy + bh/2 * ny
circle((cg_x, cg_y), radius: 0.05, fill: black)

// 6. 三个力
let f_len = 1.6
let fn_len = f_len * calc.cos(calc.atan2(aw, ah))
let ff_len = f_len * calc.sin(calc.atan2(aw, ah))

// 重力 G（竖直向下）
line((cg_x, cg_y), (cg_x, cg_y - f_len), 
  mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
content((cg_x + 0.4, cg_y - f_len + 0.2))[$G$]

// 支持力 F_N（垂直斜面向外）
line((cg_x, cg_y), (cg_x + fn_len * nx, cg_y + fn_len * ny),
  mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
content((cg_x + fn_len * nx + 0.1, cg_y + fn_len * ny + 0.4))[$F_N$]

// 摩擦力 f（沿斜面向上）
line((cg_x, cg_y), (cg_x - ff_len * ux, cg_y - ff_len * uy),
  mark: (end: "stealth", fill: black), stroke: 1.2pt + black)
content((cg_x - ff_len * ux - 0.3, cg_y - ff_len * uy + 0.3))[$f$]
```

### 传送带上的物体（匀速，无摩擦力）

```typst
// 两个带轮
circle((p1_x, p_y), radius: r, stroke: 1pt + black)
circle((p2_x, p_y), radius: r, stroke: 1pt + black)

// 皮带上下边缘
line((p1_x, p_y + r), (p2_x, p_y + r), stroke: 1.2pt + black)
line((p1_x, p_y - r), (p2_x, p_y - r), stroke: 1.2pt + black)

// 转动方向箭头（用离散线段避免 arc 渲染偏置）
let steps = 10
for i in range(steps) {
  let a1 = start_a + i * (end_a - start_a) / steps
  let a2 = start_a + (i + 1) * (end_a - start_a) / steps
  let m = if i == steps - 1 { (end: "stealth", fill: black, size: 4pt) } else { none }
  line(
    (cx + r_arrow * calc.cos(a1), cy + r_arrow * calc.sin(a1)),
    (cx + r_arrow * calc.cos(a2), cy + r_arrow * calc.sin(a2)),
    mark: m, stroke: 0.6pt + black,
  )
}

// 匀速运动只受 G 和 F_N（无摩擦力）
```

### 墙壁阴影线

```typst
let wall_h = 3.5
line((ox, oy), (ox, oy + wall_h), stroke: 1pt + black)
for i in range(15) {
  let y = oy + 0.2 + i * 0.22
  line((ox, y), (ox - 0.2, y - 0.2), stroke: 0.5pt + black)
}
```

### 多场景子图隔离

```typst
// 使用 group() 让每个子图有独立坐标系
group(name: "jia", {
  // 甲图代码...
  content((ox + aw/2, oy - 1.0))[甲]
})

group(name: "yi", {
  let ox = 6.5  // 横向偏移
  // 乙图代码...
  content((cg_x, oy - 1.5))[乙]
})
```

---

## 二、电磁图

### 螺线管绕线

```typst
// 用 arc() + line() 交替模拟绕线
// 每匝：上方半弧 → 斜线 → 下方半弧
arc((0.65, 0.68), start: 180deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)
line((0.81, 0.68), (1.28, -0.28), stroke: base-stroke)
arc((1.42, -0.28), start: 0deg, delta: 180deg, radius: (0.16, 0.12), stroke: base-stroke)

// 重复 4-5 匝，x 坐标递增约 1.13 单位
```

### 菱形磁针

```typst
let needle-cx = 7.45
let needle-cy = 1.25
let needle-l = 0.82    // 半长
let needle-h = 0.24    // 半高
line(
  (needle-cx - needle-l, needle-cy),
  (needle-cx, needle-cy + needle-h),
  (needle-cx + needle-l, needle-cy),
  (needle-cx, needle-cy - needle-h),
  close: true, stroke: 1.0pt + black,
)
// 中间分界线
line((needle-cx, needle-cy + needle-h), (needle-cx, needle-cy - needle-h), stroke: 1pt + black)
// N/S 标注
content((needle-cx - 0.4, needle-cy), text(size: 10pt)[N])
content((needle-cx + 0.4, needle-cy), text(size: 10pt)[S])
```

### 电源框 + 开关

```typst
// 电源：矩形框 + 文字
rect((1.15, -2.05), (3.05, -1.15), stroke: 1.15pt + black)
content((2.10, -1.60), text(size: 11pt)[电源])

// 正负极标注（答案）
content((1.38, -1.15), text(size: 11pt)[−])
content((2.82, -1.15), text(size: 11pt)[+])

// 开关 S
content((4.58, -1.92), text(size: 10pt)[S])
```

### 条形磁体

```typst
rect((mag-x1, mag-y1), (mag-x2, mag-y2), stroke: 1.2pt + black)
line((mid-x, mag-y1), (mid-x, mag-y2), stroke: 1.2pt + black)  // 中间分界线
content((left-x, 0.36), text(size: 11pt)[N])
content((right-x, 0.36), text(size: 11pt)[S])
```

---

## 三、电路图

对于复杂实物连线图，不绘制实物，只绘制等效电路图。电路图使用标准元件符号：
- 电阻：矩形框
- 电源：长短线（长正短负）
- 开关：断开的线段 + S 标注
- 电流表/电压表：圆圈 + A/V
- 导线：直线连接

---

## 四、磁场作图

### 磁感线

```typst
// 使用 bezier() 或多段 arc() 绘制曲线磁感线
// 箭头方向：外部从 N 极到 S 极
// 小磁针 N 极指向磁感线方向
```
