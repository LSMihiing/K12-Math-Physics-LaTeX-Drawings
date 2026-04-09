# -*- coding: utf-8 -*-
"""
rename_and_move.py
1. Rename sub-tex files to descriptive names
2. Move original files to 原始文件/
3. Update main.tex with new paths
"""
import os, shutil

BASE = r'c:\Users\lsmihiing\Desktop\02 智羚学伴 26春教辅 智书粗加工\2支援小学数学'

# ===== 手工定义的描述性文件名映射 =====
# 格式: (旧路径, 新路径)   — 均相对于 BASE
RENAME_MAP = [
    # ---- 数学/几何作图 ----
    (r'数学\几何作图\三年级.tex',  r'数学\几何作图\三年级_画角·画线段·涂色分数·平行与垂直.tex'),
    (r'数学\几何作图\四年级.tex',  r'数学\几何作图\四年级_三角形画高·平行四边形·梯形·画角·多边形分割·小数涂色·描点.tex'),
    (r'数学\几何作图\五年级.tex',  r'数学\几何作图\五年级_三角形分割·图形平移与面积·同底等高·点子图·观察物体.tex'),
    (r'数学\几何作图\六年级.tex',  r'数学\几何作图\六年级_长方形扩建正方形·比例尺方向·图形放大缩小·六边形分数涂色.tex'),
    (r'数学\几何作图\七年级.tex',  r'数学\几何作图\七年级_垂直平分线·角平分线·旋转·对称·平移·全等·尺规作图·网格变换.tex'),

    # ---- 数学/统计图表 ----
    (r'数学\统计图表\三年级.tex',  r'数学\统计图表\三年级_正字统计·条形统计图·球类统计.tex'),
    (r'数学\统计图表\四年级.tex',  r'数学\统计图表\四年级_数据收集·复式条形统计图·复式折线统计图·转盘涂色.tex'),
    (r'数学\统计图表\六年级.tex',  r'数学\统计图表\六年级_正比例图像·折线统计图.tex'),
    (r'数学\统计图表\七年级.tex',  r'数学\统计图表\七年级_频数直方图·扇形图·概率折线图·复式折线图·条形图补全.tex'),

    # ---- 数学/数据表格 ----
    (r'数学\数据表格\三年级.tex',  r'数学\数据表格\三年级_数位顺序表·竖排表格.tex'),
    (r'数学\数据表格\四年级.tex',  r'数学\数据表格\四年级_体育用品购买·假设法·大数认识·连线题.tex'),
    (r'数学\数据表格\六年级.tex',  r'数学\数据表格\六年级_反比例填表·正比例填表·分数小数百分数互化.tex'),
    (r'数学\数据表格\七年级.tex',  r'数学\数据表格\七年级_因式分解连线·整式运算填表.tex'),

    # ---- 数学/线段图 ----
    (r'数学\线段图\三年级.tex',  r'数学\线段图\三年级_路线与距离·估算连线.tex'),
    (r'数学\线段图\四年级.tex',  r'数学\线段图\四年级_行程问题·和差问题·三角形内角和·等腰三角形周长.tex'),
    (r'数学\线段图\五年级.tex',  r'数学\线段图\五年级_行程相遇点.tex'),
    (r'数学\线段图\六年级.tex',  r'数学\线段图\六年级_分数应用题·足球篮球比例.tex'),
    (r'数学\线段图\七年级.tex',  r'数学\线段图\七年级_一元一次不等式·不等式组·数轴表示.tex'),

    # ---- 物理 ----
    (r'物理\力学作图\八年级.tex',  r'物理\力学作图\八年级_重力·压力·浮力·摩擦力·支持力·弹簧测力计.tex'),
    (r'物理\坐标图像\八年级.tex',  r'物理\坐标图像\八年级_G-m关系图像·m-V关系图像.tex'),
]

# ===== Step 1: Execute renames =====
print("===== 重命名 =====")
for old_rel, new_rel in RENAME_MAP:
    old_path = os.path.join(BASE, old_rel)
    new_path = os.path.join(BASE, new_rel)
    if os.path.exists(old_path):
        os.makedirs(os.path.dirname(new_path), exist_ok=True)
        os.rename(old_path, new_path)
        print(f"  {old_rel}")
        print(f"    → {new_rel}")
    else:
        print(f"  ⚠ 不存在: {old_rel}")

# ===== Step 2: Update main.tex =====
main_path = os.path.join(BASE, 'main.tex')
with open(main_path, encoding='utf-8') as f:
    main_content = f.read()

for old_rel, new_rel in RENAME_MAP:
    old_input = old_rel.replace('\\', '/').replace('.tex', '')
    new_input = new_rel.replace('\\', '/').replace('.tex', '')
    main_content = main_content.replace(old_input, new_input)

with open(main_path, 'w', encoding='utf-8') as f:
    f.write(main_content)
print("\n✓ main.tex 已更新")

# ===== Step 3: Move original files to 原始文件/ =====
archive_dir = os.path.join(BASE, '原始文件')
os.makedirs(archive_dir, exist_ok=True)

keep_items = {'main.tex', 'preamble.tex', 'README.md', '.gitignore', '.git',
              '数学', '物理', '原始文件'}

print("\n===== 归档原始文件 =====")
for item in os.listdir(BASE):
    if item in keep_items:
        continue
    src = os.path.join(BASE, item)
    dst = os.path.join(archive_dir, item)
    if os.path.exists(dst):
        if os.path.isdir(dst):
            shutil.rmtree(dst)
        else:
            os.remove(dst)
    shutil.move(src, dst)
    print(f"  {item} → 原始文件/{item}")

print("\n✓ 全部完成!")
