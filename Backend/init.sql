-- 创建数据库
CREATE DATABASE IF NOT EXISTS trading DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE trading;

-- 创建交易数据表
CREATE TABLE IF NOT EXISTS trading_data (
    symbol VARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    open_price DECIMAL(20, 4) NOT NULL,
    close_price DECIMAL(20, 4) NOT NULL,
    high DECIMAL(20, 4) NOT NULL,
    low DECIMAL(20, 4) NOT NULL,
    volume BIGINT NOT NULL,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (symbol, date),
    INDEX idx_symbol_date (symbol, date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交易数据表';

-- 创建股票信息表
CREATE TABLE IF NOT EXISTS symbol_info (
    symbol VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL COMMENT '股票名称',
    listing_date DATE NULL COMMENT '上市时间',
    status VARCHAR(20) NOT NULL DEFAULT 'active' COMMENT '状态：active,delisted',
    description VARCHAR(500) NULL COMMENT '描述',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (symbol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='股票基本信息表';