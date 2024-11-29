-- Create Users table
CREATE TABLE IF NOT EXISTS SMART_PAY_USERS (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL
);

-- Create Payment Methods table
CREATE TABLE IF NOT EXISTS SMART_PAY_PAYMENT_METHODS (
    method_id SERIAL PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    method_details JSONB NOT NULL
);

-- Create Currencies table
CREATE TABLE IF NOT EXISTS SMART_PAY_CURRENCIES (
    currency_code CHAR(3) PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL,
    symbol VARCHAR(5) NOT NULL
);

-- Create Payment Status table
CREATE TABLE IF NOT EXISTS SMART_PAY_PAYMENT_STATUS (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

-- Create Payment Gateway table
CREATE TABLE IF NOT EXISTS SMART_PAY_PAYMENT_GATEWAY (
    gateway_id SERIAL PRIMARY KEY,
    gateway_name VARCHAR(100) UNIQUE NOT NULL,
    gateway_details JSONB NOT NULL
);

-- Create Country table
CREATE TABLE IF NOT EXISTS SMART_PAY_COUNTRY (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL UNIQUE
);

-- Create Orders table
CREATE TABLE IF NOT EXISTS SMART_PAY_ORDERS (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES USERS(user_id),
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    currency_code CHAR(3) NOT NULL REFERENCES CURRENCIES(currency_code),
    status_id INT NOT NULL REFERENCES PAYMENT_STATUS(status_id)
);

-- Create Transactions table
CREATE TABLE IF NOT EXISTS SMART_PAY_TRANSACTIONS (
    transaction_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES USERS(user_id),
    order_id INT NOT NULL REFERENCES ORDERS(order_id),
    method_id INT NOT NULL REFERENCES PAYMENT_METHODS(method_id),
    amount DECIMAL(10, 2) NOT NULL,
    currency_code CHAR(3) NOT NULL REFERENCES CURRENCIES(currency_code),
    status_id INT NOT NULL REFERENCES PAYMENT_STATUS(status_id),
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gateway_id INT NOT NULL REFERENCES PAYMENT_GATEWAY(gateway_id),
    country_id INT NOT NULL REFERENCES COUNTRY(country_id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL
);

-- Create Audit Logs table
CREATE TABLE IF NOT EXISTS SMART_PAY_AUDIT_LOGS (
    log_id SERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    operation_type VARCHAR(10) NOT NULL,
    operation_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    old_data JSONB,
    new_data JSONB,
    user_id INT NOT NULL REFERENCES USERS(user_id)
);
