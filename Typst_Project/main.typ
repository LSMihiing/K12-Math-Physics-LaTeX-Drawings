// ============================================================
// main.typ — Typst 绘图项目主入口
// ============================================================
// 编译命令：typst compile main.typ output/main.pdf
// 实时预览：typst watch main.typ output/main.pdf

// --- 公共库 ---
#import "lib/styles.typ": center-figure, page-setup, problem-title, solution

// --- 几何作图 ---
#import "figures/几何作图/尺规取等长线段.typ" as geo_ruler_eq
#import "figures/几何作图/尺规作图_角平分线与垂线.typ" as geo_ruler_bisect
#import "figures/几何作图/尺规作矩形两种方法.typ" as geo_ruler_rect
#import "figures/几何作图/格点三角形中心对称.typ" as geo_grid_sym
#import "figures/几何作图/三角形平移旋转.typ" as geo_tri_translate
#import "figures/几何作图/三角形旋转变换.typ" as geo_tri_rotate
#import "figures/几何作图/轴对称补全图形.typ" as geo_axis_complete
#import "figures/几何作图/长方形拼图.typ" as geo_rect_puzzle
#import "figures/几何作图/正方形与长方形拼接.typ" as geo_sq_rect
#import "figures/几何作图/网格纸画长方形.typ" as geo_grid_rect
#import "figures/几何作图/分数涂色与比较大小.typ" as geo_frac_color_cmp
#import "figures/几何作图/九宫格涂色.typ" as geo_9grid_color
#import "figures/几何作图/蔬菜种植面积_面积计算.typ" as geo_veggie_area
#import "figures/几何作图/分数涂色比较.typ" as geo_frac_color
#import "figures/几何作图/根据分数推导图形.typ" as geo_frac_deduce

// --- 统计图表 ---
#import "figures/统计图表/北京南京气温_复式折线统计图.typ" as stat_line_temp
#import "figures/统计图表/合唱团年龄_频数频率统计.typ" as stat_choir_age
#import "figures/统计图表/果树品种成活率_饼图柱状图.typ" as stat_survival
#import "figures/统计图表/课后延时服务_饼图柱状图.typ" as stat_service
#import "figures/统计图表/成绩频数分布直方图.typ" as stat_histogram
#import "figures/统计图表/课外活动扇形统计图.typ" as stat_pie

// --- 数轴与线段 ---
#import "figures/线段图/解不等式_数轴表示_基础.typ" as line_ineq_basic
#import "figures/线段图/解不等式组_数轴表示.typ" as line_ineq_group
#import "figures/线段图/解不等式组_交集数轴.typ" as line_ineq_intersect

// --- 物理：受力分析 ---
#import "figures/物理/受力_斜面物体与绳子.typ" as phy_force_slope_rope
#import "figures/物理/受力_竖直面圆周与弹簧.typ" as phy_force_vertical_spring
#import "figures/物理/受力_圆周运动与悬挂小球.typ" as phy_force_circular
#import "figures/物理/受力_斜面烧杯中浮球.typ" as phy_force_beaker
#import "figures/物理/受力_弹簧测力计浸没浮力.typ" as phy_force_spring_buoy
#import "figures/物理/受力_摩擦力示意图.typ" as phy_force_friction
#import "figures/物理/受力_铅球运动与漂浮.typ" as phy_force_shot_float
#import "figures/物理/受力_斜面静止与传送带匀速与靠墙悬挂.typ" as phy_force_multi
#import "figures/物理/重力_足球.typ" as phy_gravity_ball

// --- 物理：压力分析 ---
#import "figures/物理/压力_水平竖直斜面.typ" as phy_press_multi
#import "figures/物理/压力_桌面物体.typ" as phy_press_desk
#import "figures/物理/压力_斜面滑块.typ" as phy_press_slider
#import "figures/物理/压力_物块A对斜面.typ" as phy_press_block

// --- 物理：力学作图 ---
#import "figures/物理/杠杆最小力作图.typ" as phy_lever

// --- 物理：电磁学 ---
#import "figures/物理/通电螺线管与条形磁体.typ" as phy_solenoid
#import "figures/物理/磁感线与小磁针磁极.typ" as phy_magnetic

// --- 物理：电路 ---
#import "figures/物理/电路图_电动机滑动变阻器.typ" as phy_circuit
#import "figures/物理/家庭电路绘制.typ" as phy_home_circuit

// --- 物理：其他 ---
#import "figures/物理/哈勃定律_星系运动关系.typ" as phy_hubble
#import "figures/物理/大气压估测实验表格.typ" as phy_atm_table

// ============================================================
// 全局样式
// ============================================================
#show: doc => {
  page-setup()
  doc
}

// --- 分隔线函数 ---
#let sep() = {
  v(2em)
  line(length: 100%, stroke: 0.5pt + luma(200))
  v(2em)
}

// ============================================================
// 封面
// ============================================================
#align(center)[
  #v(2cm)
  #text(size: 24pt, weight: "bold")[教辅解答绘图集]
  #v(0.5em)
  #text(size: 14pt, fill: luma(80))[Typst + CeTZ 版]
  #v(0.3em)
  #line(length: 60%, stroke: 0.5pt + luma(180))
  #v(0.3em)
  #text(size: 11pt, fill: luma(100))[K12 数学 / 物理]
  #v(3cm)
]

// ============================================================
// 目录（深度 3，展示到每个绘图）
// ============================================================
#outline(title: "目录", depth: 3)

#pagebreak()

// ============================================================
// 正文
// ============================================================
#set heading(numbering: "1.")

// ************************************************************
// 1. 几何作图
// ************************************************************
= 几何作图

== 尺规作图

=== 尺规取等长线段
#geo_ruler_eq.render()
#sep()

=== 尺规作图 · 角平分线与垂线
#geo_ruler_bisect.render()
#sep()

=== 尺规作矩形两种方法
#geo_ruler_rect.render()

#pagebreak()

== 图形变换

=== 格点三角形中心对称
#geo_grid_sym.render()
#sep()

=== 三角形平移旋转
#geo_tri_translate.render()
#sep()

=== 三角形旋转变换
#geo_tri_rotate.render()
#sep()

=== 轴对称补全图形
#geo_axis_complete.render()

#pagebreak()

== 图形拼接

=== 长方形拼图
#geo_rect_puzzle.render()
#sep()

=== 正方形与长方形拼接
#geo_sq_rect.render()

#pagebreak()

== 网格纸作图

=== 网格纸画长方形
#geo_grid_rect.render()

#pagebreak()

== 几何图形与分数

=== 分数涂色与比较大小
#geo_frac_color_cmp.render()
#sep()

=== 九宫格涂色
#geo_9grid_color.render()
#sep()

=== 蔬菜种植面积 · 面积计算
#geo_veggie_area.render()
#sep()

=== 分数涂色比较
#geo_frac_color.render()
#sep()

=== 根据分数推导图形
#geo_frac_deduce.render()

#pagebreak()

// ************************************************************
// 2. 统计图表
// ************************************************************
= 统计图表

== 折线统计图

=== 北京南京气温 · 复式折线统计图
#stat_line_temp.render()
#sep()

=== 合唱团年龄 · 频数频率统计
#stat_choir_age.render()
#sep()

=== 果树品种成活率 · 饼图与柱状图
#stat_survival.render()
#sep()

=== 课后延时服务 · 饼图与柱状图
#stat_service.render()

#pagebreak()

== 直方图

=== 成绩频数分布直方图
#stat_histogram.render()

#pagebreak()

== 扇形统计图

=== 课外活动扇形统计图
#stat_pie.render()

#pagebreak()

// ************************************************************
// 3. 数轴与线段
// ************************************************************
= 数轴与线段

== 不等式与数轴

=== 解不等式 · 数轴表示（基础）
#line_ineq_basic.render()
#sep()

=== 解不等式组 · 数轴表示
#line_ineq_group.render()
#sep()

=== 解不等式组 · 交集数轴
#line_ineq_intersect.render()

#pagebreak()

// ************************************************************
// 4. 物理
// ************************************************************
= 物理

== 受力分析

=== 斜面物体与绳子
#phy_force_slope_rope.render()
#sep()

=== 竖直面圆周与弹簧
#phy_force_vertical_spring.render()
#sep()

=== 圆周运动与悬挂小球
#phy_force_circular.render()
#sep()

=== 斜面烧杯中浮球
#phy_force_beaker.render()
#sep()

=== 弹簧测力计浸没浮力
#phy_force_spring_buoy.render()
#sep()

=== 摩擦力示意图
#phy_force_friction.render()
#sep()

=== 铅球运动与漂浮
#phy_force_shot_float.render()
#sep()

=== 斜面静止 · 传送带匀速 · 靠墙悬挂
#phy_force_multi.render()
#sep()

=== 重力 · 足球
#phy_gravity_ball.render()

#pagebreak()

== 压力分析

=== 水平竖直斜面压力
#phy_press_multi.render()
#sep()

=== 桌面物体压力
#phy_press_desk.render()
#sep()

=== 斜面滑块压力
#phy_press_slider.render()
#sep()

=== 物块A对斜面压力
#phy_press_block.render()

#pagebreak()

== 力学作图

=== 杠杆最小力作图
#phy_lever.render()

#pagebreak()

== 电磁学

=== 通电螺线管与条形磁体
#phy_solenoid.render()
#sep()

=== 磁感线与小磁针磁极
#phy_magnetic.render()

#pagebreak()

== 电路

=== 电路图 · 电动机滑动变阻器
#phy_circuit.render()
#sep()

=== 家庭电路绘制
#phy_home_circuit.render()

#pagebreak()

== 其他

=== 哈勃定律 · 星系运动关系
#phy_hubble.render()
#sep()

=== 大气压估测实验表格
#phy_atm_table.render()
