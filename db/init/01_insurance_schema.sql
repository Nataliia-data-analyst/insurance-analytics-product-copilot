CREATE TABLE insurance_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_line VARCHAR(50) NOT NULL,
    product_category VARCHAR(50),
    risk_category VARCHAR(20),
    active BOOLEAN NOT NULL DEFAULT TRUE
);


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_segment VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    region VARCHAR(100),
    age_group VARCHAR(20),
    acquisition_channel VARCHAR(50),
    customer_since DATE NOT NULL
);


CREATE TABLE policies (
    policy_id SERIAL PRIMARY KEY,

    customer_id INTEGER NOT NULL
        REFERENCES customers(customer_id),

    product_id INTEGER NOT NULL
        REFERENCES insurance_products(product_id),

    policy_number VARCHAR(50) NOT NULL UNIQUE,

    policy_start_date DATE NOT NULL,
    policy_end_date DATE NOT NULL,

    annual_written_premium NUMERIC(12,2) NOT NULL,
    coverage_amount NUMERIC(14,2),
    deductible_amount NUMERIC(12,2),

    policy_status VARCHAR(20) NOT NULL,
    sales_channel VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    region VARCHAR(100),

    currency CHAR(3) NOT NULL DEFAULT 'EUR',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (policy_end_date >= policy_start_date),
    CHECK (annual_written_premium >= 0),
    CHECK (coverage_amount >= 0),
    CHECK (deductible_amount >= 0)
);

CREATE TABLE premium_transactions (
    premium_transaction_id SERIAL PRIMARY KEY,

    policy_id INTEGER NOT NULL
        REFERENCES policies(policy_id),

    transaction_date DATE NOT NULL,

    transaction_type VARCHAR(30) NOT NULL,

    written_premium NUMERIC(12,2) NOT NULL DEFAULT 0,
    earned_premium NUMERIC(12,2) NOT NULL DEFAULT 0,

    currency CHAR(3) NOT NULL DEFAULT 'EUR',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (written_premium >= 0),
    CHECK (earned_premium >= 0),

    CHECK (
        transaction_type IN (
            'NEW_BUSINESS',
            'RENEWAL',
            'ADJUSTMENT',
            'CANCELLATION',
            'EARNING'
        )
    )
);

CREATE TABLE claim_types (
    claim_type_id SERIAL PRIMARY KEY,

    claim_type_name VARCHAR(100) NOT NULL,
    claim_category VARCHAR(50) NOT NULL,

    description TEXT
);


CREATE TABLE claims (
    claim_id SERIAL PRIMARY KEY,

    policy_id INTEGER NOT NULL
        REFERENCES policies(policy_id),

    claim_type_id INTEGER NOT NULL
        REFERENCES claim_types(claim_type_id),

    claim_number VARCHAR(50) NOT NULL UNIQUE,

    incident_date DATE NOT NULL,
    reported_date DATE NOT NULL,
    closed_date DATE,

    claim_status VARCHAR(30) NOT NULL,
    severity VARCHAR(20) NOT NULL,

    reported_claim_amount NUMERIC(14,2) NOT NULL DEFAULT 0,
    current_reserve_amount NUMERIC(14,2) NOT NULL DEFAULT 0,

    currency CHAR(3) NOT NULL DEFAULT 'EUR',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (reported_date >= incident_date),
    CHECK (closed_date IS NULL OR closed_date >= reported_date),

    CHECK (reported_claim_amount >= 0),
    CHECK (current_reserve_amount >= 0),

    CHECK (
        claim_status IN (
            'REPORTED',
            'UNDER_REVIEW',
            'APPROVED',
            'REJECTED',
            'CLOSED'
        )
    ),

    CHECK (
        severity IN (
            'LOW',
            'MEDIUM',
            'HIGH',
            'CATASTROPHIC'
        )
    )
);CREATE TABLE claim_payments (
    claim_payment_id SERIAL PRIMARY KEY,

    claim_id INTEGER NOT NULL
        REFERENCES claims(claim_id),

    payment_date DATE NOT NULL,
    payment_amount NUMERIC(14,2) NOT NULL,

    payment_type VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,

    currency CHAR(3) NOT NULL DEFAULT 'EUR',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (payment_amount >= 0),

    CHECK (
        payment_type IN (
            'INDEMNITY',
            'LEGAL',
            'MEDICAL',
            'REPAIR',
            'OTHER'
        )
    ),

    CHECK (
        payment_status IN (
            'PENDING',
            'COMPLETED',
            'CANCELLED'
        )
    )
);


CREATE TABLE claim_reserve_history (
    reserve_history_id SERIAL PRIMARY KEY,

    claim_id INTEGER NOT NULL
        REFERENCES claims(claim_id),

    reserve_date DATE NOT NULL,
    reserve_amount NUMERIC(14,2) NOT NULL,

    change_reason VARCHAR(100),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CHECK (reserve_amount >= 0)
);

CREATE TABLE claims_teams (
    team_id SERIAL PRIMARY KEY,

    team_name VARCHAR(100) NOT NULL,
    business_unit VARCHAR(100),
    country VARCHAR(50) NOT NULL,

    active BOOLEAN NOT NULL DEFAULT TRUE
);


CREATE TABLE claim_handlers (
    handler_id SERIAL PRIMARY KEY,

    team_id INTEGER NOT NULL
        REFERENCES claims_teams(team_id),

    handler_code VARCHAR(50) NOT NULL UNIQUE,
    experience_level VARCHAR(20) NOT NULL,

    active BOOLEAN NOT NULL DEFAULT TRUE,

    CHECK (
        experience_level IN (
            'JUNIOR',
            'MID',
            'SENIOR'
        )
    )
);


CREATE TABLE claim_events (
    event_id SERIAL PRIMARY KEY,

    claim_id INTEGER NOT NULL
        REFERENCES claims(claim_id),

    handler_id INTEGER
        REFERENCES claim_handlers(handler_id),

    event_timestamp TIMESTAMP NOT NULL,

    event_type VARCHAR(50) NOT NULL,

    previous_status VARCHAR(30),
    new_status VARCHAR(30),

    notes TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE service_requests (
    request_id SERIAL PRIMARY KEY,

    claim_id INTEGER NOT NULL
        REFERENCES claims(claim_id),

    handler_id INTEGER
        REFERENCES claim_handlers(handler_id),

    request_type VARCHAR(50) NOT NULL,
    priority VARCHAR(20) NOT NULL,

    created_at TIMESTAMP NOT NULL,
    resolved_at TIMESTAMP,

    status VARCHAR(20) NOT NULL,

    CHECK (resolved_at IS NULL OR resolved_at >= created_at),

    CHECK (
        priority IN (
            'LOW',
            'MEDIUM',
            'HIGH',
            'CRITICAL'
        )
    ),

    CHECK (
        status IN (
            'OPEN',
            'IN_PROGRESS',
            'RESOLVED',
            'CANCELLED'
        )
    )
);

CREATE TABLE business_units (
    business_unit_id SERIAL PRIMARY KEY,

    business_unit_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,

    active BOOLEAN NOT NULL DEFAULT TRUE
);


CREATE TABLE cost_centers (
    cost_center_id SERIAL PRIMARY KEY,

    business_unit_id INTEGER NOT NULL
        REFERENCES business_units(business_unit_id),

    cost_center_name VARCHAR(100) NOT NULL,
    cost_category VARCHAR(50) NOT NULL,

    active BOOLEAN NOT NULL DEFAULT TRUE
);


CREATE TABLE budgets (
    budget_id SERIAL PRIMARY KEY,

    cost_center_id INTEGER NOT NULL
        REFERENCES cost_centers(cost_center_id),

    budget_month DATE NOT NULL,
    budget_amount NUMERIC(14,2) NOT NULL,

    currency CHAR(3) NOT NULL DEFAULT 'EUR',

    CHECK (budget_amount >= 0),

    UNIQUE (cost_center_id, budget_month)
);


CREATE TABLE actual_costs (
    cost_id SERIAL PRIMARY KEY,

    cost_center_id INTEGER NOT NULL
        REFERENCES cost_centers(cost_center_id),

    cost_date DATE NOT NULL,
    cost_category VARCHAR(50) NOT NULL,
    amount NUMERIC(14,2) NOT NULL,

    currency CHAR(3) NOT NULL DEFAULT 'EUR',

    description VARCHAR(255),

    CHECK (amount >= 0)
);

