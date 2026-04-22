const fs = require('fs');
const path = require('path');

const dirs = [
    "../LaTeX_Project/数学/统计图表", "../LaTeX_Project/数学/线段图", "../LaTeX_Project/数学/几何作图", 
    "../LaTeX_Project/数学/数据表格", "../LaTeX_Project/物理/力学作图", "../LaTeX_Project/物理/坐标图像"
];

const replacements = [
    [/极度复杂/g, "复杂"],
    [/神仙技巧/g, "技巧"],
    [/巧夺天工/g, ""],
    [/完美贴合（了）?/g, "匹配"],
    [/完美重构/g, "重构"],
    [/完美复原/g, "复原"],
    [/教科书式/g, ""],
    [/极其重要/g, "重要"],
    [/毫无偏差/g, "无偏差"],
    [/绝对精细/g, "精细"],
    [/极其逼真/g, "逼真"],
    [/逼真/g, "准确"],
    [/优美的?/g, ""],
    [/非常生动标准/g, "标准"],
    [/灵魂/g, ""],
    [/绝不失真/g, "不失真"],
    [/绝不/g, "不"],
    [/完美/g, ""],
    [/极其/g, ""],
    [/绝佳/g, ""],
    [/极度/g, ""],
    [/强迫症(\S+无可挑剔)?/g, ""],
    [/无可挑剔/g, ""],
    [/花哨/g, ""],
    [/大满贯/g, ""],
    [/暴力的?/g, "直接的"],
    [/纯粹的?/g, ""],
    [/神仙/g, ""],
    [/完美契合/g, "契合"],
    [/极大简化/g, "简化"],
    [/视觉和谐/g, "对齐"],
    [/百分百/g, "完全"],
    [/严丝合缝/g, "对齐"],
    [/令人惊叹/g, ""],
    [/优雅/g, ""],
    [/漂亮的?/g, ""],
    [/顺滑/g, ""],
    [/复杂嵌套宏模式/g, "嵌套模式"],
    [/天衣无缝/g, "无缝"],
    [/无缝/g, ""],
    [/一脉随之/g, ""],
    [/极其精密/g, "精密"],
    [/至真至简/g, "简洁"],
    [/尊严/g, ""],
    [/视觉容差度/g, "清晰度"],
    [/降维/g, "简化"],
    [/绝对的?/g, ""],
    [/异常离奇的?/g, ""],
    [/离奇的?/g, ""],
    [/极其致命的?/g, "致命的"],
    [/彻底无可挽回的?/g, ""],
    [/鬼斧神工般/g, ""],
    [/磅礴/g, ""],
    [/蛮不讲理/g, ""],
    [/毁天灭地/g, ""],
    [/大灾厄级别/g, ""],
    [/脱离躲闪机制/g, "分离机制"],
    [/天梯神针/g, "标识"],
    [/非常规异常浮点/g, "非整数点"],
    [/全息投影/g, "映射"],
    [/阴阳立体穿戴结构锁链/g, "结构"],
    [/魔法罩/g, "框架"],
    [/红心大饼实心图鉴/g, "实心圆点"],
    [/这不为人知的/g, ""],
    [/捍卫这一尺度/g, "保持尺度"],
    [/剥光所有的外层伪装/g, "化简核心"],
    [/直抵靶心和/g, ""],
    [/清爽的最简裸干形式/g, "最简形式"],
    [/上帝视角/g, "默认视角"],
    [/暴力转正/g, "转换"],
    [/全线交叉/g, "交叉"],
    [/狂野线条/g, "线条"],
    [/致命层级/g, "层级"],
    [/恶性事故/g, "错误"],
    [/糊作成为一片无解纠缠黏连肉块团/g, "导致视觉混淆"],
    [/生拔起了一道直击大道的无比宏伟、超然视错觉双色极光时空量子通道天桥大回廊/g, "双色分离展现了解集"],
    [/真理之眼凝视前庭中/g, "图中"],
    [/剥皮剖开展铺奉在了/g, "展示在"]
];

let filesModified = 0;

function cleanContent(content) {
    let newContent = content;
    for (const [pattern, replacement] of replacements) {
        newContent = newContent.replace(pattern, replacement);
    }

    // Clean remaining ugly grammar artifacts from replacing (like replacing "" before "地" leaving " 地")
    newContent = newContent.replace(/的地/g, "地");
    newContent = newContent.replace(/地地/g, "地");

    return newContent;
}

function walkDir(currentDir) {
    if (!fs.existsSync(currentDir)) return;
    const files = fs.readdirSync(currentDir);
    for (const file of files) {
        const fullPath = path.join(currentDir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            walkDir(fullPath);
        } else if (fullPath.endsWith('.tex')) {
            const content = fs.readFileSync(fullPath, 'utf8');
            const newContent = cleanContent(content);
            if (content !== newContent) {
                fs.writeFileSync(fullPath, newContent, 'utf8');
                filesModified++;
                console.log(`Cleaned: ${fullPath}`);
            }
        }
    }
}

dirs.forEach(d => walkDir(d));
console.log(`\nComplete! Modified ${filesModified} files globally.`);
