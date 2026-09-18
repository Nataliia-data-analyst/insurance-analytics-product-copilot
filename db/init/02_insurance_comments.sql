COMMENT ON TABLE insurance_products IS
'Insurance products offered by the company. One product can be associated with many insurance policies.';

COMMENT ON TABLE customers IS
'Insurance customers. A customer may hold multiple policies.';

COMMENT ON TABLE policies IS
'Insurance contracts between customers and the insurer. Represents policy coverage, written premium, deductible and policy period.';

COMMENT ON COLUMN policies.annual_written_premium IS
'Annual premium associated with the policy contract. This is written premium and should not be treated as earned premium or cash received.';


COMMENT ON TABLE premium_transactions IS
'Premium accounting transactions used to analyze written and earned premium over time.';

COMMENT ON COLUMN premium_transactions.written_premium IS
'Premium recognized as written business. Written premium should not be used directly as the denominator for an earned-period loss ratio.';

COMMENT ON COLUMN premium_transactions.earned_premium IS
'Premium attributable to insurance coverage already provided during the reporting period. Used as the premium basis for loss ratio analysis.';


COMMENT ON TABLE claims IS
'Insurance claims reported against policies. Contains current claim status, reported amount and current outstanding reserve.';

COMMENT ON COLUMN claims.reported_claim_amount IS
'Amount initially reported or estimated for the claim. It is not equivalent to the final claim cost.';

COMMENT ON COLUMN claims.current_reserve_amount IS
'Current estimated outstanding liability for the claim. Do not interpret this as cash already paid.';


COMMENT ON TABLE claim_payments IS
'Individual financial payments associated with insurance claims. Only completed payments should normally be included when calculating paid claim amounts.';

COMMENT ON COLUMN claim_payments.payment_amount IS
'Amount of an individual claim payment. Payment records may require validation for duplicates, cancellations and payment status before aggregation.';


COMMENT ON TABLE claim_reserve_history IS
'Historical snapshots of claim reserves. Used to analyze reserve development and identify changes in expected claim costs over time.';


COMMENT ON TABLE claim_events IS
'Operational history of claim processing events. Can be used to reconstruct the claim lifecycle and identify processing bottlenecks.';

COMMENT ON TABLE claim_handlers IS
'Claims employees responsible for processing claims. Handlers belong to operational claims teams.';

COMMENT ON TABLE claims_teams IS
'Operational teams responsible for claims processing.';

COMMENT ON TABLE service_requests IS
'Operational requests associated with claims. Used to analyze workload, resolution time, backlog and service performance.';


COMMENT ON TABLE budgets IS
'Monthly operational budgets by cost center.';

COMMENT ON TABLE actual_costs IS
'Actual operational costs incurred by cost centers. Used for budget variance and operating cost analysis.';