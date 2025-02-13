# Financial Freedom - 量化交易回测系统

## 项目概述

本项目是一个功能完整的量化交易回测系统，专注于股票市场的策略开发和回测。系统采用Python开发，集成了数据获取、策略回测、性能分析和通知推送等功能，帮助投资者在实盘交易前验证策略的有效性。

## 核心功能

### 1. 数据获取（Fetcher）
- 支持从YFinance获取实时和历史股票数据
- 多线程并发数据获取，提高效率
- 自动处理数据更新和存储
- 支持定时任务自动更新数据

### 2. 策略回测（Backtest）
- 基于backtrader框架的策略回测系统
- 支持多种交易策略组合
- 详细的交易记录和性能分析
- 支持参数优化和网格搜索

### 3. 性能分析（Analyzers）
- 完整的策略性能指标计算
- 包括夏普比率、最大回撤、年化收益等
- 支持与基准的对比分析
- 详细的交易统计和风险评估

### 4. 通知系统（Notify）
- 支持邮件和企业微信通知
- 自定义通知模板
- 实时交易信号推送
- 定期报告生成

## 策略算法说明

### 双均线策略
系统默认实现了经典的双均线交易策略，具体参数包括：

- 短期均线周期（默认5日）
- 长期均线周期（默认20日）
- 止损方式：
  - 吊灯止损（Chandelier Exit）
  - ADR（Average Daily Range）止损

### 主要参数说明

1. 均线参数
   - `short_period`：短期均线周期，范围通常5-10天
   - `long_period`：长期均线周期，范围通常15-30天

2. 吊灯止损参数
   - `chandelier_period`：ATR计算周期，默认22天
   - `chandelier_multiplier`：ATR乘数，默认3.0

3. ADR止损参数
   - `adr_period`：ADR计算周期，默认20天
   - `adr_multiplier`：ADR乘数，默认1.0

## 部署步骤

### 1. 环境准备

```bash
# 克隆项目
git clone https://github.com/1eez/Financial-Freedom.git
cd Financial-Freedom

# 创建虚拟环境
python -m venv venv
source venv/bin/activate  # Windows使用: .\venv\Scripts\activate

# 安装依赖
cd Backend
pip install -r requirements.txt
```

### 2. 数据库配置

1. 创建MySQL数据库
```sql
CREATE DATABASE financial_freedom CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 配置环境变量
```bash
cp Backend/.env.template Backend/.env
```

编辑.env文件，填入以下信息：
```ini
# 数据库配置
DB_HOST=localhost
DB_PORT=3306
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=financial_freedom

# 邮件配置（可选）
SMTP_SERVER=smtp.example.com
SMTP_PORT=587
SMTP_USERNAME=your_email@example.com
SMTP_PASSWORD=your_email_password
EMAIL_RECIPIENTS=recipient1@example.com,recipient2@example.com

# 企业微信配置（可选）
WECOM_BOT_WEBHOOK=your_wecom_webhook_url
```

3. 初始化数据库
```bash
mysql -u your_username -p financial_freedom < Backend/init.sql
```

### 3. 数据获取

```bash
python -m Backend.fetcher --symbol AAPL  # 获取单个股票数据
# 或
python -m Backend.fetcher  # 获取所有已配置的股票数据
```

### 4. 运行回测

```bash
python -m Backend.backtest AAPL \
    --start-date 2023-01-01 \
    --end-date 2023-12-31 \
    --initial-capital 100000 \
    --use-ma \
    --ma-short 5 \
    --ma-long 20 \
    --use-chandelier \
    --chandelier-period 22 \
    --chandelier-multiplier 3.0 \
    --notify email
```

### 5. 查看结果

回测结果将以以下方式展示：
- 控制台输出详细的回测指标
- 可选的HTML报告生成
- 可选的邮件/企业微信通知

## 注意事项

1. 确保MySQL服务已启动并正确配置
2. 使用邮件通知功能需要正确配置SMTP服务器信息
3. 企业微信通知需要配置有效的Webhook地址
4. 建议在虚拟环境中运行项目，避免依赖冲突
5. 数据获取可能受到YFinance API的限制，建议合理控制请求频率
