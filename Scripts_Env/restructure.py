#!/usr/bin/env python3
"""
restructure.py — K12 教辅绘图项目章节重构自动化脚本
按照 implementation_plan.md 的映射，将按年级组织的 tex 文件
重组为按绘图类型组织的新 tex 文件。

使用方法：
    python restructure.py          # 执行重构
    python restructure.py --dry    # 模拟运行，不写入文件
"""
import re, os, sys, json, shutil
from pathlib import Path
from collections import OrderedDict

# ============================================================
# 路径配置
# ============================================================
PROJECT = Path(r"c:\Users\lsmihiing\Desktop\02 智羚学伴 26春教辅 智书粗加工\2支援小学数学")
LATEX_DIR = PROJECT / "LaTeX_Project"
TEMP_DIR  = PROJECT / "Temp_Work"
SCRIPTS   = PROJECT / "Scripts_Env"

DRY_RUN = "--dry" in sys.argv

# ============================================================
# 标题正则：匹配 \section{...} 和 {\large\bfseries 解答：...}
# ============================================================
# 匹配各种标题模式
SECTION_RE = re.compile(r'\\section\*?\{(.+?)\}')
BFSERIES_RE = re.compile(r'\{\\large\\bfseries\s+(解答[：:].+?)\}')

def find_all_headers(text):
    """找到文本中所有的标题位置和内容，返回 [(start, end_of_header, title, type), ...]
    
    策略：如果文件包含 \\section{} 标题，只用 \\section 匹配。
    如果没有 \\section{} 但有 \\bfseries 标题，则用 \\bfseries 匹配。
    对 bfseries 类型的标题，向前搜索 \\begin{center}，将其包含在起始位置中。
    """
    section_matches = list(SECTION_RE.finditer(text))
    bfseries_matches = list(BFSERIES_RE.finditer(text))
    
    headers = []
    
    if section_matches:
        # 文件使用 \section{} 格式
        for m in section_matches:
            headers.append((m.start(), m.end(), m.group(1).strip(), 'section'))
    elif bfseries_matches:
        # 文件使用 {\large\bfseries} 格式
        for m in bfseries_matches:
            # 向前搜索 \begin{center} 和 \newpage
            lookback_start = max(0, m.start() - 100)
            prefix = text[lookback_start:m.start()]
            
            actual_start = m.start()
            
            # 找 \begin{center}
            center_pos = prefix.rfind('\\begin{center}')
            if center_pos >= 0:
                actual_start = lookback_start + center_pos
                # 如果 \begin{center} 前有 \newpage，也包含进来
                newpage_search = text[max(0, actual_start - 30):actual_start]
                np_pos = newpage_search.rfind('\\newpage')
                if np_pos >= 0:
                    actual_start = max(0, actual_start - 30) + np_pos
            
            headers.append((actual_start, m.end(), m.group(1).strip(), 'bfseries'))
    
    headers.sort(key=lambda x: x[0])
    return headers

def split_into_sections(text):
    """将 tex 文件内容拆分为 [(title, content), ...] 列表。
    content 包含该标题对应的完整内容（从标题行到下一标题之前）。
    文件头部注释（%!TEX root 等）不包含在任何 section 中。
    """
    headers = find_all_headers(text)
    if not headers:
        return [("__WHOLE_FILE__", text)]
    
    sections = []
    
    # 文件头部（在第一个标题之前的内容）
    preamble = text[:headers[0][0]]
    
    for i, (start, hdr_end, title, htype) in enumerate(headers):
        # 本 section 的内容：从标题开始到下一个标题之前
        if i + 1 < len(headers):
            content = text[start:headers[i+1][0]]
        else:
            content = text[start:]
        sections.append((title, content))
    
    return sections

# ============================================================
# 重构映射表
# 定义从 (源文件关键词, section标题关键词) → 目标文件 的映射
# ============================================================

# 新文件结构定义：(章名, 节名, 文件名)
NEW_FILES = OrderedDict([
    # Chapter 1: 几何作图
    ("1.01", ("几何作图", "画角与量角", "数学/几何作图/画角与量角.tex")),
    ("1.02", ("几何作图", "画线段与尺规作图", "数学/几何作图/画线段与尺规作图.tex")),
    ("1.03", ("几何作图", "垂线与平行线", "数学/几何作图/垂线与平行线.tex")),
    ("1.04", ("几何作图", "三角形画高", "数学/几何作图/三角形画高.tex")),
    ("1.05", ("几何作图", "标准几何图形绘制", "数学/几何作图/标准几何图形绘制.tex")),
    ("1.06", ("几何作图", "梯形与平行四边形", "数学/几何作图/梯形与平行四边形.tex")),
    ("1.07", ("几何作图", "三角形分割与拼组", "数学/几何作图/三角形分割与拼组.tex")),
    ("1.08", ("几何作图", "图形变换_平移", "数学/几何作图/图形变换_平移.tex")),
    ("1.09", ("几何作图", "图形变换_旋转", "数学/几何作图/图形变换_旋转.tex")),
    ("1.10", ("几何作图", "图形变换_对称", "数学/几何作图/图形变换_对称.tex")),
    ("1.11", ("几何作图", "图形变换_中心对称与复合", "数学/几何作图/图形变换_中心对称与复合.tex")),
    ("1.12", ("几何作图", "图形放大与缩小", "数学/几何作图/图形放大与缩小.tex")),
    ("1.13", ("几何作图", "最短路径与几何模型", "数学/几何作图/最短路径与几何模型.tex")),
    ("1.14", ("几何作图", "分数涂色与等值分数", "数学/几何作图/分数涂色与等值分数.tex")),
    ("1.15", ("几何作图", "小数涂色与描点", "数学/几何作图/小数涂色与描点.tex")),
    ("1.16", ("几何作图", "比例尺方位与坐标", "数学/几何作图/比例尺方位与坐标.tex")),
    ("1.17", ("几何作图", "点子图与观察物体", "数学/几何作图/点子图与观察物体.tex")),
    ("1.18", ("几何作图", "图形规律与序列", "数学/几何作图/图形规律与序列.tex")),
    # Chapter 2: 统计图表
    ("2.01", ("统计图表", "条形统计图（单式）", "数学/统计图表/条形统计图_单式.tex")),
    ("2.02", ("统计图表", "条形统计图补全", "数学/统计图表/条形统计图补全.tex")),
    ("2.03", ("统计图表", "复式条形统计图", "数学/统计图表/复式条形统计图.tex")),
    ("2.04", ("统计图表", "折线统计图（单式）", "数学/统计图表/折线统计图_单式.tex")),
    ("2.05", ("统计图表", "复式折线统计图", "数学/统计图表/复式折线统计图.tex")),
    ("2.06", ("统计图表", "扇形统计图", "数学/统计图表/扇形统计图.tex")),
    ("2.07", ("统计图表", "条形图与扇形图综合", "数学/统计图表/条形图与扇形图综合.tex")),
    ("2.08", ("统计图表", "频数直方图", "数学/统计图表/频数直方图.tex")),
    ("2.09", ("统计图表", "概率频率折线图", "数学/统计图表/概率频率折线图.tex")),
    ("2.10", ("统计图表", "正比例图像", "数学/统计图表/正比例图像.tex")),
    ("2.11", ("统计图表", "统计方案与图表选择", "数学/统计图表/统计方案与图表选择.tex")),
    ("2.12", ("统计图表", "转盘涂色", "数学/统计图表/转盘涂色.tex")),
    # Chapter 3: 数据表格
    ("3.01", ("数据表格", "填表题（正反比例）", "数学/数据表格/填表题_正反比例.tex")),
    ("3.02", ("数据表格", "互化表", "数学/数据表格/互化表.tex")),
    ("3.03", ("数据表格", "数位顺序表", "数学/数据表格/数位顺序表.tex")),
    ("3.04", ("数据表格", "购买与运算表格", "数学/数据表格/购买与运算表格.tex")),
    ("3.05", ("数据表格", "代数运算填表", "数学/数据表格/代数运算填表.tex")),
    ("3.06", ("数据表格", "频数统计表", "数学/数据表格/频数统计表.tex")),
    # Chapter 4: 连线题
    ("4.01", ("连线题", "连线题", "数学/连线题/连线题.tex")),
    # Chapter 5: 线段图
    ("5.01", ("线段图", "行程问题线段图", "数学/线段图/行程问题线段图.tex")),
    ("5.02", ("线段图", "和差问题线段图", "数学/线段图/和差问题线段图.tex")),
    ("5.03", ("线段图", "分数应用题线段图", "数学/线段图/分数应用题线段图.tex")),
    ("5.04", ("线段图", "数轴与不等式", "数学/线段图/数轴与不等式.tex")),
    ("5.05", ("线段图", "日历与其他", "数学/线段图/日历与其他.tex")),
    # Chapter 6: 力学作图
    ("6.01", ("力学作图", "重力示意图", "物理/力学作图/重力示意图.tex")),
    ("6.02", ("力学作图", "浮力示意图", "物理/力学作图/浮力示意图.tex")),
    ("6.03", ("力学作图", "综合受力分析", "物理/力学作图/综合受力分析.tex")),
    ("6.04", ("力学作图", "弹簧测力计", "物理/力学作图/弹簧测力计.tex")),
    # Chapter 7: 坐标图像
    ("7.01", ("坐标图像", "G-m与m-V关系图像", "物理/坐标图像/G-m与m-V关系图像.tex")),
])

# ============================================================
# 实施计划中每个 section 标题到目标文件的映射
# 使用标题子串进行模糊匹配
# ============================================================
TITLE_TO_TARGET = {
    # §1.1 画角与量角
    "以下面的射线为一条边，画出各个角": "1.01",
    "∠1=50": "1.01",
    "angle 1 = 50": "1.01",
    "画指定度数的角": "1.01",
    "用量角器画角": "1.01",
    
    # §1.2 画线段与尺规作图
    "在直线上画线段 CD": "1.02",
    "在直线上画线段 $CD$": "1.02",
    "用圆规在直线上找点": "1.02",
    "用直尺和圆规画图": "1.02",
    "用直尺和圆规画线段": "1.02",
    "尺规作图综合": "1.02",
    "用圆规和直尺画图": "1.02",
    "在线段上找点": "1.02",
    "尺规作图（线段倍数）": "1.02",
    
    # §1.3 垂线与平行线
    "无人机从起飞点飞到对岸": "1.03",
    "过点画已知直线的垂线和平行线": "1.03",
    "点到直线的距离比较": "1.03",
    "过点 $A$ 画垂线和平行线": "1.03",
    "过点 A 画垂线和平行线": "1.03",
    "平行与垂直的练习": "1.03",
    "在方格纸上画平行线和垂直线": "1.03",
    "经过点 A 画已知直线的垂线": "1.03",
    "过直线外一点画平行线": "1.03",
    "找出图形中的平行线并描线": "1.03",
    "找出图形中的平行线并描红": "1.03",
    "按指定距离画平行线": "1.03",
    "过直线外一点画垂线并画出正方形": "1.03",
    "过点 A 画垂线和平行线并量距离": "1.03",
    "过点 A 画平行线和垂线": "1.03",
    "画出从学校到公路的最短路线": "1.03",
    "村庄到公路的最短距离": "1.03",
    "小河过河最短路线": "1.03",
    "小鸭去小猫家怎样走比较省力": "1.03",
    "作 AD 垂直平分线与": "1.03",
    "垂线与平行线": "1.03",
    
    # §1.4 三角形画高
    "画平行四边形的高并测量": "1.04",
    "画梯形的高并测量长度": "1.04",
    "画出折线高并测量填空": "1.04",
    "画出每个图形底边上的高": "1.04",
    "画出每个三角形底边上的高": "1.04",
    "画出下面每个图形底边上的高": "1.04",
    "画同底等高的平行四边形": "1.04",
    
    # §1.5 标准几何图形绘制
    "在方格纸上按要求画梯形": "1.05",
    "在方格纸上画平行四边形和梯形": "1.05",
    "按要求画正方形和长方形": "1.05",
    "补作指定长度的长方形": "1.05",
    "补画成长方形和正方形": "1.05",
    "在平行线间画长是2倍的长方形": "1.05",
    "在平行线间画长是宽": "1.05",
    "(1)画出长5厘米、宽3厘米的长方形": "1.05",
    "（1）画出长": "1.05",
    "(2)画出边长2厘米的正方形": "1.05",
    "（2）画出边长": "1.05",
    "矩形与正方形的作图": "1.05",
    "利用平行线作矩形与正方形": "1.05",
    
    # §1.6 梯形与平行四边形
    "求梯形的周长": "1.06",
    "多边形的分割与三角形个数规律": "1.06",
    "平行四边形面积与全等关系": "1.06",
    "网格图中的平行四边形探索": "1.06",
    "利用平行线作平行四边形": "1.06",
    "Rt": "1.06",  # Rt△ABC 中线与菱形证明
    
    # §1.7 三角形分割与拼组
    "三角形的分割与等腰三角形证明": "1.07",
    "用两块相同的三角尺拼三角形": "1.07",
    "图形的拼组（正方形与长方形）": "1.07",
    "三角形三边关系定理探究": "1.07",
    "三角形三边关系（拼搭小棒）": "1.07",
    "多边形特征识别与判定": "1.07",
    "代数拼图——矩形纸片拼接与因式分解": "1.07",
    "网格图中的图形拼接": "1.07",
    "将正方形分割成大小正方形及等大长方形": "1.07",
    "将正方形分割并拼成大三角形": "1.07",
    "长方形连续剪正方形的过程": "1.07",
    "将正方形平均分成4份的四种方法": "1.07",
    "将正方形平均分成 4 份": "1.07",
    "利用12个小正方形拼长方形": "1.07",
    "利用 12 个小正方形拼长方形": "1.07",
    "火柴棍摆正方形趣题": "1.07",
    "火柴棒摆正方形趣题": "1.07",
    "面积增加问题——长方形扩建正方形": "1.07",
    
    # §1.8 图形变换——平移
    "图形的平移与面积转化": "1.08",
    "平移组合图案设计": "1.08",
    "网格图中的图形平移": "1.08",
    "三角形平移的两种作图方法": "1.08",
    "平移的两次中心旋转等效变换": "1.08",
    "先画一个图形，再进行平移和旋转": "1.08",
    
    # §1.9 图形变换——旋转
    "方格纸中的图形旋转、面积计算": "1.09",
    "网格图中的图形旋转": "1.09",
    "四边形绕点旋转作图": "1.09",
    "四边形绑点旋转作图": "1.09",
    "图形旋转与四边形判定": "1.09",
    
    # §1.10 图形变换——对称
    "作对称直角三角形": "1.10",
    "判断图形的轴对称性及绘制对称轴": "1.10",
    "正多边形所有的对称轴": "1.10",
    "轴对称图形的画法": "1.10",
    "网格图中的轴对称变换": "1.10",
    "画出轴对称图形的对称轴": "1.10",
    "只含一条对称轴的双圆组合": "1.10",
    "纸张多折剪裁的对称性图形": "1.10",
    "纸张对折剪裁的对称性图形": "1.10",
    
    # §1.11 图形变换——中心对称与复合
    "作图形的中心对称与复合变换": "1.11",
    "三角形中心对称的三种情境作图": "1.11",
    "网格图中的平移、旋转与中心对称": "1.11",
    "全等三角形的图形变换": "1.11",
    "网格图的图形变换（平移、旋转与轴对称）": "1.11",
    
    # §1.12 图形放大与缩小
    "按比例放大或缩小图形": "1.12",
    "图形的放大与缩小": "1.12",
    
    # §1.13 最短路径与几何模型
    "最短路径问题（饮马模型": "1.13",
    "数学实验与几何概型": "1.13",
    
    # §1.14 分数涂色与等值分数
    "在图中涂色表示分数": "1.14",
    "六边形的分数涂色": "1.14",
    "表示分数的多种折叠模型": "1.14",
    "等值分数的涂色与转化": "1.14",
    "在正方形中表示分数": "1.14",
    "分数的涂色与小数表示": "1.14",
    "黑板报版面比例问题": "1.14",
    "分数等值涂色": "1.14",
    "长方形网格分数比例": "1.14",
    "分数加减与涂色": "1.14",
    "方格纸等效分数": "1.14",
    "比较分数大小与等值划分": "1.14",
    "长条形方格等效分数": "1.14",
    
    # §1.15 小数涂色与描点
    "小数的意义与图形涂色": "1.15",
    "十分格与百分格的小数涂色": "1.15",
    "在直线上描点表示小数": "1.15",
    
    # §1.16 比例尺方位与坐标
    "比例尺与平面方向几何作图": "1.16",
    "用数对表示位置": "1.16",
    "方位与比例尺的综合应用": "1.16",
    
    # §1.17 点子图与观察物体
    "在点子图上画面积相等的图形": "1.17",
    "从上面看各是什么形状": "1.17",
    
    # §1.18 图形规律与序列
    "按照规律接着画一画": "1.18",
    "长方形和正方形拼图": "1.18",
    "周期规律图形序列": "1.18",
    "两位数乘法的面积模型": "1.18",
    "gpt-5": "1.18",
    
    # §2.1 条形统计图（单式）
    "球类爱好项目统计": "2.01",
    "乘坐地铁各付款方式人数统计": "2.01",
    "男生体育测试成绩统计": "2.01",
    "2分钟口算成绩统计": "2.01",
    "2 分钟口算成绩统计": "2.01",
    "书签枚数统计": "2.01",
    "五角星和六角星数量统计": "2.01",
    "1分钟跳绳成绩统计": "2.01",
    "1 分钟跳绳成绩统计": "2.01",
    "生活垃圾分类情况统计": "2.01",
    "班身高统计": "2.01",
    "数据的初步收集与统计图绘制": "2.01",
    "诗词大赛成绩统计": "2.01",
    
    # §2.2 条形统计图补全
    "图书类别条形统计图补全": "2.02",
    "BMI 条形统计图补全": "2.02",
    "体育成绩等级条形统计图补全": "2.02",
    "月总销售额条形统计图补全": "2.02",
    "不完整统计图补全与样本推断": "2.02",
    
    # §2.3 复式条形统计图
    "复式条形统计图绘制": "2.03",
    "爱心捐赠条形与扇形统计图": "2.03",
    
    # §2.4 折线统计图（单式）
    "羊毛衫销售情况折线统计图": "2.04",
    "婷婷0～10岁身高情况": "2.04",
    "一架飞机飞行时间和航程": "2.04",
    
    # §2.5 复式折线统计图
    "复式折线统计图": "2.05",
    "10天气温调查统计表与复式折线统计图": "2.05",
    
    # §2.6 扇形统计图
    "扇形统计图的计算与绘制": "2.06",
    "数据分类统计表构建与扇形图绘制": "2.06",
    "数学读本意见调查统计表与扇形图": "2.06",
    "书籍分类扇形统计图": "2.06",
    "市民热线分类统计与扇形图": "2.06",
    "环保知识测试成绩统计分析与扇形图": "2.06",
    
    # §2.7 条形图与扇形图综合
    "季度销量条形与扇形综合": "2.07",
    "条形统计图与扇形统计图综合": "2.07",
    "条形与扇形统计图的综合分析": "2.07",
    "综合成绩统计、图表补全与扇形图比例": "2.07",
    "母亲节调查双统计图": "2.07",
    "社团课程选择双统计图": "2.07",
    "书香校园阅读意向调查": "2.07",
    
    # §2.8 频数直方图
    "身体素质测试频数分布与直方图": "2.08",
    "雷达测速频数分布与直方图": "2.08",
    "跳绳成绩频数分布与直方图": "2.08",
    "果园结果数量频数分布与直方图": "2.08",
    "抽样调查与身高频数分布": "2.08",
    "区间频数分布直方图与补全推断": "2.08",
    "频数直方图与扇形图综合分析": "2.08",
    "数据的分段整理与直方图绘制": "2.08",
    
    # §2.9 概率频率折线图
    "正四面体抛掷概率与频率折线图": "2.09",
    "摸球试验概率估计与频率折线图": "2.09",
    "随机事件频率与概率折线统计图": "2.09",
    "瓶盖正面朝上频率折线图与概率估计": "2.09",
    
    # §2.10 正比例图像
    "探究总价与长度的正比例关系图像": "2.10",
    
    # §2.11 统计方案与图表选择
    "校服式样调查及结果分析": "2.11",
    "数据统计整理与图表选择绘制": "2.11",
    "班级调查方案与统计图绘制": "2.11",
    "选择合适的统计图表": "2.11",
    "数据的收集与整理": "2.11",
    "横向统计图的识别与制备": "2.11",
    "原始数据记录与统计图表转化": "2.11",
    
    # §2.12 转盘涂色
    "按要求给转盘涂色": "2.12",
    
    # §3.1 填表题（正反比例）
    "48个同学去乘船": "3.01",
    "成反比例，把下表填写完整": "3.01",
    "把一根长24厘米的铁丝": "3.01",
    "4辆汽车运同样多的货物": "3.01",
    
    # §3.2 互化表
    "分数、小数、百分数互化填表": "3.02",
    
    # §3.3 数位顺序表
    "数位顺序表填写完整": "3.03",
    "经过每两个点最多可以画几条直线": "3.03",
    
    # §3.4 购买与运算表格
    "世界上陆地面积最大": "3.04",
    "体育用品商店购买问题": "3.04",
    "假设法解决问题": "3.04",
    
    # §3.5 代数运算填表
    "整式算术运算法则及公式填表": "3.05",
    "方程的意义与特征判断": "3.05",
    
    # §3.6 频数统计表
    "抛正方体可能的点数": "3.06",
    "九年级学生视力情况频数分布表": "3.06",
    "体检等候时间频数与百分比": "3.06",
    "景点意向划记调查表": "3.06",
    "六年级一班女生1分钟跳绳成绩统计表": "3.06",
    
    # §4.1 连线题
    "连线题": "4.01",
    "找出等式与方程并准确连线": "4.01",
    "代数式因式分解连线题": "4.01",
    "估一估，连一连": "4.01",
    
    # §5.1 行程问题线段图
    "行程问题线段图与计算": "5.01",
    "根据题意画线段图并解答": "5.01",
    "行程问题相遇点按比例标位": "5.01",
    "行程问题解析图": "5.01",
    
    # §5.2 和差问题线段图
    "和差问题——图书数量分配": "5.02",
    "三角形内角和与线段图求解": "5.02",
    "等腰三角形周长与线段图求解": "5.02",
    
    # §5.3 分数应用题线段图
    "分数应用题——足球与篮球的比例": "5.03",
    
    # §5.4 数轴与不等式
    "在数轴上表示不等式的解集": "5.04",
    "解不等式并在数轴表示": "5.04",
    "求解不等式并在数轴表示": "5.04",
    "求解不等式组并在数轴上确定解集": "5.04",
    "求解不等式组并在数轴上表示解集": "5.04",
    "不等式与不等式组的解集数轴表示": "5.04",
    "解一元一次不等式及数轴作图": "5.04",
    "求解不等式系统并辅以双轨数轴解析": "5.04",
    "综合不等式解法与双轨数轴制图": "5.04",
    "含分数系数的一元一次不等式": "5.04",
    "分数化简与数轴定位表示": "5.04",
    "多项分数化简与数轴同点位映射表示": "5.04",
    "含参不等式组的解集与数轴表示": "5.04",
    "解不等式（组）并在数轴上表示": "5.04",
    "解较复杂不等式并在数轴上表示": "5.04",
    "解不等式并在数轴上表示": "5.04",
    
    # §5.5 日历与其他
    "2016 年 2 月月历": "5.05",
    "2016年2月月历": "5.05",
    
    # §6.1 重力示意图
    "画出物体A所受的重力": "6.01",
    "画出斜面上物体受到的重力": "6.01",
    "斜面上小木块的受力和铅球的重力": "6.01",
    "不同运动状态与附着面下重力方向探究": "6.01",
    
    # §6.2 浮力示意图
    "画出漂浮在液面上的木块所受力": "6.02",
    "画出密度计在酒精中的大致位置": "6.02",
    "画出浸没在水中的小球所受浮力": "6.02",
    "画出试管转到竖直位置时的液面": "6.02",
    
    # §6.3 综合受力分析
    "画出下列各力的示意图": "6.03",
    "作图题（推力、单摆重力）": "6.03",
    "静止在水平地面上的木块受力示意图": "6.03",
    "木块滑行受力分析": "6.03",
    "抛出篮球上升与下落过程受力": "6.03",
    "铰链组合体受力与物体受拉力": "6.03",
    "作特定指定的局部力示意图": "6.03",
    
    # §6.4 弹簧测力计
    "探究弹簧测力计原理": "6.04",
    
    # §7.1 坐标图像
    "探究重力大小与质量的关系图像": "7.01",
    "m-V": "7.01",
}

def match_section_to_target(title):
    """根据标题子串匹配找到目标文件编号"""
    for keyword, target in TITLE_TO_TARGET.items():
        if keyword in title:
            return target
    return None

# ============================================================
# 主流程
# ============================================================
def main():
    print("=" * 70)
    print("K12 教辅绘图项目——自动化重构脚本")
    print("=" * 70)
    if DRY_RUN:
        print("*** 模拟运行模式 (--dry)，不会写入任何文件 ***\n")
    
    # 1. 收集所有源文件中的 sections
    source_files = []
    for subdir in ["数学", "物理"]:
        base = LATEX_DIR / subdir
        if base.exists():
            source_files.extend(sorted(base.rglob("*.tex")))
    
    # 添加 Temp_Work 文件
    temp_tex = TEMP_DIR / "temp_answer.tex"
    
    # 解析所有源文件的 sections
    all_sections = []  # [(src_file, title, content), ...]
    
    for src in source_files:
        with open(src, encoding="utf-8") as f:
            text = f.read()
        sections = split_into_sections(text)
        for title, content in sections:
            all_sections.append((str(src.relative_to(PROJECT)), title, content))
    
    # 解析 Temp_Work (它有独立的 \documentclass，需要提取 \begin{document}...\end{document}之间内容)
    if temp_tex.exists():
        with open(temp_tex, encoding="utf-8") as f:
            temp_text = f.read()
        # 提取 document 环境内的内容
        doc_match = re.search(r'\\begin\{document\}(.*?)\\end\{document\}', temp_text, re.DOTALL)
        if doc_match:
            body = doc_match.group(1)
            # Temp_Work 使用 \section*{} 格式
            temp_sections = split_into_sections(body)
            for title, content in temp_sections:
                all_sections.append(("Temp_Work/temp_answer.tex", title, content))
    
    print(f"共解析到 {len(all_sections)} 个逻辑小节\n")
    
    # 2. 将每个 section 分配到目标文件
    target_contents = {key: [] for key in NEW_FILES}  # target_id -> [(title, content)]
    unmatched = []
    
    for src_file, title, content in all_sections:
        if title == "__WHOLE_FILE__":
            # 整个文件没有标题的情况 —— 不应出现在正常文件中
            continue
        
        target = match_section_to_target(title)
        if target:
            target_contents[target].append((title, content, src_file))
        else:
            unmatched.append((src_file, title))
    
    # 报告未匹配的 sections
    if unmatched:
        print(f"⚠️  {len(unmatched)} 个 section 未匹配到目标文件:")
        for src, title in unmatched:
            print(f"   [{src}] {title}")
        print()
    
    # 统计
    total_assigned = sum(len(v) for v in target_contents.values())
    print(f"✅ 已分配 {total_assigned} 个 section 到 {len(NEW_FILES)} 个目标文件")
    
    # 3. 备份旧文件（将旧的按年级组织的文件重命名）
    backup_dir = LATEX_DIR / "_backup_before_restructure"
    if not DRY_RUN:
        if not backup_dir.exists():
            backup_dir.mkdir(parents=True, exist_ok=True)
        # 备份数学目录下的旧文件
        for subdir in ["数学", "物理"]:
            src_dir = LATEX_DIR / subdir
            dst_dir = backup_dir / subdir
            if src_dir.exists():
                if dst_dir.exists():
                    shutil.rmtree(dst_dir)
                shutil.copytree(src_dir, dst_dir)
        print(f"\n📦 旧文件已备份到: {backup_dir}")
    
    # 4. 清空旧目录并创建新目录结构
    if not DRY_RUN:
        for subdir in ["数学", "物理"]:
            old_dir = LATEX_DIR / subdir
            if old_dir.exists():
                shutil.rmtree(old_dir)
    
    # 5. 写入新文件
    tikz_total = 0
    tab_total = 0
    
    for target_id, (chapter, section_name, rel_path) in NEW_FILES.items():
        sections = target_contents[target_id]
        if not sections:
            print(f"   ⚠️ {rel_path} — 空文件（0 个 section）")
            continue
        
        # 构建文件内容
        file_header = (
            f"%!TEX root = ../../main.tex\n"
            f"% ============================================================\n"
            f"% {chapter} / {section_name}\n"
            f"% 本文件由 main.tex 通过 \\input 引入，请勿单独编译\n"
            f"% 重构日期: 2026-04-11\n"
            f"% ============================================================\n\n"
        )
        
        body_parts = []
        for title, content, src_file in sections:
            # 清理内容：去掉旧文件头部注释
            cleaned = content.strip()
            # 去除 %!TEX root 行
            cleaned = re.sub(r'^%!TEX\s+root\s*=.*\n', '', cleaned, flags=re.MULTILINE)
            cleaned = re.sub(r'^%!TEX\s+program\s*=.*\n', '', cleaned, flags=re.MULTILINE)
            # 去除旧的文件头部注释块
            cleaned = re.sub(
                r'^% =+\n% (?:数学|物理).*\n% 本文件由.*\n% =+\n',
                '', cleaned, flags=re.MULTILINE
            )
            # 去除旧的来源注释块
            cleaned = re.sub(
                r'^% =+\r?\n% 来源.*\r?\n% =+\r?\n',
                '', cleaned, flags=re.MULTILINE
            )
            
            # 修复 \begin{center} / \end{center} 平衡
            # 统计 begin/end center 数量
            begins = len(re.findall(r'\\begin\{center\}', cleaned))
            ends = len(re.findall(r'\\end\{center\}', cleaned))
            
            if ends > begins:
                # 多余的 \end{center} 在开头——删除开头多余的
                for _ in range(ends - begins):
                    cleaned = re.sub(r'^\s*\\end\{center\}\s*\n?', '', cleaned, count=1)
            elif begins > ends:
                # 多余的 \begin{center} 在结尾——删除结尾多余的
                for _ in range(begins - ends):
                    cleaned = re.sub(r'\n?\s*\\begin\{center\}\s*$', '', cleaned)
            
            cleaned = cleaned.strip()
            body_parts.append(cleaned.strip())
        
        file_content = file_header + "\n\n\\newpage\n\n".join(body_parts) + "\n"
        
        # 统计
        tikz_count = len(re.findall(r'\\begin\{tikzpicture\}', file_content))
        tab_count = len(re.findall(r'\\begin\{tabular\}', file_content))
        tikz_total += tikz_count
        tab_total += tab_count
        
        # 写入文件
        out_path = LATEX_DIR / rel_path
        if not DRY_RUN:
            out_path.parent.mkdir(parents=True, exist_ok=True)
            with open(out_path, "w", encoding="utf-8") as f:
                f.write(file_content)
        
        print(f"   ✅ {rel_path} — {len(sections)} sections, {tikz_count} tikz, {tab_count} tabular")
    
    print(f"\n📊 重构后统计: {tikz_total} tikzpicture, {tab_total} tabular")
    
    # 6. 生成新的 main.tex
    generate_main_tex()
    
    # 7. 验证
    print("\n" + "=" * 70)
    print("重构完成！")
    if not DRY_RUN:
        print(f"旧文件备份位于: {backup_dir}")
    print("=" * 70)

def generate_main_tex():
    """生成新的 main.tex"""
    chapters = OrderedDict()
    for target_id, (chapter, section_name, rel_path) in NEW_FILES.items():
        part = "数学" if rel_path.startswith("数学") else "物理"
        if (part, chapter) not in chapters:
            chapters[(part, chapter)] = []
        # 去掉文件扩展名
        input_path = rel_path.replace(".tex", "")
        chapters[(part, chapter)].append((section_name, input_path))
    
    lines = [
        "%!TEX root = main.tex",
        "%!TEX program = xelatex",
        "",
        "% ============================================================",
        "% K12 教辅绘图项目 — 主文件 (按绘图类型重构)",
        "% 编译方式：xelatex main.tex",
        "% 重构日期: 2026-04-11",
        "% ============================================================",
        "",
        "\\input{preamble}",
        "",
        "\\begin{document}",
        "",
        "\\tableofcontents",
        "",
        "\\newpage",
        "",
    ]
    
    current_part = None
    current_chapter = None
    
    for (part, chapter), sections in chapters.items():
        if part != current_part:
            lines.append(f"% ============================================================")
            lines.append(f"%   第{'一' if part == '数学' else '二'}部分：{part}")
            lines.append(f"% ============================================================")
            lines.append(f"\\part{{{part}}}")
            lines.append("")
            current_part = part
        
        if chapter != current_chapter:
            lines.append(f"% ------ {chapter} ------")
            lines.append(f"\\chapter{{{chapter}}}")
            lines.append("")
            current_chapter = chapter
        
        for sec_name, input_path in sections:
            lines.append(f"\\section{{{sec_name}}}")
            lines.append(f"\\input{{{input_path}}}")
            lines.append("")
    
    lines.append("\\end{document}")
    lines.append("")
    
    content = "\r\n".join(lines)
    
    if not DRY_RUN:
        main_path = LATEX_DIR / "main.tex"
        with open(main_path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"\n✅ 新的 main.tex 已生成")
    else:
        print(f"\n[DRY] 将生成新的 main.tex")

if __name__ == "__main__":
    main()
